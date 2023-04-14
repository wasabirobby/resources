local QBCore = nil

local ESX = nil

local _atmActive = false

local _currentATM = nil

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
end

local function _openATM(_playerData, _atmData)
    SetNuiFocus(true, true)
    if _atmData['atmOwner'] then
        SendNUIMessage({type = 'showMenu', playerData = _playerData, defaultData = _atmData})
    else
        SendNUIMessage({type = 'buyAtm', defaultData = _atmData})
    end
    _atmActive = true
end

local function drawHelpText(_text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(_text)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

RegisterNUICallback('close', function(_data, _cb)
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
    _atmActive = false
end)

RegisterNUICallback('buyATM', function(_data, _cb)
    TriggerServerEvent('3core-atms:buyATM', _currentATM)
end)

RegisterNUICallback('withdraw', function(_data, _cb)
    TriggerServerEvent('3core-atms:withdraw', _currentATM, _data.amount)
end)

RegisterNUICallback('deposit', function(_data, _cb)
    TriggerServerEvent('3core-atms:deposit', _currentATM, _data.amount)
end)

RegisterNUICallback('transfer', function(_data, _cb)
    TriggerServerEvent('3core-atms:transfer', _currentATM, _data.amount, _data.id)
end)

RegisterNUICallback('robatm', function(_data, _cb)
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        QBCore.Functions.TriggerCallback('3core-atms:canRob', function(_canRob, _message)
            if _canRob then
                RequestAnimDict('anim@heists@prison_heistig1_p1_guard_checks_bus')
                while not HasAnimDictLoaded('anim@heists@prison_heistig1_p1_guard_checks_bus') do Citizen.Wait(0) end
                TaskPlayAnim(PlayerPedId(), 'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop', 1.0 ,1.0, -1, 1,0, false, false, false)
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:start", 7, 35, function(_success)
                    TriggerEvent('mhacking:hide')
                    ClearPedTasks(PlayerPedId())
                    _atmActive = false
                    if _success then TriggerServerEvent('3core-atms:robReward', _currentATM) end
                end)
            else
                TriggerEvent('3core-atms:notify', _message)
            end
        end, _currentATM)
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        ESX.TriggerServerCallback('3core-atms:canRob', function(_canRob, _message)
            if _canRob then
                RequestAnimDict('anim@heists@prison_heistig1_p1_guard_checks_bus')
                while not HasAnimDictLoaded('anim@heists@prison_heistig1_p1_guard_checks_bus') do Citizen.Wait(0) end
                TaskPlayAnim(PlayerPedId(), 'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop', 1.0 ,1.0, -1, 1,0, false, false, false)
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:start", 7, 35, function(_success)
                    TriggerEvent('mhacking:hide')
                    ClearPedTasks(PlayerPedId())
                    _atmActive = false
                    if _success then TriggerServerEvent('3core-atms:robReward', _currentATM) end
                end)
            else
                TriggerEvent('3core-atms:notify', _message)
            end
        end, _currentATM)
    end
end)

RegisterNUICallback('balancewithdraw', function(_data, _cb)
    TriggerServerEvent('3core-atms:balancewithdraw', _currentATM, _data.amount)
end)

RegisterNetEvent('3core-atms:atmBought', function()
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        QBCore.Functions.TriggerCallback('3core-atms:getATMData', function(_playerData, _atmData)
            _openATM(_playerData, _atmData)
        end, _currentATM)
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        ESX.TriggerServerCallback('3core-atms:getATMData', function(_playerData, _atmData)
            _openATM(_playerData, _atmData)
        end, _currentATM)
    end
end)

RegisterNetEvent('3core-atms:updatePlayerData', function(_playerData)
    SendNUIMessage({type = 'updatePlayerData', playerData = _playerData})
end)

RegisterNetEvent('3core-atms:updateATMBalance', function(_balance)
    SendNUIMessage({type = 'updateATMBalance', balance = _balance})
end)

RegisterNetEvent('3core-atms:notify', function(_message)
    QBCore.Functions.Notify(_message)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not _atmActive then
            for _idx, _atmProp in pairs(Config['ATMS']) do
                local _atmEntity = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, GetHashKey(_atmProp), false, false, false)
                if _atmEntity ~= 0 then
                    _currentATM = GetEntityCoords(_atmEntity)
                    drawHelpText(Config['Text']['OpenATM'])
                    if IsControlJustReleased(0, 38) then
						RequestAnimDict('amb@prop_human_atm@male@enter')
						while not HasAnimDictLoaded('amb@prop_human_atm@male@enter') do Citizen.Wait(0) end
						TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', 'enter', 1.0, 1.0, 3000, 0, 1, true, true, true)
						Citizen.Wait(3000)			
						RequestAnimDict('amb@prop_human_atm@male@base')
						while not HasAnimDictLoaded('amb@prop_human_atm@male@base') do Citizen.Wait(0) end
						TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@base', 'base', 1.0, -1.0, -1, 2, 1, true, true, true)
                        if Config['FrameworkSettings']['Framework'] == 'QBCore' then
                            QBCore.Functions.TriggerCallback('3core-atms:getATMData', function(_playerData, _atmData)
                                _openATM(_playerData, _atmData)
                            end, GetEntityCoords(_atmEntity))
                        elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
                            ESX.TriggerServerCallback('3core-atms:getATMData', function(_playerData, _atmData)
                                _openATM(_playerData, _atmData)
                            end, GetEntityCoords(_atmEntity))
                        end
                    end
                end
            end
        end
    end
end)