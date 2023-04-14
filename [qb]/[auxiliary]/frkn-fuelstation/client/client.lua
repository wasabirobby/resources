ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(30)-- Saniye Bekletme
    end
end)


local isOpened = false
local hasAlreadyEnteredMarker, lastZone
local currentAction, currentActionMsg, currentActionData = nil, nil, {}
Config = {}
frkn = {}
array = {}
uidata = {}
employename = {}
local tankerfill = false
local fillgas = false
local isOpened = false
local fuelSynced = false
local inGasStation = false
local presscontrol = false
local Stations = {}
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


RegisterCommand("fuel", function()
    if not isOpened then
        isOpened = true
        openmenu()
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "close",
            clear = true
        })
        isOpened = false
    end
end)



RegisterCommand("empfuel", function()
    if not isOpened then
        isOpened = true
        openemp()
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "close",
            clear = true
        })
        isOpened = false
    end
end)



function uiopen()
    ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback("frkn-fuelstation:info", function(g)
        uidata = g
        print(json.encode(uidata))
        local elements = {}
        for k, v in pairs(uidata) do
            table.insert(elements, {
                label = v.owner,value="test",
                dataid = v.id,
                price = v.price
            })
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'frkn-fuelstation', {
            title = "Buy gas station",
            align = 'top-left',
            elements = elements
        }, function(data, menu)
              ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'question', {
            title = "Buy gas station",
            align = 'top-left',
            elements = {
				{ label = "Mark on map", value = "setpoint" },
				{ label = "Buy", value = "buy" }
			}
        },function(data2, menu2)
            local action = data2.current.value
            if action=="setpoint" then 
                 SetNewWaypoint(Config.GasStations[data.current.dataid].zones[1].x, Config.GasStations[data.current.dataid].zones[1].y, 0, "Gas")
            else 
                ESX.TriggerServerCallback("frkn-fuelstation:getPlayer", function(controldata)
                if tonumber(controldata) == 1 then
                    TriggerEvent('notification', "You already have a gas station.", 1)
                else
                    TriggerServerEvent("frkn-fuelstation:buy", data.current.dataid, data.current.price)
                    TriggerServerEvent('frkn-fuelstation:setPlayer')
                end
            end) 
                end
        end, function(data2, menu2)
            menu.close()
            ESX.UI.Menu.CloseAll()
        end)
        end, function(data, menu)
            menu.close()
            ESX.UI.Menu.CloseAll()
        end)
    end)
end

RegisterNUICallback("exit", function()
    SetNuiFocus(false, false)
end)


RegisterNUICallback("namechange", function(data, cb)
    TriggerServerEvent("frkn-fuelstation:nameChange", data.inputValue)
end)

RegisterNUICallback("fill", function(data, cb)
    buyfuel()
end)

RegisterNUICallback("employe", function(data, cb)
    TriggerServerEvent("frkn-fuelstation:employeadd", data.citizenid, data.name)
end)

RegisterNUICallback("transfer", function(data, cb)
    TriggerServerEvent('frkn-fuelstation:setTransfer', data.citizenid)
end)


RegisterNUICallback("employe-delete", function(data, cb)
    TriggerServerEvent("frkn-fuelstation:employedelete", data.citizenid, data.name)
end)

RegisterNUICallback("buy", function(data, cb)
    TriggerServerEvent("frkn-fuelstation:buy", data.id, data.price)
    TriggerServerEvent('frkn-fuelstation:setPlayer')
end)

RegisterNUICallback("withdraw", function(data, cb)
    TriggerServerEvent('frkn-fuelstation:withdraw', data.price)
end)

RegisterNUICallback("update", function(data, cb)
    TriggerServerEvent('frkn-fuelstation:levelupdate')
end)

RegisterNUICallback("frknemp", function(data, cb)
    ESX.TriggerServerCallback("frkn-fuelstation:getusers", function(dataa)
        cb(dataa)
    end)
end)

RegisterNUICallback("frknfire", function(data, cb)
    ESX.TriggerServerCallback("frkn-fuelstation:getemployebyk", function(empuserdata)
        cb(empuserdata)
    end)
end)

