-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
playerLoaded, isDead, isBusy, disableKeys, cuffProp, isCuffed, inMenu, isRagdoll, cuffTimer, escorting, escorted, GSRData = nil, nil, nil, nil, nil, nil, nil, nil, {}, {}, {}, {}

RegisterNetEvent('wasabi_police:tackled', function(targetId)
    getTackled(targetId)
end)

RegisterNetEvent('wasabi_police:tackle', function()
    tacklePlayer()
end)

AddEventHandler('wasabi_police:onPlayerSpawn', function()
    isDead = false
end)

AddEventHandler('wasabi_police:onPlayerDeath', function()
    isDead = true
    if isCuffed then
        uncuffed()
    end
    if escorting?.active then
        escorting.active = nil
        escorting.target = nil
    end
end)

AddEventHandler('wasabi_police:searchPlayer', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
    if not player then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    else
        searchPlayer(player)
    end
end)

AddEventHandler('wasabi_police:jailPlayer', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
    if not player then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    else
        local input = lib.inputDialog(Strings.minutes_dialog, {Strings.minutes_dialog_field})
        if not input then return end
        local quantity = math.floor(tonumber(input[1]))
        if quantity < 1 then
            TriggerEvent('wasabi_police:notify', Strings.invalid_amount, Strings.invalid_amount_desc, 'error')
        else
            TriggerEvent('wasabi_police:sendToJail', GetPlayerServerId(player), quantity)
        end
    end
end)

AddEventHandler('wasabi_police:grantLicense', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local closestPlayers = lib.getNearbyPlayers(vector3(coords.x, coords.y, coords.z), 10.0, false)
    if #closestPlayers < 1 then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
        return
    end
    local playerList = {}
    for i=1, #closestPlayers do
        playerList[#playerList + 1] = {
            id = GetPlayerServerId(closestPlayers[i].id)
        }
    end
    local nearbyPlayers = lib.callback.await('wasabi_police:getPlayerData', 100, playerList)
    local Options = {}
    for _,v in pairs(nearbyPlayers) do
        Options[#Options + 1] = {
            icon = 'user',
            label = v.name,
            description = Strings.player_id..' '..v.id,
            args = { id = v.id }
        }
    end
    lib.registerMenu({
        id = 'give_license_menu',
        title = Strings.select_player,
        position = Config.GrantWeaponLicenses.menuPosition,
        options = Options
    }, function(selected, scrollIndex, args)
        if selected then
            GiveWeaponLicense(args.id)
        end
    end)
    lib.showMenu('give_license_menu')
end)

AddEventHandler('wasabi_police:spawnVehicle', function(data)
    inMenu = false
    local model = data.model
    local category = Config.Locations[data.station].vehicles.options[data.grade][data.model].category
    local spawnLoc = Config.Locations[data.station].vehicles.spawn[category]
    if not IsModelInCdimage(GetHashKey(model)) then
        print('Vehicle model not found: '..model)
    else
        local nearbyVehicles = lib.getNearbyVehicles(vec3(spawnLoc.coords.x, spawnLoc.coords.y, spawnLoc.coords.z), 6.0, true)
        if #nearbyVehicles > 0 then
            TriggerEvent('wasabi_police:notify', Strings.spawn_blocked, Strings.spawn_blocked_desc, 'error')
            return
        end
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(100)
        end
        lib.requestModel(model, 100)
        local vehicle = CreateVehicle(GetHashKey(model), spawnLoc.coords.x, spawnLoc.coords.y, spawnLoc.coords.z, spawnLoc.heading, 1, 0)
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
        if Config.customCarlock then
            local plate = GetVehicleNumberPlateText(vehicle)
            addCarKeys(plate, model)
        end
        SetModelAsNoLongerNeeded(model)
        DoScreenFadeIn(800)
    end
end)

