-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if GetResourceState('es_extended') ~= 'started' then return end
ESX = exports['es_extended']:getSharedObject()
Framework, PlayerLoaded, PlayerData = 'esx', nil, {}

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerSpawn', function()
    TriggerEvent('wasabi_police:onPlayerSpawn')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    TriggerEvent('wasabi_police:onPlayerDeath')
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    table.wipe(PlayerData)
    PlayerLoaded = false
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName or not ESX.PlayerLoaded then return end
    PlayerData = ESX.GetPlayerData()
    PlayerLoaded = true
    if Config.UseRadialMenu then
        AddRadialItems()
    end
end)

AddEventHandler('esx:setPlayerData', function(key, value)
    if GetInvokingResource() ~= 'es_extended' then return end
    PlayerData[key] = value
end)

function HasGroup(filter)
    local type = type(filter)

    if type == 'string' then
        if PlayerData.job.name == filter then
            return PlayerData.job.name, PlayerData.job.grade
        end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            local grade = filter[PlayerData.job.name]

            if grade and grade <= PlayerData.job.grade then
                return PlayerData.job.name, PlayerData.job.grade
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                if PlayerData.job.name == filter[i] then
                    return PlayerData.job.name, PlayerData.job.grade
                end
            end
        end
    end
end

function GetGroup()
    return PlayerData.job.name, PlayerData.job.grade
end

function GetIdentifier(target)
    return lib.callback.await('wasabi_police:getIdentifier', 100, GetPlayerServerId(target))
end

function IsOnDuty()
    if PlayerData.job.name:sub(0, 3) == 'off' then
        return false
    else
        return true
    end
end

function OpenBossMenu()
    TriggerEvent('esx_society:openBossMenu', PlayerData.job.name, function(data, menu)
        menu.close()
    end, {wash = false})
end