RegisterNUICallback("frknhistory", function(data, cb)
    ESX.TriggerServerCallback("frkn-fuelstation:history", function(history)
        cb(history)
    end)
end)

RegisterNUICallback("frknlevelupdate", function(data, cb)
    ESX.TriggerServerCallback("frkn-fuelstation:currentopen", function(level)
        cb(level)
    end)
end)


RegisterNUICallback("setpoint", function(data, cb)
    ESX.TriggerServerCallback("frkn-fuelstation:currentopen", function(level)
        SetNewWaypoint(Config.GasStations[level.id].zones[1].x, Config.GasStations[level.id].zones[1].y, 0, "Gas")
        TriggerEvent('mythic_notify:client:SendAlert', {type = 'success', text = 'Successfully marked'})
    end)
end)

RegisterNUICallback("close", function(data, cb)
    if not isOpened then
        openmenu()
        isOpened = true
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "close",
            clear = true
        })
        isOpened = false
    end
end)

function openmenu()
    SetNuiFocus(true, true)
    ESX.TriggerServerCallback("frkn-fuelstation:currentopen", function(currentdata)
        ESX.TriggerServerCallback('frkn-fuelstation:getBankingInformation', function(bank)
            ESX.TriggerServerCallback("frkn-fuelstation:info", function(g)
                frkn = g
                SetNuiFocus(true, true)
                SendNUIMessage({
                    currentdata = currentdata,
                    currentdatagas_station_revenue = currentdata.gas_station_revenue,
                    data = frkn,
                    type = "admin",
                    empauth = false,
                    variable = "okey",
                    clear = false,
                    bank = bank
                })
            end)
        end)
    end)
end

function openemp()
    ESX.TriggerServerCallback("frkn-fuelstation:openEmploye", function(empdata)
        print(json.encode(empdata))
        ESX.TriggerServerCallback('frkn-fuelstation:employehistory', function(emphistory)
            ESX.TriggerServerCallback('frkn-fuelstation:getBankingInformation', function(bank)
                ESX.TriggerServerCallback("frkn-fuelstation:info", function(g)
                    frkn = g
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        emphistory = emphistory,
                        emp = "emp",
                        type = "admin",
                        data = frkn,
                        empauth = true,
                        currentdata = empdata,
                        variable = "emp",
                        bank = bank
                    })
                end)
            end)
        end)
    end)
end

AddEventHandler('frkn-market:hasEnteredMarker', function(zone)
    currentAction = 'shop_menu'
    currentActionMsg = ('press_menu')
    currentActionData = {zone = zone}
end)

AddEventHandler('frkn-market:hasExitedMarker', function(zone)
    currentAction = false
    
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Zones) do
        for i = 1, #v.Pos, 1 do
            local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
            
            SetBlipSprite(blip, 59)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(('shops'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, letSleep, currentZone = false, false
        
        for k, v in pairs(Config.Zones) do
            for i = 1, #v.Pos, 1 do
                local distance = GetDistanceBetweenCoords(playerCoords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)
                
                if distance < Config.DrawDistance then
                    letSleep = false
                    
                    if distance < Config.Size.x then
                        isInMarker = true
                        currentZone = k
                        lastZone = k
                    end
                end
            end
        end
        
        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            TriggerEvent('frkn-market:hasEnteredMarker', currentZone)
        end
        
        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('frkn-market:hasExitedMarker', lastZone)
        end
        
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if currentAction then
            for k, v in pairs(Config.Zones) do
                for i = 1, #v.Pos, 1 do
                    -- local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                    DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, "[E] - Buy Fuel")
                end
            end
            
            if IsControlJustReleased(0, 38) then
                if currentAction == 'shop_menu' then
                    uiopen()
                end
                
                currentAction = nil
            end
        else
            Citizen.Wait(500)
        end
    end
end)


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 500
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)

