-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if GetResourceState('qb-core') ~= 'started' then return end
QBCore = exports['qb-core']:GetCoreObject()
Framework, PlayerLoaded, PlayerData = 'qb', nil, {}

AddStateBagChangeHandler('isLoggedIn', '', function(_bagName, _key, value, _reserved, _replicated)
    if value then
        PlayerData = QBCore.Functions.GetPlayerData()
    else
        table.wipe(PlayerData)
    end
    PlayerLoaded = value
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not LocalPlayer.state.isLoggedIn then return end
    PlayerData = QBCore.Functions.GetPlayerData()
    PlayerLoaded = true
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    TriggerEvent('wasabi_ambulance:setJob', job.name)
    PlayerData = QBCore.Functions.GetPlayerData()
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

AddEventHandler('gameEventTriggered', function(event, data)
	if event ~= 'CEventNetworkEntityDamage' then return end
	local victim, victimDied = data[1], data[4]
	if not IsPedAPlayer(victim) then return end
	local player = PlayerId()
	if victimDied and NetworkGetPlayerIndexFromPed(victim) == player and (IsPedDeadOrDying(victim, true) or IsPedFatallyInjured(victim))  then
        TriggerEvent('wasabi_police:onPlayerDeath')
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('wasabi_police:onPlayerSpawn')
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(newPlayerData)
    if source ~= '' and GetInvokingResource() ~= 'qb-core' then return end
    PlayerData = newPlayerData
end)

function HasGroup(filter)
    local groups = { 'job', 'gang' }
    local type = type(filter)

    if type == 'string' then
        for i = 1, #groups do
            local data = PlayerData[groups[i]]

            if data.name == filter then
                return data.name, data.grade.level
            end
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            for i = 1, #groups do
                local data = PlayerData[groups[i]]
                local grade = filter[data.name]

                if grade and grade <= data.grade.level then
                    return data.name, data.grade.level
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]

                for j = 1, #groups do
                    local data = PlayerData[groups[j]]

                    if data.name == group then
                        return data.name, data.grade.level
                    end
                end
            end
        end
    end
end

function GetGroup()
    local data = PlayerData['job']
    return data.name, data.grade.level
end

function GetIdentifier(target)
    return lib.callback.await('wasabi_police:getIdentifier', 100, GetPlayerServerId(target))
end

function IsOnDuty()
    if PlayerData.job.onduty then return true else return false end
end

function OpenBossMenu()
    TriggerEvent('qb-bossmenu:client:OpenMenu')
end

function GiveWeaponLicense(id)
    local granted = lib.callback.await('wasabi_police:grantLicense', 100, id)
    if granted then
        TriggerEvent('wasabi_police:notify', Strings.license_granted, (Strings.license_granted_desc):format(granted, id))
    else
        TriggerEvent('wasabi_police:notify', Strings.failed, Strings.license_alr_granted)
    end
end

local function checkIfDead(id)
    local isDead = lib.callback.await('wasabi_police:isPlayerDead', 100, id)
    return isDead
end

RegisterNetEvent('police:client:RobPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local closestPlayer = lib.getClosestPlayer(coords, 2.5, false)
    if closestPlayer then
        local targetPed = GetPlayerPed(closestPlayer)
        local targetId = GetPlayerServerId(closestPlayer)
        if IsEntityPlayingAnim(targetPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(targetPed, "mp_arresting", "idle", 3) or checkIfDead(targetId) then
            if lib.progressCircle({
                duration = math.random(5000, 7000),
                label = Strings.robbing_player,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true,
                },
                anim = {
                    dict = 'random@shop_robbery',
                    clip = 'robbery_action_b'
                },
            }) then
                TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", targetId)
                TriggerEvent("inventory:server:RobPlayer", targetId)
            else
                TriggerEvent('wasabi_police:notify', Strings.cancelled_action, Strings.cancelled_action_desc, 'error')
            end
        end
    else
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoft', function()
    TriggerEvent('wasabi_police:handcuffPlayer')
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    TriggerEvent('wasabi_police:inVehiclePlayer')
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    TriggerEvent('wasabi_police:outVehiclePlayer')
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    TriggerEvent('wasabi_police:escortPlayer')
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    TriggerEvent('wasabi_police:searchPlayer')
end)