RegisterNetEvent('wasabi_police:arrested', function(pdId)
    isBusy = true
    local escaped
    local pdPed = GetPlayerPed(GetPlayerFromServerId(pdId))
    lib.requestAnimDict('mp_arrest_paired', 100)
    AttachEntityToEntity(cache.ped, pdPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(cache.ped, 'mp_arrest_paired', 'crook_p2_back_left', 8.0, -8.0, 5500, 33, 0, false, false, false)
    if Config.handcuff.skilledEscape.enabled then
        if lib.skillCheck(Config.handcuff.skilledEscape.difficulty) then
            escaped = true
        end
    end
	FreezeEntityPosition(pdPed, true)
    Wait(2000)
	DetachEntity(cache.ped, true, false)
	FreezeEntityPosition(pdPed, false)
    RemoveAnimDict('mp_arrest_paired')
    if not escaped then
        handcuffed()
    end
    isBusy = false
end)

RegisterNetEvent('wasabi_police:arrest', function()
    isBusy = true
    lib.requestAnimDict('mp_arrest_paired', 100)
    TaskPlayAnim(cache.ped, 'mp_arrest_paired', 'cop_p2_back_left', 8.0, -8.0, 3400, 33, 0, false, false, false)
    Wait(3000)
    isBusy = false
end)

RegisterNetEvent('wasabi_police:handcuffPlayer', function()
    local hasItem
    if Config.handcuff?.cuffItem?.enabled and Config.handcuff?.cuffItem?.required then
        hasItem = lib.callback.await('wasabi_police:itemCheck', 100, Config.handcuff.cuffItem.item)
    else
        hasItem = true
    end
    if not hasItem or hasItem == 0 then
        TriggerEvent('wasabi_police:notify', Strings.no_cuffs, Strings.no_cuffs_desc, 'error')
    else
        local coords = GetEntityCoords(cache.ped)
        local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
        if not player then
            TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
        else
            handcuffPlayer(GetPlayerServerId(player))
        end
    end
end)

RegisterNetEvent('wasabi_police:uncuffAnim', function(target)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
    local targetCoords = GetEntityCoords(targetPed)
    if escorting?.active then
        escorting.active = nil
        escorting.target = nil
    end
    TaskTurnPedToFaceCoord(cache.ped, targetCoords.x, targetCoords.y, targetCoords.z, 2000)
    Wait(2000)
    TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_PARKING_METER', 0, true)
    Wait(2000)
    ClearPedTasks(cache.ped)
end)

RegisterNetEvent('wasabi_police:lockpickHandcuffs', function()
    if not Config.handcuff?.lockpicking?.enabled then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
    if not player then return end
    local sId = GetPlayerServerId(player)
    if not lib.callback.await('wasabi_police:isCuffed', 100, sId) then return end
    local playerPed = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(playerPed)
    TaskTurnPedToFaceCoord(cache.ped, playerCoords.x, playerCoords.y, playerCoords.z, 2000)
    Wait(2000)
    TaskStartScenarioInPlace(cache.ped, 'PROP_HUMAN_PARKING_METER', 0, true)
    if lib.skillCheck(Config.handcuff.lockpicking.difficulty) then
        TriggerServerEvent('wasabi_police:lockpickHandcuffs', sId)
        TriggerEvent('wasabi_police:notify', Strings.success, Strings.lockpick_handcuff_success, 'success')
    else
        TriggerEvent('wasabi_police:notify', Strings.failed, Strings.lockpick_handcuff_fail, 'error')
        local random = math.random(1,100)
        if random <= Config.handcuff.lockpicking.breakChance then
            TriggerServerEvent('wasabi_police:breakLockpick')
            TriggerEvent('wasabi_police:notify', Strings.lockpick_broke, Strings.lockpick_broke_desc, 'error')
        end
    end
    ClearPedTasks(cache.ped)
end)

RegisterNetEvent('wasabi_police:uncuff', function()
    uncuffed()
end)

RegisterNetEvent('wasabi_police:stopEscorting', function()
    if not escorting.active then return end
    escorting.active = nil
    escorting.target = nil
end)

AddEventHandler('wasabi_police:escortPlayer', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(vec3(coords.x, coords.y, coords.z), 2.0, false)
    if not player then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    else
        escortPlayer(GetPlayerServerId(player))
    end
end)

AddEventHandler('wasabi_police:lockpickVehicle', function()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = lib.getClosestVehicle(vec3(coords.x, coords.y, coords.z), 5.0, false)
    if not vehicle or not DoesEntityExist(vehicle) then
        TriggerEvent('wasabi_police:notify', Strings.vehicle_not_found, Strings.vehicle_not_found_desc, 'error')
    else
        local vehCoords = GetEntityCoords(vehicle)
        local dist = #(vec3(coords.x, coords.y, coords.z) - vec3(vehCoords.x, vehCoords.y, vehCoords.z))
        if dist < 2.5 then
            lockpickVehicle(vehicle)
        else
            TriggerEvent('wasabi_police:notify', Strings.too_far, Strings.too_far_desc, 'error')
        end
    end
end)

AddEventHandler('wasabi_police:impoundVehicle', function()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = lib.getClosestVehicle(vec3(coords.x, coords.y, coords.z), 5.0, false)
    if not vehicle or not DoesEntityExist(vehicle) then
        TriggerEvent('wasabi_police:notify', Strings.vehicle_not_found, Strings.vehicle_not_found_desc, 'error')
    else
        local vehCoords = GetEntityCoords(vehicle)
        local dist = #(vec3(coords.x, coords.y, coords.z) - vec3(vehCoords.x, vehCoords.y, vehCoords.z))
        if dist < 2.5 then
            impoundVehicle(vehicle)
        else
            TriggerEvent('wasabi_police:notify', Strings.too_far, Strings.too_far_desc, 'error')
        end
    end
end)

AddEventHandler('wasabi_police:vehicleInfo', function()
    local coords = GetEntityCoords(cache.ped)
    local vehicle = lib.getClosestVehicle(vec3(coords.x, coords.y, coords.z), 5.0, false)
    if not vehicle or not DoesEntityExist(vehicle) then
        TriggerEvent('wasabi_police:notify', Strings.vehicle_not_found, Strings.vehicle_not_found_desc, 'error')
    else
        local vehCoords = GetEntityCoords(vehicle)
        local dist = #(vec3(coords.x, coords.y, coords.z) - vec3(vehCoords.x, vehCoords.y, vehCoords.z))
        if dist < 3.5 then
            vehicleInfoMenu(vehicle)
        else
            TriggerEvent('wasabi_police:notify', Strings.too_far, Strings.too_far_desc, 'error')
        end
    end
end)

AddEventHandler('wasabi_police:openBossMenu', function()
    if not HasGroup(Config.policeJobs) then return end
    local job, _grade = HasGroup(Config.policeJobs)
    OpenBossMenu()
end)

RegisterNetEvent('wasabi_police:escortedPlayer', function(pdId)
    if isCuffed then
        escorted.active = not escorted.active
        escorted.pdId = pdId
    end
end)

RegisterNetEvent('wasabi_police:setEscort', function(targetId)
    if not HasGroup(Config.policeJobs) then return end
    escorting.active = not escorting.active
    escorting.target = targetId
end)

RegisterNetEvent('wasabi_police:putInVehicle', function()
    if isCuffed then
        if escorted.active then
            escorted.active = nil
            escorted.pdId = nil
            Wait(1000)
        end
        local coords = GetEntityCoords(cache.ped)
        if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetVehicleInDirection()
			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end
				if freeSeat then
                    FreezeEntityPosition(cache.ped, false)
					TaskWarpPedIntoVehicle(cache.ped, vehicle, freeSeat)
                    FreezeEntityPosition(cache.ped, true)
				end
			end
		end
    end
end)

RegisterNetEvent('wasabi_police:takeFromVehicle', function()
	if IsPedSittingInAnyVehicle(cache.ped) then
		local vehicle = GetVehiclePedIsIn(cache.ped, false)
		TaskLeaveVehicle(cache.ped, vehicle, 64)
                FreezeEntityPosition(cache.ped, false)
	end
end)

AddEventHandler('wasabi_police:inVehiclePlayer', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(coords, 4.0, false)
    if not player then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    else
        TriggerServerEvent('wasabi_police:inVehiclePlayer', GetPlayerServerId(player))
    end
end)

AddEventHandler('wasabi_police:outVehiclePlayer', function()
    if not HasGroup(Config.policeJobs) then return end
    local coords = GetEntityCoords(cache.ped)
    local player = lib.getClosestPlayer(coords, 4.0, false)
    if not player then
        TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
    else
        TriggerServerEvent('wasabi_police:outVehiclePlayer', GetPlayerServerId(player))
    end
end)

AddEventHandler('wasabi_police:vehicleInteractions', function()
    vehicleInteractionMenu(vehicle)
end)

AddEventHandler('wasabi_police:placeObjects', function()
    placeObjectsMenu(vehicle)
end)

AddEventHandler('wasabi_police:spawnProp', function(index)
    local prop = Config.Props[index]
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(cache.ped,0.0,2.0,0.55))
    local obj = CreateObjectNoOffset(prop.model, x, y, z, true, false)
    SetEntityHeading(obj, GetEntityHeading(cache.ped))
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
end)

