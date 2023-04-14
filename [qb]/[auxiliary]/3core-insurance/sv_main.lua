local QBCore = nil
local ESX = nil

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
end

local function _startPayChecks()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(60000)
            local _insurances = sqlWrapper('SELECT * FROM 3core_insurance', {})
            for _idx, _insurance in pairs(_insurances) do
                if _insurance['nextpayment'] > 0 then
                    _insurance['nextpayment'] = _insurance['nextpayment'] - 1
                else
                    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
                        local _player = QBCore.Functions.GetPlayerByCitizenId(_insurance['identifier'])
                        if _player then
                            if _player.Functions.GetMoney('bank') >= Config['Prices'][_insurance['type']] then
                                _player.Functions.RemoveMoney('bank', Config['Prices'][_insurance['type']])
                                _insurance['nextpayment'] = Config['PayTime']
                                TriggerClientEvent('3core-insurance:notify', _player.PlayerData.source, (Config['Text']['Paid']):format(Config['Prices'][_insurance['type']]))
                            else
                                sqlWrapper('DELETE FROM 3core_insurance WHERE identifier = ?', {_insurance['identifier']})
                                table.remove(_insurances, _idx)
                                TriggerClientEvent('3core-insurance:notify', _player.PlayerData.source, Config['Text']['Canceled'])
                            end
                        end
                    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
                        local _player = ESX.GetPlayerFromIdentifierd(_insurance['identifier'])
                        if _player then
                            if _player.getAccount('bank').money >= Config['Prices'][_insurance['type']] then
                                _player.removeAccountMoney('bank', Config['Prices'][_insurance['type']])
                                _insurance['nextpayment'] = Config['PayTime']
                                TriggerClientEvent('3core-insurance:notify', _player.PlayerData.source, (Config['Text']['Paid']):format(Config['Prices'][_insurance['type']]))
                            else
                                sqlWrapper('DELETE FROM 3core_insurance WHERE identifier = ?', {_insurance['identifier']})
                                table.remove(_insurances, _idx)
                                TriggerClientEvent('3core-insurance:notify', _player.PlayerData.source, Config['Text']['Canceled'])
                            end
                        end
                    end
                end
                sqlWrapper('UPDATE 3core_insurance SET nextpayment = ? WHERE identifier = ?', {_insurance['nextpayment'], _insurance['identifier']})
            end
        end
    end)
end

local function _isPartActive(_vehicle, _type, _identifier)
    local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_identifier})
    if _playersInsurance[1] then
        local _insuranceUpgrades = json.decode(_playersInsurance[1]['upgrades'])
        for _idx, _up in pairs(_insuranceUpgrades) do
            if _up['vehicle'] == _vehicle and _up['type'] == _type then
                return _up['active']
            end
        end
    end
    return false
end

local function _fetchVehicles(_insurance, _identifier)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _vehiclesTable = {}
        local _vehicles = sqlWrapper('SELECT * FROM player_vehicles WHERE citizenid = ?', {_identifier})
        if _vehicles then
            for _idx, _vehicle in pairs(_vehicles) do
                table.insert(_vehiclesTable, {
                    ['Hash'] = _vehicle['vehicle'],
                    ['Insurance'] = _insurance,
                    ['Upgrade'] = {
                        ['Lock'] = _isPartActive(_vehicle['vehicle'], 'lock', _identifier),
                        ['Camera'] = _isPartActive(_vehicle['vehicle'], 'camera', _identifier),
                        ['Gps'] = _isPartActive(_vehicle['vehicle'], 'gps', _identifier),
                        ['Remote'] = _isPartActive(_vehicle['vehicle'], 'remote', _identifier)
                    } 
                })
            end
        end
        return _vehiclesTable
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _vehiclesTable = {}
        local _vehicles = sqlWrapper('SELECT * FROM owned_vehicles WHERE owner = ?', {_identifier})
        if _vehicles then
            for _idx, _vehicle in pairs(_vehicles) do
                table.insert(_vehiclesTable, {
                    ['Hash'] = _vehicle['vehicle'],
                    ['Insurance'] = _insurance,
                    ['Upgrade'] = {
                        ['Lock'] = _isPartActive(_vehicle['vehicle'], 'lock', _identifier),
                        ['Camera'] = _isPartActive(_vehicle['vehicle'], 'camera', _identifier),
                        ['Gps'] = _isPartActive(_vehicle['vehicle'], 'gps', _identifier),
                        ['Remote'] = _isPartActive(_vehicle['vehicle'], 'remote', _identifier)
                    } 
                })
            end
        end
        return _vehiclesTable
    end