end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if tankerfill == true then
            local vehicle = ESX.Game.GetClosestVehicle()
            
            for k in pairs(Config.TankerFillingCoords) do
                
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.TankerFillingCoords[k].x, Config.TankerFillingCoords[k].y, Config.TankerFillingCoords[k].z)
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    if dist <= 5 then
                        --car control
                        DrawText3D(Config.TankerFillingCoords[k].x, Config.TankerFillingCoords[k].y, Config.TankerFillingCoords[k].z, Config.TankerFillingText)
                        if IsControlJustPressed(0, Keys['E']) then
                            local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                            if vehicleModel == Config.TankerFillCar then
                                local finished = exports['progressBars']:startUI(Config.TankerFillTime, "Fueling your tanker")
                                FreezeEntityPosition(vehicle, true)
                                tankerfill = false
                                Citizen.Wait(Config.TankerFillTime)
                                FreezeEntityPosition(vehicle, false)
                                fillgas = true
                            else
                                -- TriggerEvent('Notification',"You cannot get gas with this vehicle.")
                                TriggerEvent('notification', "You cannot get gas with this vehicle.", 1)
                            end
                        end
                    end
                end
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if fillgas == true then
            local vehicle = ESX.Game.GetClosestVehicle()
            
            for k in pairs(Config.TankerDischargeCoords) do
                
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.TankerDischargeCoords[k].x, Config.TankerDischargeCoords[k].y, Config.TankerDischargeCoords[k].z)
                local ped = PlayerPedId()
                local vehicle = GetVehiclePedIsIn(ped, false)
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    if dist <= 5 then
                        DrawText3D(Config.TankerDischargeCoords[k].x, Config.TankerDischargeCoords[k].y, Config.TankerDischargeCoords[k].z, Config.TankerDischargeText)
                        if IsControlJustPressed(0, Keys['E']) then
                            local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                            if vehicleModel == Config.TankerFillCar then
                                local finished = exports['progressBars']:startUI(Config.TankerFillTime, "Tanker being unloaded")
                                FreezeEntityPosition(vehicle, true)
                                tankerfill = false
                                fillgas = false
                                Citizen.Wait(Config.TankerFillTime)
                                FreezeEntityPosition(vehicle, false)
                                SetEntityAsMissionEntity(vehicle, true, true)
                                DeleteVehicle(vehicle)
                                TriggerServerEvent('frkn-fuelstation:tankerfill')
                            else
                                TriggerEvent('notification', "You cannot get gas with this vehicle.", 1)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function buyfuel()
    TriggerEvent('notification', "Go to the marked area and get gas.", 1)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    for k in pairs(Config.TankerFillingCoords) do
        tankerfill = true
        SetNewWaypoint(Config.TankerFillingCoords[k].x, Config.TankerFillingCoords[k].y, Config.TankerFillingCoords[k].z, "Gas Station")
        local model = Config.TankerFillCar
        local modelhash = GetHashKey(model)
        RequestModel(modelhash)
        while not HasModelLoaded(modelhash) do
            Wait(1)
        end
        local vehicle = CreateVehicle(modelhash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleOnGroundProperly(vehicle)
        SetVehicleNumberPlateText(vehicle, "Fuel Station")
        SetVehicleFuelLevel(vehicle, 100.0)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehiclePetrolTankHealth(vehicle, 1000.0)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleMod(vehicle, 11, 1)
    
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.Zones) do
        for _, gasStationCoords in pairs(Config.GasStationsBlips) do
            local blip = AddBlipForCoord(gasStationCoords)
            SetBlipSprite(blip, 361)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 4)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gas Station")
            EndTextCommandSetBlipName(blip)
        end
    end
end)




RegisterNetEvent('frkn-fuelstation:notify')
AddEventHandler('frkn-fuelstation:notify', function(message, number)
    TriggerEvent('notification', message, number)
end)