AddEventHandler('wasabi_police:licenseMenu', function(data)
    if not HasGroup(Config.policeJobs) then return end
    openLicenseMenu(data)
end)

AddEventHandler('wasabi_police:purchaseArmoury', function(data)
    if not HasGroup(Config.policeJobs) then return end
    local data = data
    data.quantity = 1
    if data.multiple then
        local input = lib.inputDialog(Strings.armoury_quantity_dialog, {Strings.quantity})
        if not input then return end
        local quantity = math.floor(tonumber(input[1]))
        if quantity < 1 then
            TriggerEvent('wasabi_police:notify', Strings.invalid_amount, Strings.invalid_amount_desc, 'error')
        else
            data.quantity = quantity
        end
    end
    local canPurchase = lib.callback.await('wasabi_police:canPurchase', 100, data)
    if canPurchase then
        TriggerEvent('wasabi_police:notify', Strings.success, Strings.successful_purchase_desc, 'success')
    else
        TriggerEvent('wasabi_police:notify', Strings.lacking_funds, Strings.lacking_funds_desc, 'error')
    end
end)

AddEventHandler('wasabi_police:checkId', function(targetId)
    if not HasGroup(Config.policeJobs) then return end
    if targetId and type(targetId) == 'table' then targetId = nil end
    if not targetId then
        local coords = GetEntityCoords(cache.ped)
        local player = lib.getClosestPlayer(coords, 4.0, false)
        if not player then
            TriggerEvent('wasabi_police:notify', Strings.no_nearby, Strings.no_nearby_desc, 'error')
        else
            checkPlayerId(GetPlayerServerId(player))
        end
    else
        checkPlayerId(targetId)
    end
end)

AddEventHandler('wasabi_police:revokeLicense', function(data)
    TriggerServerEvent('wasabi_police:revokeLicense', data.targetId, data.license)
    TriggerEvent('wasabi_police:notify', Strings.license_revoked, Strings.license_revoked_desc, 'success')
    Wait(420) -- lul
    checkPlayerId(data.targetId)
end)

AddEventHandler('wasabi_police:manageId', function(data)
    manageId(data)
end)

AddEventHandler('wasabi_police:gsrTest', function()
    GSRTestNearbyPlayer()
end)

AddEventHandler('wasabi_police:toggleDuty', function()
    if Framework == 'qb' then
        PlayerData.job.onduty = not PlayerData.job.onduty
    end
    TriggerServerEvent('wasabi_police:svToggleDuty', PlayerData.job.name)
end)

