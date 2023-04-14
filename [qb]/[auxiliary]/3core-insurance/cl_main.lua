local QBCore = nil
local ESX = nil

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
end

local _createdPed = nil
local _inMenu = false
local _clientAvaibleVehicles = {}
local _currentCamState = nil
local _camHandle = nil
local _gpsBlip = nil

Citizen.CreateThread(function()
    RegisterCommand(Config['KeyMapping']['Command'], function()
        SendNUIMessage({type = 'control', vehicles = _clientAvaibleVehicles})
        SetNuiFocus(true, true)
    end)
    RegisterKeyMapping(Config['KeyMapping']['Command'], Config['KeyMapping']['Description'], 'keyboard', Config['KeyMapping']['Key'])
end)

local function _drawHelpText(_text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(_text)
	EndTextCommandDisplayHelp(0, false, true, -1)
end

local function _createClientPed()
    RequestModel(Config['NpcSettings']['hash'])
    while not HasModelLoaded(Config['NpcSettings']['hash']) do Citizen.Wait(0) end
    _createdPed = CreatePed(4, Config['NpcSettings']['hash'], Config['NpcSettings']['coords'], false, false)
    FreezeEntityPosition(_createdPed, true)
    SetEntityInvincible(_createdPed, true)
    SetBlockingOfNonTemporaryEvents(_createdPed, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if not _inMenu then
                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(_createdPed)) < 2.0 then
                    _drawHelpText(Config['Text']['OpenMenu'])
                    if IsControlJustReleased(0, Config['OpenMenuKey']) then
                        _inMenu = true
                        TriggerServerEvent('3core-insurance:openMenu')
                    end
                end
            end
        end
    end)
end

local function _createVehicleCam(_vehicle, _type)
    if not DoesEntityExist(_vehicle) then return end
    _camHandle = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    if _type == 'front' then
        local _camBone = GetEntityBoneIndexByName(_vehicle, 'windscreen')
        AttachCamToVehicleBone(_camHandle, _vehicle, _camBone, true, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true)
        RenderScriptCams(true, false, false, true, true)
    elseif _type == 'back' then
        local _camBone = GetEntityBoneIndexByName(_vehicle, 'exhaust')
        AttachCamToVehicleBone(_camHandle, _vehicle, _camBone, true, 180.0, 180.0, 0.0, 0.0, 0.0, 0.0, true)
        RenderScriptCams(true, false, false, true, true)
    end
end

local function _activeOption(_vehicle, _type)
    if _type == 'lock' then
        if not DoesEntityExist(_vehicle) then return end
        if GetVehicleDoorLockStatus(_vehicle) == 3 then 
            SetVehicleDoorsLocked(_vehicle, 1)
            TriggerEvent('3core-insurance:notify', (Config['Text']['Lock']):format('Unlocked'))
        else 
            SetVehicleDoorsLocked(_vehicle, 3) 
            TriggerEvent('3core-insurance:notify', (Config['Text']['Lock']):format('Locked'))
        end
    elseif _type == 'camera' then
        if not _currentCamState then
            _createVehicleCam(_vehicle, 'front')
            _currentCamState = 'front'
            TriggerEvent('3core-insurance:notify', (Config['Text']['CameraSet']):format('Wind Screen'))
        elseif _currentCamState == 'front' then
            _createVehicleCam(_vehicle, 'back')
            _currentCamState = 'back'
            TriggerEvent('3core-insurance:notify', (Config['Text']['CameraSet']):format('Exhaust'))
        elseif _currentCamState == 'back' then
            DestroyCam(_camHandle, true)
            RenderScriptCams(false, false, false, true, true)
            _camHandle = nil
            _currentCamState = nil
            TriggerEvent('3core-insurance:notify', Config['Text']['CameraDestroyed'])
        end
    elseif _type == 'gps' then
        if not DoesEntityExist(_vehicle) then return end
        if DoesBlipExist(_gpsBlip) then
            RemoveBlip(_gpsBlip)
            TriggerEvent('3core-insurance:notify', (Config['Text']['Gps']):format('Off'))
        else
            _gpsBlip = AddBlipForEntity(_vehicle)
            SetBlipSprite(_gpsBlip, 225)
            SetBlipColour(_gpsBlip, 5)
            SetBlipScale(_gpsBlip, 1.0)
            SetBlipAsShortRange(_gpsBlip)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Vehicle GPS')
            EndTextCommandSetBlipName(_gpsBlip)
            TriggerEvent('3core-insurance:notify', (Config['Text']['Gps']):format('On'))
        end
    elseif _type == 'remote' then
        if not DoesEntityExist(_vehicle) then return end
        if GetIsVehicleEngineRunning(_vehicle) then 
            SetVehicleEngineOn(_vehicle, false, false, true) 
            SetPedConfigFlag(GetPedInVehicleSeat(_vehicle, -1), 429, true) 
            TriggerEvent('3core-insurance:notify', (Config['Text']['Engine']):format('Off'))
        else 
            SetVehicleEngineOn(_vehicle, true, false, true) 
            SetPedConfigFlag(GetPedInVehicleSeat(_vehicle, -1), 429, false) 
            TriggerEvent('3core-insurance:notify', (Config['Text']['Engine']):format('On'))
        end
    end
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
    TriggerScreenblurFadeOut()
    SetNuiFocus(false, false)
    _inMenu = false