end

local function _getInsuranceFromSource(_src)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.PlayerData.citizenid})
        if _playersInsurance[1] then return _playersInsurance[1] end
        return false
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.identifier})
        if _playersInsurance[1] then return _playersInsurance[1] end
        return false
    end
end

local function _getOptions(_src, _vehicle)
    local _options = {}
    local _playersInsurance = _getInsuranceFromSource(_src)
    for _idx, _upgrade in pairs(json.decode(_playersInsurance['upgrades'])) do
        if _upgrade['vehicle']:lower() == _vehicle:lower() then
            _options[_upgrade['type']] = _upgrade['active']
        end
    end
    return _options
end

RegisterServerEvent('3core-insurance:openMenu', function()
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _src = source
        local _player = QBCore.Functions.GetPlayer(_src)
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.PlayerData.citizenid})
        if _playersInsurance[1] then
            TriggerClientEvent('3core-insurance:openMenu', _src, _playersInsurance[1]['type'], _fetchVehicles(_playersInsurance[1]['type'], _player.PlayerData.citizenid))
        else
            TriggerClientEvent('3core-insurance:openMenu', _src, false, {})
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _src = source
        local _player = ESX.GetPlayerFromId(_src)
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.identifier})
        if _playersInsurance[1] then
            TriggerClientEvent('3core-insurance:openMenu', _src, _playersInsurance[1]['type'], _fetchVehicles(_playersInsurance[1]['type'], _player.identifier))
        else
            TriggerClientEvent('3core-insurance:openMenu', _src, false, {})
        end
    end
end)

RegisterServerEvent('3core-insurance:buyInsurance', function(_level)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _src = source
        local _player = QBCore.Functions.GetPlayer(_src)
        if _player.Functions.GetMoney('bank') >= Config['Prices'][_level] then
            _player.Functions.RemoveMoney('bank', Config['Prices'][_level])
            local _hasInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.PlayerData.citizenid})
            local _upgrades = {}
            if _hasInsurance[1] then
                sqlWrapper('UPDATE 3core_insurance SET type = ? WHERE identifier = ?', {_level, _player.PlayerData.citizenid})
                sqlWrapper('UPDATE 3core_insurance SET upgrades = ? WHERE identifier = ?', {json.encode(_upgrades), _player.PlayerData.citizenid})
                sqlWrapper('UPDATE 3core_insurance SET nextpayment = ? WHERE identifier = ?', {Config['PayTime'], _player.PlayerData.citizenid})
                TriggerClientEvent('3core-insurance:update', _src, _level, _fetchVehicles(_level, _player.PlayerData.citizenid))
            else
                sqlWrapper('INSERT INTO 3core_insurance (identifier, type, upgrades, nextpayment) VALUES (?, ?, ?, ?)', {_player.PlayerData.citizenid, _level, json.encode(_upgrades), Config['PayTime']})
                TriggerClientEvent('3core-insurance:update', _src, _level, _fetchVehicles(_level, _player.PlayerData.citizenid))
            end
        else
            TriggerClientEvent('3core-insurance:notify', _src, Config['Text']['NotEnoughMoney'])
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _src = source
        local _player = ESX.GetPlayerFromId(_src)
        if _player.getAccount('bank').money >= Config['Prices'][_level] then
            _player.removeAccountMoney('bank', Config['Prices'][_level])
            local _hasInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.identifier})
            local _upgrades = {}
            if _hasInsurance[1] then
                sqlWrapper('UPDATE 3core_insurance SET type = ? WHERE identifier = ?', {_level, _player.identifier})
                sqlWrapper('UPDATE 3core_insurance SET upgrades = ? WHERE identifier = ?', {json.encode(_upgrades), _player.identifier})
                sqlWrapper('UPDATE 3core_insurance SET nextpayment = ? WHERE identifier = ?', {Config['PayTime'], _player.identifier})
                TriggerClientEvent('3core-insurance:update', _src, _level, _fetchVehicles(_level, _player.identifier))
            else
                sqlWrapper('INSERT INTO 3core_insurance (identifier, type, upgrades, nextpayment) VALUES (?, ?, ?, ?)', {_player.identifier, _level, json.encode(_upgrades), Config['PayTime']})
                TriggerClientEvent('3core-insurance:update', _src, _level, _fetchVehicles(_level, _player.identifier))
            end
        else
            TriggerClientEvent('3core-insurance:notify', _src, Config['Text']['NotEnoughMoney'])
        end
    end