-- Arrested Loop
CreateThread(function()
    while true do
        local sleep = 1500
        if isCuffed then
            sleep = 0
            if not IsEntityPlayingAnim(cache.ped, 'mp_arresting', 'idle', 3) then
                TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                if not IsEntityPlayingAnim(cache.ped, 'mp_arresting', 'idle', 3) then
                    Wait(3000)
                    TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    if not IsEntityPlayingAnim(cache.ped, 'mp_arresting', 'idle', 3) then
                        Wait(2000)
                        TaskPlayAnim(cache.ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    end
                end
            end
            DisablePlayerFiring(PlayerId(), true)
            DisableControlAction(0, 140, true)
            DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 23, true)
            if not cuffProp or not DoesEntityExist(cuffProp) then
                lib.requestModel('p_cs_cuffs_02_s', 100)
                local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(cache.ped,0.0,3.0,0.5))
                cuffProp = CreateObjectNoOffset(`p_cs_cuffs_02_s`, x, y, z, true, false)
                SetModelAsNoLongerNeeded(`p_cs_cuffs_02_s`)
                AttachEntityToEntity(cuffProp, cache.ped, GetPedBoneIndex(cache.ped, 57005), 0.04, 0.06, 0.0, -85.24, 4.2, -106.6, true, true, false, true, 1, true)
            end
        end
        if isRagdoll then
            sleep = 0
            SetPedToRagdoll(cache.ped, 1000, 1000, 0, 0, 0, 0)
        end
        Wait(sleep)
    end
end)

