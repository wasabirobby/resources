local QBCore = nil
local ESX = nil
local _activeInvestments = {}

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
end

local function _hoursToSeconds(_hours)
    return _hours * 3600
end

local function _cloneTable(_table)
    local _copy = {} 
    for _key, _value in pairs(_table) do
        if type(_value) ~= 'table' then 
            _copy[_key] = _value 
        else 
            _copy[_key] = _cloneTable(_value) 
        end
    end 
    return _copy
end

local function _getPlayerInvestments(_identifier)
    local _tempConfig = _cloneTable(Config['Investments'])
    local _investmentsDB = sqlWrapper('SELECT * FROM 3core_investments WHERE `identifier` = ?', {_identifier})
    for _idx, _investment in pairs(_investmentsDB) do
        if _tempConfig[_investment['type']][_investment['index']] then
            _tempConfig[_investment['type']][_investment['index']]['Active'] = true
            _tempConfig[_investment['type']][_investment['index']]['RemainTime'] = _investment['time']
        end
    end
    return _tempConfig
end

local function _canInvest(_identifier, _pageIndex)
    local _investmentsDB = sqlWrapper('SELECT * FROM 3core_investments WHERE `identifier` = ?', {_identifier})
    if _investmentsDB then
        for idx, investment in pairs(_investmentsDB) do
            if investment['type'] == _pageIndex then
                return false
            end
        end
    end
    return true
end

local function _fetchInvestments()
    local _db = sqlWrapper('SELECT * FROM 3core_investments', {})
    for _idx, _investment in pairs(_db) do
        table.insert(_activeInvestments, {
            ['id'] = _investment['id'],
            ['identifier'] = _investment['identifier'],
            ['time'] = _investment['time']
        })
    end
end

local function _saveInvestments()
    for _idx, _investment in pairs(_activeInvestments) do
        sqlWrapper('UPDATE 3core_investments SET time = ? WHERE id = ?', {_investment['time'], _investment['id']})
        if Config['FrameworkSettings']['Framework'] == 'QBCore' then
            local _player = QBCore.Functions.GetPlayerByCitizenId(_investment['identifier'])
            if not _player then return end
            TriggerClientEvent('3core-investments:updateTime', _player.PlayerData.source, _getPlayerInvestments(_player.PlayerData.citizenid))
        elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
            local _player = ESX.GetPlayerFromIdentifier(_investment['identifier'])
            if not _player then return end
            TriggerClientEvent('3core-investments:updateTime', _player.source, _getPlayerInvestments(_player.identifier))
        end
    end
end

local function _getInvestmentPrice(_index)
    return Config['Investments']['LongTerm'][_index]['Cost']
end

local function _getPlayerInvestment(_identifier, _type)
    local _investmentsDB = sqlWrapper('SELECT * FROM 3core_investments WHERE `identifier` = ?', {_identifier})
    for idx, _investment in pairs(_investmentsDB) do
        if _investment['type'] == _type then
            if _type == 'DayTime' then
                return Config['Investments']['DayTime'][_investment['index']]['Profit'], 0
            elseif _type == 'LongTerm' then
                return Config['Investments']['LongTerm'][_investment['index']]['Profit'], Config['Investments']['LongTerm'][_investment['index']]['Cost']
            end
        end
    end
    return false, false
end

