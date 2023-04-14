local _createdPed = nil
local _inMenu = false
local _timeActive = true
local QBCore = nil
local ESX = nil

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
    RegisterNetEvent(Config['FrameworkSettings']['PlayerLoadedQBCore'], function()
        QBCore.Functions.TriggerCallback('3core-investments:getInvestments', function(_investment, _canInvest1, _canInvest2)
            SendNUIMessage({type = 'updateInvestments', investments = _investment})
            SendNUIMessage({type = 'showTime'})
        end)
    end)
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
    RegisterNetEvent(Config['FrameworkSettings']['PlayerLoadedESX'], function()
        ESX.TriggerServerCallback('3core-investments:getInvestments', function(_investment, _canInvest1, _canInvest2)
            SendNUIMessage({type = 'updateInvestments', investments = _investment})
            SendNUIMessage({type = 'showTime'})
        end)
    end)
end

local function _drawHelpText(_text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(_text)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

local function _createClientPed()
    RequestModel(Config['NpcSettings']['Hash'])
    while not HasModelLoaded(Config['NpcSettings']['Hash']) do Citizen.Wait(0) end
    _createdPed = CreatePed(4, Config['NpcSettings']['Hash'], Config['NpcSettings']['Coords'], false, false)
    FreezeEntityPosition(_createdPed, true)
    SetEntityInvincible(_createdPed, true)
    SetBlockingOfNonTemporaryEvents(_createdPed, true)
    local _blip = AddBlipForCoord(Config['NpcSettings']['Coords'])
    SetBlipSprite(_blip, Config['BlipSettings']['Sprite'])
    SetBlipScale(_blip, Config['BlipSettings']['Scale'])
    SetBlipColour(_blip, Config['BlipSettings']['Color'])
    SetBlipAsShortRange(_blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config['BlipSettings']['Label'])
    EndTextCommandSetBlipName(_blip)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if not _inMenu then
                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(_createdPed)) < 2.0 then
                    _drawHelpText(Config['Text']['OpenMenu'])
                    if IsControlJustReleased(0, 38) then
                        if Config['FrameworkSettings']['Framework'] == 'QBCore' then
                            QBCore.Functions.TriggerCallback('3core-investments:getInvestments', function(_investment, _canInvest1, _canInvest2)
                                SendNUIMessage({type = 'showPage', investments = _investment, canInvest1 = _canInvest1, canInvest2 = _canInvest2})
                                SetNuiFocus(true, true)
                                SetCursorLocation(0.5, 0.5)
                                SendNUIMessage({type = 'hideTime'})
                                _inMenu = true
                            end)
                        elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
                            ESX.TriggerServerCallback('3core-investments:getInvestments', function(_investment, _canInvest1, _canInvest2)
                                SendNUIMessage({type = 'showPage', investments = _investment, canInvest1 = _canInvest1, canInvest2 = _canInvest2})
                                SetNuiFocus(true, true)
                                SetCursorLocation(0.5, 0.5)
                                SendNUIMessage({type = 'hideTime'})
                                _inMenu = true
                            end)
                        end
                    end
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			_createClientPed()
			return
		end
	end
end)

RegisterNUICallback('close', function(_data, _cb)
    _inMenu = false
    SetNuiFocus(false, false)
    QBCore.Functions.TriggerCallback('3core-investments:getInvestments', function(_investment, _canInvest1, _canInvest2)
        SendNUIMessage({type = 'showTime', investments = _investment})
    end)
end)

RegisterNUICallback('startInvestment', function(_data, _cb)
    TriggerServerEvent('3core-investments:startInvestment', _data.investmentData)
end)

RegisterNUICallback('takeProfit', function(_data, _cb)
    TriggerServerEvent('3core-investments:takeProfit', _data.type)
end)

RegisterNetEvent('3core-investments:update', function(_investment, _canInvest1, _canInvest2)
    SendNUIMessage({type = 'update', investments = _investment, canInvest1 = _canInvest1, canInvest2 = _canInvest2})
end)

RegisterNetEvent('3core-investments:notify', function(_message)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(_message)
	DrawNotification(false, true)
end)

RegisterNetEvent('3core-investments:updateTime', function(_investments)
    SendNUIMessage({type = 'updateInvestments', investments = _investments})
end)

RegisterNetEvent('3core-investments:showTimer', function()
    SendNUIMessage({type = 'showTime'})
end)

RegisterNetEvent('3core-investments:hideTimer', function()
    SendNUIMessage({type = 'hideTime'})
end)

RegisterNetEvent('onResourceStop', function(_name)
    if GetCurrentResourceName() ~= _name then return end
    if DoesEntityExist(_createdPed) then DeleteEntity(_createdPed) end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if LocalPlayer.state.isLoggedIn then
            if IsPauseMenuActive() then
                SendNUIMessage({type = 'hideTime'})
                _timeActive = false
            else
                if not _timeActive then
                    _timeActive = true
                    SendNUIMessage({type = 'showTime'})
                end
            end
        end
    end
end)