-- Escorting loop
CreateThread(function()
    local alrEscorting
    while true do
        local sleep = 1500
        if escorting?.active then
            sleep = 0
            local targetPed = GetPlayerPed(GetPlayerFromServerId(escorting.target))
            if DoesEntityExist(targetPed) and IsPedOnFoot(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                if not alrEscorting then
                    lib.requestAnimDict('amb@code_human_wander_drinking_fat@beer@male@base', 100)
                    TaskPlayAnim(cache.ped, 'amb@code_human_wander_drinking_fat@beer@male@base', 'static', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                    alrEscorting = true
                    RemoveAnimDict('amb@code_human_wander_drinking_fat@beer@male@base')
                elseif alrEscorting and not IsEntityPlayingAnim(cache.ped, 'amb@code_human_wander_drinking_fat@beer@male@base', 'static', 3) then
                    lib.requestAnimDict('amb@code_human_wander_drinking_fat@beer@male@base', 100)
                    TaskPlayAnim(cache.ped, 'amb@code_human_wander_drinking_fat@beer@male@base', 'static', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                    RemoveAnimDict('amb@code_human_wander_drinking_fat@beer@male@base')
                else
                    sleep = 1500
                end
            else
                alrEscorting = nil
                escorting.active = nil
                ClearPedTasks(cache.ped)
            end
        elseif alrEscorting then
            alrEscorting = nil
            escorting.active = nil
            ClearPedTasks(cache.ped)
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)

-- Being escorted loop
CreateThread(function()
    local alrEscorted
    while true do
        local sleep = 1500
        if isCuffed and escorted?.active then
            sleep = 0
            local pdPed = GetPlayerPed(GetPlayerFromServerId(escorted.pdId))
            if DoesEntityExist(pdPed) and IsPedOnFoot(pdPed) and not IsPedDeadOrDying(pdPed, true) then
                if not alrEscorted then
                    AttachEntityToEntity(cache.ped, pdPed, 11816, 0.26, 0.48, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    alrEscorted = true
                    isBusy = true
                else
                    sleep = 500
                end
                if IsPedWalking(pdPed) then
                    if not IsEntityPlayingAnim(cache.ped, 'anim@move_m@prisoner_cuffed', 'walk', 3) then
                        lib.requestAnimDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(cache.ped, 'anim@move_m@prisoner_cuffed', 'walk', 8.0, -8, -1, 1, 0.0, false, false, false)
                    end
                elseif IsPedRunning(pdPed) or IsPedSprinting(pdPed) then
                    if not IsEntityPlayingAnim(cache.ped, 'anim@move_m@trash', 'run', 3) then
                        lib.requestAnimDict('anim@move_m@trash')
                        TaskPlayAnim(cache.ped, 'anim@move_m@trash', 'run', 8.0, -8, -1, 1, 0.0, false, false, false)
                    end
                elseif IsEntityPlayingAnim(cache.ped, 'anim@move_m@prisoner_cuffed', 'walk', 3) or IsEntityPlayingAnim(cache.ped, 'anim@move_m@trash', 'run', 3) then
                    StopAnimTask(cache.ped, 'anim@move_m@prisoner_cuffed', 'walk', -8.0)
                    StopAnimTask(cache.ped, 'anim@move_m@trash', 'run', -8.0)
                end
            else
                alrEscorted = false
                escorted.active = nil
                isBusy = nil
                DetachEntity(cache.ped, true, false)
            end
        elseif alrEscorted then
            alrEscorted = nil
            isBusy = nil
            DetachEntity(cache.ped, true, false)
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)

-- GSR thread
if Config.GSR.enabled then
    local GSRLoopBreak, GSRLoopRunning, GSRTextUI = false, false , false
    CreateThread(function()
        while true do
            local sleep = 1500
            if IsPedArmed(cache.ped, 4) then
                sleep = 0
                if IsPedShooting(cache.ped) then
                    GSRData.positive = true
                    TriggerServerEvent('wasabi_police:setGSR', true)
                    if Config.GSR.autoClean then
                        GSRData.timer = Config.GSR.autoClean
                        if GSRLoopRunning then GSRLoopBreak = true end
                        CreateThread(function()
                            while GSRData?.positive do
                                if GSRLoopBreak then GSRLoopRunning = false GSRLoopBreak = false break end
                                GSRLoopRunning = true
                                Wait(1000)
                                if GSRData.timer == 0 then
                                    GSRData.positive = nil
                                    TriggerServerEvent('wasabi_police:setGSR', false)
                                else
                                    GSRData.timer = GSRData.timer - 1
                                end
                            end
                        end)
                    end
                end
            elseif Config.GSR.cleanInWater and GSRData?.positive and IsEntityInWater(cache.ped) then
                sleep = 0
                if not GSRTextUI then
                    lib.showTextUI(Strings.gsr_wash_ui)
                    GSRTextUI = true
                end
                if IsControlJustReleased(0, 38) then
                    lib.hideTextUI()
                    if lib.progressCircle({
                        duration = Config.GSR.timeToClean,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                        },
                        anim = {
                            dict = 'missheist_agency3aig_23',
                            clip = 'urinal_sink_loop'
                        },
                    }) then
                        if GSRData?.positive then GSRData.positive = nil end
                        GSRLoopBreak = nil
                        GSRLoopRunning = nil
                        GSRTextUI = false
                        TriggerServerEvent('wasabi_police:setGSR', false)
                        TriggerEvent('wasabi_police:notify', Strings.hands_clean, Strings.hands_clean_desc, 'success')
                    else
                        TriggerEvent('wasabi_police:notify', Strings.cancelled, Strings.cancelled_desc, 'error')
                        GSRTextUI = false
                    end
                end
            elseif GSRTextUI then
                lib.hideTextUI()
                GSRTextUI = false
            end
            Wait(sleep)
        end
    end)
end

-- Main thread
CreateThread(function()
    while PlayerData.job == nil do
        Wait(1000) -- Necessary for some of the loops that use job check in these threads within threads.
    end
    if Config.UseRadialMenu then
        AddRadialItems()
    end
    if Config.useTarget then
        for i=1, #Config.policeJobs do
            local data = {
                targetType = 'Player',
                options = {},
                distance = 2.0
            }
            if Config.searchPlayers then
                data.options[#data.options + 1] = {
                    num = #data.options + 1,
                    event = 'wasabi_police:searchPlayer',
                    icon = 'fas fa-magnifying-glass',
                    label = Strings.search_player,
                    job = Config.policeJobs[i],
                }
            end
            data.options[#data.options + 1] = {
                num = #data.options + 1,
                event = 'wasabi_police:checkId',
                icon = 'fas fa-id-card',
                label = Strings.check_id,
                job = Config.policeJobs[i],
            }
            data.options[#data.options + 1] = {
                num = #data.options + 1,
                event = 'wasabi_police:handcuffPlayer',
                icon = 'fas fa-bandage',
                label = Strings.handcuff_player,
                job = Config.policeJobs[i],
            }
            data.options[#data.options + 1] = {
                num = #data.options + 1,
                event = 'wasabi_police:escortPlayer',
                icon = 'fas fa-hand-holding-hand',
                label = Strings.escort_player,
                job = Config.policeJobs[i],
            }
            data.options[#data.options + 1] = {
                num = #data.options + 1,
                event = 'wasabi_police:inVehiclePlayer',
                icon = 'fas fa-arrow-right-to-bracket',
                label = Strings.put_in_vehicle,
                job = Config.policeJobs[i],
            }
            data.options[#data.options + 1] = {
                num = #data.options + 1,
                event = 'wasabi_police:outVehiclePlayer',
                icon = 'fas fa-arrow-right-from-bracket',
                label = Strings.take_out_vehicle,
                job = Config.policeJobs[i],
            }
            TriggerEvent('wasabi_police:addTarget', data)
        end
    end
    for k,v in pairs(Config.Locations) do
        if v.blip.enabled then
            createBlip(v.blip.coords, v.blip.sprite, v.blip.color, v.blip.string, v.blip.scale, false)
        end
        if v?.clockInAndOut?.enabled then
            if v.clockInAndOut.target.enabled then
                if Framework == 'esx' then
                    for i=1, #Config.policeJobs do
                        Config.policeJobs[#Config.policeJobs + 1] = 'off'..Config.policeJobs[i]
                    end
                end
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_toggleduty',
                    coords = v.clockInAndOut.target.coords,
                    heading = v.clockInAndOut.target.heading,
                    width = v.clockInAndOut.target.width,
                    length = v.clockInAndOut.target.length,
                    minZ = v.clockInAndOut.target.minZ,
                    maxZ = v.clockInAndOut.target.maxZ,
                    job = Config.policeJobs,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_police:toggleDuty',
                            icon = 'fa-solid fa-business-time',
                            label = v.clockInAndOut.target.label
                        }
                    }
                }
                TriggerEvent('wasabi_police:addTarget', data)
            else
                CreateThread(function()
                    local textUI
                    while true do
                        local sleep = 1500
                        local hasJob
                        local jobName, jobGrade = HasGroup(v.clockInAndOut.jobLock)
                        if jobName then
                            hasJob = jobName
                        elseif Framework == 'esx' then
                            jobName, jobGrade = HasGroup('off'..v.clockInAndOut.jobLock)
                            if jobName then hasJob = jobName end
                        end
                        if hasJob then
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(coords - v.clockInAndOut.coords)
                            if dist <= v.clockInAndOut.distance then
                                if not textUI then
                                    lib.showTextUI(v.clockInAndOut.label)
                                    textUI = true
                                end
                                sleep = 0
                                if IsControlJustReleased(0, 38) then
                                    if Framework == 'qb' then
                                        PlayerData.job.onduty = not PlayerData.job.onduty
                                    end
                                    TriggerServerEvent('wasabi_police:svToggleDuty', jobName, jobGrade)
                                end
                            elseif textUI then
                                lib.hideTextUI()
                                textUI = nil
                            end
                        end
                        Wait(sleep)
                    end
                end)
            end
        end
        if v.bossMenu.enabled then
            if v.bossMenu?.target?.enabled then
                local data = {
                    targetType = 'AddBoxZone',
                    identifier = k..'_pdboss',
                    coords = v.bossMenu.target.coords,
                    heading = v.bossMenu.target.heading,
                    width = v.bossMenu.target.width,
                    length = v.bossMenu.target.length,
                    minZ = v.bossMenu.target.minZ,
                    maxZ = v.bossMenu.target.maxZ,
                    job = Config.policeJobs,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_police:openBossMenu',
                            icon = 'fa-solid fa-briefcase',
                            label = v.bossMenu.target.label
                        }
                    }
                }
                TriggerEvent('wasabi_police:addTarget', data)
            else
                CreateThread(function()
                    local textUI
                    while true do
                        local sleep = 1500
                        local hasJob
                        local jobName, jobGrade = HasGroup(Config.policeJobs)
                        if jobName then hasJob = jobName end
                        if v?.clockInAndOut?.enabled and Framework =='qb' then
                            if not PlayerData.job.onduty then hasJob = nil end
                        end
                        if hasJob then
                            if v.bossMenu.jobLock then
                                if hasJob == v.bossMenu.jobLock then
                                    local coords = GetEntityCoords(cache.ped)
                                    local dist = #(coords - v.bossMenu.coords)
                                    if dist <= v.bossMenu.distance then
                                        if not textUI then
                                            ShowTextUI(v.bossMenu.label)
                                            textUI = true
                                        end
                                        sleep = 0
                                        if IsControlJustReleased(0, 38) then
                                            OpenBossMenu(hasJob)
                                        end
                                    else
                                        if textUI then
                                            HideTextUI()
                                            textUI = nil
                                        end
                                    end
                                end
                            else
                                local coords = GetEntityCoords(cache.ped)
                                local dist = #(coords - v.bossMenu.coords)
                                if dist <= v.bossMenu.distance then
                                    if not textUI then
                                        ShowTextUI(v.bossMenu.label)
                                        textUI = true
                                    end
                                    sleep = 0
                                    if IsControlJustReleased(0, 38) then
                                        OpenBossMenu(hasJob)
                                    end
                                else
                                    if textUI then
                                        HideTextUI()
                                        textUI = nil
                                    end
                                end
                            end
                        end
                        Wait(sleep)
                    end
                end)
            end
        end
        if v.cloakroom.enabled then
            CreateThread(function()
                local textUI 
                while true do
                    local sleep = 1500
                    local hasJob
                    local jobName, jobGrade = HasGroup(Config.policeJobs)
                    if jobName then hasJob = jobName end
                    if v?.clockInAndOut?.enabled and Framework =='qb' then
                        if not PlayerData.job.onduty then hasJob = nil end
                    end
                    if hasJob and v.cloakroom.jobLock then
                        if hasJob == v.cloakroom.jobLock then
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(coords - v.cloakroom.coords)
                            if dist <= v.cloakroom.range then
                                if not textUI then
                                    ShowTextUI(v.cloakroom.label)
                                    textUI = true
                                end
                                sleep = 0
                                if IsControlJustReleased(0, 38) then
                                    openOutfits(k)
                                end
                            else
                                if textUI then
                                    HideTextUI()
                                    textUI = nil
                                end
                            end
                        end
                    elseif hasJob and not v.cloakroom.jobLock then
                        local coords = GetEntityCoords(cache.ped)
                        local dist = #(coords - v.cloakroom.coords)
                        if dist <= v.cloakroom.range then
                            if not textUI then
                                ShowTextUI(v.cloakroom.label)
                                textUI = true
                            end
                            sleep = 0
                            if IsControlJustReleased(0, 38) then
                                openOutfits(k)
                            end
                        else
                            if textUI then
                                HideTextUI()
                                textUI = nil
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.armoury.enabled then
            CreateThread(function()
                local ped, pedSpawned
                local textUI
                while true do
                    local sleep = 1500
                    local hasJob
                    local jobName, jobGrade = HasGroup(Config.policeJobs)
                    if jobName then hasJob = jobName end
                    local playerPed = cache.ped
                    local coords = GetEntityCoords(playerPed)
                    local dist = #(coords - v.armoury.coords)
                    if dist <= 30 and not pedSpawned then
                        lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
                        lib.requestModel(v.armoury.ped, 100)
                        ped = CreatePed(28, v.armoury.ped, v.armoury.coords.x, v.armoury.coords.y, v.armoury.coords.z, v.armoury.heading, false, false)
                        FreezeEntityPosition(ped, true)
                        SetEntityInvincible(ped, true)
                        SetBlockingOfNonTemporaryEvents(ped, true)
                        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                        pedSpawned = true
                    elseif dist <= 2 and pedSpawned then
                        sleep = 0
                        if not textUI and hasJob then
                            ShowTextUI(v.armoury.label)
                            textUI = true
                        end
                        if IsControlJustReleased(0, 38) and hasJob then
                            textUI = nil
                            HideTextUI()
                            armouryMenu(k)
                        end
                    elseif dist >= 2.2 and textUI then
                        sleep = 0
                        HideTextUI()
                        textUI = nil
                    elseif dist >= 31 and pedSpawned then
                        local model = GetEntityModel(ped)
                        SetModelAsNoLongerNeeded(model)
                        DeletePed(ped)
                        SetPedAsNoLongerNeeded(ped)
                        RemoveAnimDict('mini@strip_club@idles@bouncer@base')
                        pedSpawned = nil
                    end
                    Wait(sleep)
                end
            end)
        end
        if v.vehicles.enabled then
            CreateThread(function()
                local zone = v.vehicles.zone
                local textUI
                while true do
                    local sleep = 1500
                    local hasJob
                    local jobName, jobGrade = HasGroup(Config.policeJobs)
                    if jobName then hasJob = jobName end
                    if v?.clockInAndOut?.enabled and Framework =='qb' then
                        if not PlayerData.job.onduty then hasJob = nil end
                    end
                    if hasJob then
                        if v.jobLock then
                            if hasJob == v.jobLock then
                                local coords = GetEntityCoords(cache.ped)
                                local dist = #(coords - zone.coords)
                                local dist2 = #(coords - v.vehicles.spawn.air.coords)
                                if dist < zone.range + 1 and not inMenu and not IsPedInAnyVehicle(cache.ped, false) then
                                    sleep = 0
                                    if not textUI then
                                        ShowTextUI(zone.label)
                                        textUI = true
                                    end
                                    if IsControlJustReleased(0, 38) then
                                        textUI = nil
                                        HideTextUI()
                                        openVehicleMenu(k)
                                        sleep = 1500
                                    end
                                elseif dist < zone.range + 1 and not inMenu and IsPedInAnyVehicle(cache.ped, false) then
                                    sleep = 0
                                    if not textUI then
                                        textUI = true
                                        ShowTextUI(zone.return_label)
                                    end
                                    if IsControlJustReleased(0, 38) then
                                        textUI = nil
                                        HideTextUI()
                                        if DoesEntityExist(cache.vehicle) then
                                            DoScreenFadeOut(800)
                                            while not IsScreenFadedOut() do Wait(100) end
                                            SetEntityAsMissionEntity(cache.vehicle, false, false)
                                            DeleteVehicle(cache.vehicle)
                                            DoScreenFadeIn(800)
                                        end
                                    end
                                elseif dist2 < 10 and IsPedInAnyVehicle(cache.ped, false) then
                                    sleep = 0
                                    if not textUI then
                                        textUI = true
                                        ShowTextUI(zone.return_label)
                                    end
                                    if IsControlJustReleased(0, 38) then
                                        textUI = nil
                                        HideTextUI()
                                        if DoesEntityExist(cache.vehicle) then
                                            DoScreenFadeOut(800)
                                            while not IsScreenFadedOut() do Wait(100) end
                                            SetEntityAsMissionEntity(cache.vehicle)
                                            DeleteVehicle(cache.vehicle)
                                            SetEntityCoordsNoOffset(playerPed, zone.coords.x, zone.coords.y, zone.coords.z, false, false, false, true)
                                            DoScreenFadeIn(800)
                                        end
                                    end
                                else
                                    if textUI then
                                        textUI = nil
                                        HideTextUI()
                                    end
                                end
                            end
                        else
                            local coords = GetEntityCoords(cache.ped)
                            local dist = #(coords - zone.coords)
                            local dist2 = #(coords - v.vehicles.spawn.air.coords)
                            if dist < zone.range + 1 and not inMenu and not IsPedInAnyVehicle(cache.ped, false) then
                                sleep = 0
                                if not textUI then
                                    ShowTextUI(zone.label)
                                    textUI = true
                                end
                                if IsControlJustReleased(0, 38) then
                                    textUI = nil
                                    HideTextUI()
                                    openVehicleMenu(k)
                                    sleep = 1500
                                end
                            elseif dist < zone.range + 1 and not inMenu and IsPedInAnyVehicle(cache.ped, false) then
                                sleep = 0
                                if not textUI then
                                    textUI = true
                                    ShowTextUI(zone.return_label)
                                end
                                if IsControlJustReleased(0, 38) then
                                    textUI = nil
                                    HideTextUI()
                                    if DoesEntityExist(cache.vehicle) then
                                        DoScreenFadeOut(800)
                                        while not IsScreenFadedOut() do Wait(100) end
                                        SetEntityAsMissionEntity(cache.vehicle, false, false)
                                        DeleteVehicle(cache.vehicle)
                                        DoScreenFadeIn(800)
                                    end
                                end
                            elseif dist2 < 10 and IsPedInAnyVehicle(cache.ped, false) then
                                sleep = 0
                                if not textUI then
                                    textUI = true
                                    ShowTextUI(zone.return_label)
                                end
                                if IsControlJustReleased(0, 38) then
                                    textUI = nil
                                    HideTextUI()
                                    if DoesEntityExist(cache.vehicle) then
                                        DoScreenFadeOut(800)
                                        while not IsScreenFadedOut() do Wait(100) end
                                        SetEntityAsMissionEntity(cache.vehicle)
                                        DeleteVehicle(cache.vehicle)
                                        SetEntityCoordsNoOffset(playerPed, zone.coords.x, zone.coords.y, zone.coords.z, false, false, false, true)
                                        DoScreenFadeIn(800)
                                    end
                                end
                            else
                                if textUI then
                                    textUI = nil
                                    HideTextUI()
                                end
                            end
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    end
end)

-- Prop placement loop
CreateThread(function()
    while PlayerData?.job == nil do Wait(500) end
    local movingProp = false
    function isEntityProp(ent)
        local model = GetEntityModel(ent)
        for i=1, #Config.Props do 
            if model == Config.Props[i].model then 
                return true, i
            end
        end
    end
    function RequestNetworkControl(entity)
        NetworkRequestControlOfEntity(entity)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end
        SetEntityAsMissionEntity(entity, true, true)
        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end
        return NetworkHasControlOfEntity(entity)
    end
    while true do 
        local wait = 2500
        local hasJob
        local jobName, jobGrade = HasGroup(Config.policeJobs)
        if jobName then hasJob = jobName end
        if v?.clockInAndOut?.enabled and Framework =='qb' then
            if not PlayerData.job.onduty then hasJob = nil end
        end
        local ped = cache.ped
        local pcoords = GetEntityCoords(ped)
        if hasJob then
            if (not movingProp) then 
                local objPool = GetGamePool('CObject')
                for i = 1, #objPool do
                    local ent = objPool[i]
                    local prop, index = isEntityProp(ent)
                    if (prop) then 
                        local dist = #(GetEntityCoords(ent) - pcoords)
                        if dist < 1.75 and not IsPedInAnyVehicle(ped, false) then 
                            wait = 0
                            ShowHelpNotification(Strings.prop_help_text)
                            if IsControlJustPressed(1, 51) then 
                                RequestNetworkControl(ent)
                                movingProp = ent
                                local c, r = vec3(0.0, 1.0, -1.0), vec3(0.0, 0.0, 0.0)
                                AttachEntityToEntity(movingProp, ped, ped, c.x, c.y, c.z, r.x, r.y, r.z, false, false, false, false, 2, true)
                                break
                            elseif IsControlJustPressed(1, 47) then
                                RequestNetworkControl(ent)
                                DeleteObject(ent)
                                break
                            end
                        end
                    end
                end
            else
                wait = 0
                ShowHelpNotification(Strings.prop_help_text2)
                if IsControlJustPressed(1, 51) then 
                    RequestNetworkControl(movingProp)
                    DetachEntity(movingProp)
                    PlaceObjectOnGroundProperly(movingProp)
                    FreezeEntityPosition(movingProp, true)
                    movingProp = nil
                end
            end
        end
        Wait(wait)
    end
end)

-- Spike strip functionality
if Config.spikeStripsEnabled then
    CreateThread(function()
        local spikes = `p_ld_stinger_s`
        while true do
            local sleep = 1500
            local coords = GetEntityCoords(cache.ped)
            local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 100.0, spikes, false, false, false)
            if DoesEntityExist(obj) and IsPedInAnyVehicle(cache.ped, false)  then
                sleep = 0
                local vehicle = GetVehiclePedIsIn(cache.ped)
                local objCoords = GetEntityCoords(obj)
                local dist = #(vec3(coords.x, coords.y, coords.z) - vec3(objCoords.x, objCoords.y, objCoords.z))
                if dist < 3.0 then
                    for i=0, 7 do
                        if not IsVehicleTyreBurst(vehicle, i, false) then
                            SetVehicleTyreBurst(vehicle, i, true, 1000)
                        end
                    end
                    sleep = 1500
                end
            end
            Wait(sleep)
        end
    end)