RegisterServerEvent('3core-investments:startInvestment', function(_investmentData)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _src = source
        local _player = QBCore.Functions.GetPlayer(_src)
        if _investmentData['Type'] == 'DayTime' then
            sqlWrapper('INSERT INTO 3core_investments (`identifier`, `type`, `index`, `time`) VALUES (?, ?, ?, ?)', {
                _player.PlayerData.citizenid, 
                _investmentData['Type'], 
                _investmentData['Index'], 
                _hoursToSeconds(_investmentData['Hours'])
            })
            TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.PlayerData.citizenid), _canInvest(_player.PlayerData.citizenid, 'DayTime'), _canInvest(_player.PlayerData.citizenid, 'LongTerm'))
            _fetchInvestments()
        else
            if _player.Functions.GetMoney('bank') >= _investmentData['Cost'] then
                _player.Functions.RemoveMoney('bank', _investmentData['Cost'])
                sqlWrapper('INSERT INTO 3core_investments (`identifier`, `type`, `index`, `time`) VALUES (?, ?, ?, ?)', {
                    _player.PlayerData.citizenid, 
                    _investmentData['Type'], 
                    _investmentData['Index'], 
                    _hoursToSeconds(_investmentData['Hours'])
                })
                TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.PlayerData.citizenid), _canInvest(_player.PlayerData.citizenid, 'DayTime'), _canInvest(_player.PlayerData.citizenid, 'LongTerm'))
                _fetchInvestments()
            else
                TriggerClientEvent('3core-investments:notify', _src, Config['Text']['NotEnough'])
            end
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _src = source
        local _player = ESX.GetPlayerFromId(_src)
        if _investmentData['Type'] == 'DayTime' then
            sqlWrapper('INSERT INTO 3core_investments (`identifier`, `type`, `index`, `time`) VALUES (?, ?, ?, ?)', {
                _player.identifier, 
                _investmentData['Type'], 
                _investmentData['Index'], 
                _hoursToSeconds(_investmentData['Hours'])
            })
            TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.identifier), _canInvest(_player.identifier, 'DayTime'), _canInvest(_player.identifier, 'LongTerm'))
            _fetchInvestments()
        else
            if _player.getAccount('bank').money >= _investmentData['Cost'] then
                _player.removeAccountMoney('bank', _investmentData['Cost'])
                sqlWrapper('INSERT INTO 3core_investments (`identifier`, `type`, `index`, `time`) VALUES (?, ?, ?, ?)', {
                    _player.identifier, 
                    _investmentData['Type'], 
                    _investmentData['Index'], 
                    _hoursToSeconds(_investmentData['Hours'])
                })
                TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.identifier), _canInvest(_player.identifier, 'DayTime'), _canInvest(_player.identifier, 'LongTerm'))
                _fetchInvestments()
            else
                TriggerClientEvent('3core-investments:notify', _src, Config['Text']['NotEnough'])
            end
        end
    end
end)

RegisterServerEvent('3core-investments:takeProfit', function(_type)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _src = source
        local _player = QBCore.Functions.GetPlayer(_src)
        local _profit, _price = _getPlayerInvestment(_player.PlayerData.citizenid, _type)
        if not _profit and not _price then return end
        _player.Functions.AddMoney('bank', _price + _profit)
        sqlWrapper('DELETE FROM 3core_investments WHERE identifier = ? AND type = ?', {_player.PlayerData.citizenid, _type})
        TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.PlayerData.citizenid), _canInvest(_player.PlayerData.citizenid, 'DayTime'), _canInvest(_player.PlayerData.citizenid, 'LongTerm'))
        _fetchInvestments()
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _src = source
        local _player = ESX.GetPlayerFromId(_src)
        local _profit, _price = _getPlayerInvestment(_player.identifier, _type)
        if not _profit and not _price then return end
        _player.addAccountMoney('bank', _price + _profit)
        sqlWrapper('DELETE FROM 3core_investments WHERE identifier = ? AND type = ?', {_player.identifier, _type})
        TriggerClientEvent('3core-investments:update', _src, _getPlayerInvestments(_player.identifier), _canInvest(_player.identifier, 'DayTime'), _canInvest(_player.identifier, 'LongTerm'))
        _fetchInvestments()
    end
end)

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    QBCore.Functions.CreateCallback('3core-investments:getInvestments', function(_source, _cb)
        local _player = QBCore.Functions.GetPlayer(_source)
        _cb(_getPlayerInvestments(_player.PlayerData.citizenid), _canInvest(_player.PlayerData.citizenid, 'DayTime'), _canInvest(_player.PlayerData.citizenid, 'LongTerm'))
    end)
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    ESX.RegisterServerCallback('3core-investments:getInvestments', function(_source, _cb)
        local _player = ESX.GetPlayerFromId(_source)
        _cb(_getPlayerInvestments(_player.identifier), _canInvest(_player.identifier, 'DayTime'), _canInvest(_player.identifier, 'LongTerm'))
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for _idx, _investment in pairs(_activeInvestments) do
            if Config['FrameworkSettings']['Framework'] == 'QBCore' then
                local _player = QBCore.Functions.GetPlayerByCitizenId(_investment['identifier'])
                if _player then
                    if _investment['time'] > 0 then
                        _investment['time'] = _investment['time'] - 1
                    else
                        table.remove(_activeInvestments, _idx)
                    end
                end
            elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
                local _player = ESX.GetPlayerFromIdentifier(_investment['identifier'])
                if _player then
                    if _investment['time'] > 0 then
                        _investment['time'] = _investment['time'] - 1
                    else
                        table.remove(_activeInvestments, _idx)
                    end
                end
            end
        end
        _saveInvestments()
    end
end)

RegisterServerEvent('onResourceStart', function (_resourceName)
    if GetCurrentResourceName() ~= _resourceName then return end
    _fetchInvestments()
end)