end)

RegisterNUICallback('buyInsurance', function(_data, _cb)
    TriggerServerEvent('3core-insurance:buyInsurance', _data.level)
end)

RegisterNUICallback('updateUpgrade', function(_data, _cb)
    TriggerServerEvent('3core-insurance:updateUpgrade', _data.vehicle, _data.upgrade, _data.value)
end)

RegisterNUICallback('activeOption', function(_data, _cb)
    _activeOption(_data.vehicle, _data.type)
end)

local function _createVehiclesName(_vehicles)
    for _idx, _vehicle in pairs(_vehicles) do
        _vehicle['Name'] = GetLabelText(GetDisplayNameFromVehicleModel(_vehicle['Hash']))
    end
    return _vehicles
end

RegisterNetEvent('3core-insurance:openMenu', function(_plan, _ownedVehicles)
    local _vehicles = _createVehiclesName(_ownedVehicles)
    TriggerScreenblurFadeIn()
    SendNUIMessage({type = 'show', plan = _plan, prices = Config['Prices'], ownedVehicles = _vehicles})
    SetNuiFocus(true, true)
    SetCursorLocation(0.5, 0.5)
end)

RegisterNetEvent('3core-insurance:update', function(_type, _ownedVehicles, _options)
    local _vehicles = _createVehiclesName(_ownedVehicles)
    for _idx, _vehicle in pairs(_clientAvaibleVehicles) do _vehicle['Insurance'] = _type _vehicle['Options'] = _options end
    SendNUIMessage({type = 'update', plan = _type, prices = Config['Prices'], ownedVehicles = _vehicles, avaibleVehicles = _clientAvaibleVehicles})
end)

RegisterNetEvent('3core-insurance:addVehicle', function(_vehicle)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        QBCore.Functions.TriggerCallback('3core-blackmarket:getInsurance', function(_insurance, _options)
            if _insurance then
                table.insert(_clientAvaibleVehicles, {
                    ['Hash'] = _vehicle,
                    ['Name'] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(_vehicle))),
                    ['Insurance'] = _insurance,
                    ['Options'] = _options
                })
            end
        end, GetDisplayNameFromVehicleModel(GetEntityModel(_vehicle)))
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        ESX.TriggerServerCallback('3core-blackmarket:getInsurance', function(_insurance, _options)
            if _insurance then
                table.insert(_clientAvaibleVehicles, {
                    ['Hash'] = _vehicle,
                    ['Name'] = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(_vehicle))),
                    ['Insurance'] = _insurance,
                    ['Options'] = _options
                })
            end
        end, GetDisplayNameFromVehicleModel(GetEntityModel(_vehicle)))
    end
end)

RegisterNetEvent('3core-insurance:removeVehicle', function(_vehicle)
    for _idx, _v in pairs(_clientAvaibleVehicles) do
        if _v['Hash'] == _vehicle then
            table.remove(_clientAvaibleVehicles, _idx)
        end
    end
end)

RegisterNetEvent('onResourceStop', function(_name)
    if GetCurrentResourceName() ~= _name then return end
    if DoesEntityExist(_createdPed) then DeleteEntity(_createdPed) end
end)

RegisterNetEvent('3core-insurance:notify', function(_message)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(_message)
	DrawNotification(false, true)
end)