end

if Config.tackle.enabled then
    RegisterCommand('tacklePlayer', function()
        attemptTackle()
    end)
    TriggerEvent('chat:removeSuggestion', '/tacklePlayer')
    RegisterKeyMapping('tacklePlayer', Strings.key_map_tackle, 'keyboard', Config.tackle.hotkey)
end

if Config.handcuff.hotkey then
    RegisterCommand('cuffPlayer', function()
        if not HasGroup(Config.policeJobs) then return end
        TriggerEvent('wasabi_police:handcuffPlayer')
    end)
    TriggerEvent('chat:removeSuggestion', '/cuffPlayer')
    RegisterKeyMapping('cuffPlayer', Strings.key_map_cuff, 'keyboard', Config.handcuff.hotkey)
end

if Config.GSR.enabled and Config.GSR.command then
    RegisterCommand(Config.GSR.command, function()
        GSRTestNearbyPlayer()
    end)
end

RegisterCommand('pdJobMenu', function()
    openJobMenu()
end)

AddEventHandler('wasabi_police:pdJobMenu', function()
    openJobMenu()
end)

TriggerEvent('chat:removeSuggestion', '/pdJobMenu')

RegisterKeyMapping('pdJobMenu', Strings.key_map_job, 'keyboard', Config.jobMenu)