end)

RegisterServerEvent('3core-insurance:updateUpgrade', function(_vehicle, _upgrade, _value)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _src = source
        local _player = QBCore.Functions.GetPlayer(_src)
        local _found = false
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.PlayerData.citizenid})
        if _playersInsurance[1] then
            local _insuranceUpgrades = json.decode(_playersInsurance[1]['upgrades'])
            if #_insuranceUpgrades > 0 then
                for _idx, _up in pairs(_insuranceUpgrades) do
                    if _up['vehicle'] == _vehicle and _up['type'] == _upgrade then
                        _up['active'] = not _value
                        _found = true
                    end
                end
                if not _found then
                    table.insert(_insuranceUpgrades, {['vehicle'] = _vehicle, ['type'] = _upgrade, ['active'] = not _value})
                end
            else
                table.insert(_insuranceUpgrades, {['vehicle'] = _vehicle, ['type'] = _upgrade, ['active'] = not _value})
            end
            sqlWrapper('UPDATE 3core_insurance SET upgrades = ? WHERE identifier = ?', {json.encode(_insuranceUpgrades), _player.PlayerData.citizenid})
            TriggerClientEvent('3core-insurance:update', _src, _playersInsurance[1]['type'], _fetchVehicles(_playersInsurance[1]['type'], _player.PlayerData.citizenid), _getOptions(_src, _vehicle))
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _src = source
        local _player = ESX.GetPlayerFromId(_src)
        local _found = false
        local _playersInsurance = sqlWrapper('SELECT * FROM 3core_insurance WHERE identifier = ?', {_player.identifier})
        if _playersInsurance[1] then
            local _insuranceUpgrades = json.decode(_playersInsurance[1]['upgrades'])
            if #_insuranceUpgrades > 0 then
                for _idx, _up in pairs(_insuranceUpgrades) do
                    if _up['vehicle'] == _vehicle and _up['type'] == _upgrade then
                        _up['active'] = not _value
                        _found = true
                    end
                end
                if not _found then
                    table.insert(_insuranceUpgrades, {['vehicle'] = _vehicle, ['type'] = _upgrade, ['active'] = not _value})
                end
            else
                table.insert(_insuranceUpgrades, {['vehicle'] = _vehicle, ['type'] = _upgrade, ['active'] = not _value})
            end
            sqlWrapper('UPDATE 3core_insurance SET upgrades = ? WHERE identifier = ?', {json.encode(_insuranceUpgrades), _player.identifier})
            TriggerClientEvent('3core-insurance:update', _src, _playersInsurance[1]['type'], _fetchVehicles(_playersInsurance[1]['type'], _player.identifier), _getOptions(_src, _vehicle))
        end
    end
end)

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    QBCore.Functions.CreateCallback('3core-blackmarket:getInsurance', function(source, cb, _vehicle)
        local _options = {}
        local _playersInsurance = _getInsuranceFromSource(source)
        if _playersInsurance then
            for _idx, _upgrade in pairs(json.decode(_playersInsurance['upgrades'])) do
                if _upgrade['vehicle']:lower() == _vehicle:lower() then
                    _options[_upgrade['type']] = _upgrade['active']
                end
            end
            cb(_playersInsurance['type'], _options)
        end
    end)
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    ESX.RegisterServerCallback('3core-blackmarket:getInsurance', function(source, cb, _vehicle)
        local _options = {}
        local _playersInsurance = _getInsuranceFromSource(source)
        if _playersInsurance then
            for _idx, _upgrade in pairs(json.decode(_playersInsurance['upgrades'])) do
                if _upgrade['vehicle']:lower() == _vehicle:lower() then
                    _options[_upgrade['type']] = _upgrade['active']
                end
            end
            cb(_playersInsurance['type'], _options)
        end
    end)
end

RegisterNetEvent('onResourceStart', function(_name)
    if GetCurrentResourceName() ~= _name then return end
    _startPayChecks()
end)