RegisterNetEvent('frkn-fuelstation:client:refuelCan', function()
    local vehicle = ESX.Game.GetClosestVehicle()
    local ped = PlayerPedId()
    local CurFuel = GetVehicleFuelLevel(vehicle)
    if CurFuel > 95 then
        TriggerEvent('notification', "You can't refuel this car, it's full.", 2)
    else
        CreateThread(function()
            for k = 1, #Config.GasStations do
                Stations[k] = PolyZone:Create(Config.GasStations[k].zones, {
                    name = "GasStation" .. k,
                    minZ = Config.GasStations[k].minz,
                    maxZ = Config.GasStations[k].maxz,
                    debugPoly = false
                })
                
                Stations[k]:onPlayerInOut(function(isPointInside)
                    if not isPointInside then
                        else
                        print(json.encode(Config.GasStations[k]))
                        local fill = 100 - CurFuel
                        local playerName = GetPlayerName(PlayerId())
                        local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                        local vehiclePlate = GetVehicleNumberPlateText(vehicle)
                        local price = Config.pay * fill
                        TriggerServerEvent('frkn-fuel:setfuelData', fill, playerName, vehicleModel, vehiclePlate, price, k)
                        ESX.TriggerServerCallback('frkn-fuelstation:getTanker', function(data, tanker)
                            ESX.TriggerServerCallback("frkn-fuelstation:getOwner", function(owner)
                                if presscontrol == true then
                                    
                                    if owner == "This place has no owner" then
                                        -- TriggerEvent('Notification',"This place has no owner. You can't buy gas from here.")
                                        TriggerEvent('notification', "This place has no owner. You can't buy gas from here.", 2)
                                    else
                                        local fill = 100 - CurFuel
                                        local price = Config.pay * fill
                                        if fill > tanker then
                                            -- TriggerEvent('Notification',"There isn't that much gas at the gas station..")
                                            TriggerEvent('notification', "There isn't that much gas at the gas station..", 2)
                                        else
                                            TriggerServerEvent('frkn-fuel:setTanker', fill, k, price)
                                            if data == false then
                                                -- TriggerEvent('Notification',"There is no petrol here.")
                                                TriggerEvent('notification', "There is no petrol here.", 2)
                                            else
                                                SetVehicleFuelLevel(vehicle, 50.0)
                                                exports['progressBars']:startUI(Config.RefulTime, "Refueling")
                                                TriggerServerEvent('frkn-fuelstation:server:PayForFuel', Config.pay, GetPlayerServerId(PlayerId()))
                                                SetPedAmmo(ped, 883325847, 4500)
                                                PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
                                                StopAnimTask(ped, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                                                presscontrol = false
                                            end
                                        end
                                    end
                                
                                end
                            end, k)
                        end, k)
                    end
                end)
            end
        end)
    end
end)





function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        
        while not HasAnimDictLoaded(dict) do
            Wait(1)
        end
    end
end


function CreateBlip(coords)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 361)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 4)
    SetBlipDisplay(blip, 4)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gas Station")
    EndTextCommandSetBlipName(blip)
    return blip
end






function DrawText3Ds(x, y, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end



local props = {
    'prop_gas_pump_1d',
    'prop_gas_pump_1a',
    'prop_gas_pump_1b',
    'prop_gas_pump_1c',
    'prop_vintage_pump',
    'prop_gas_pump_old2',
    'prop_gas_pump_old3',
}


local lastBin = 0
Citizen.CreateThread(function()
    while true do
        
        Citizen.Wait(5)
        
        local entity, distance = ESX.Game.GetClosestObject({
            'prop_gas_pump_1d',
            'prop_gas_pump_1a',
            'prop_gas_pump_1b',
            'prop_gas_pump_1c',
            'prop_vintage_pump',
            'prop_gas_pump_old2',
            'prop_gas_pump_old3',
        })
        if distance ~= -1 and distance <= 4.5 then
            local binCoords = GetEntityCoords(entity)
            ESX.Game.Utils.DrawText3D({x = binCoords.x, y = binCoords.y, z = binCoords.z + 1}, '[E] to buy gasoline', 0.8)
            if IsControlJustReleased(0, 38) then
                presscontrol = true
                TriggerEvent('frkn-fuelstation:client:refuelCan')
            end
        else
            Citizen.Wait(500)
        end
    end
    presscontrol = false
end)
