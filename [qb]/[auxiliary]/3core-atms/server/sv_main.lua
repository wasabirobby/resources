local QBCore = nil

local ESX = nil

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    local _fileName = Config['FrameworkSettings']['QBCoreFileName']
    QBCore = exports[_fileName]:GetCoreObject()
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    TriggerEvent(Config['FrameworkSettings']['ESXEvent'], function(obj) ESX = obj end)
end

local function _getATMFromLocation(_coords)
    local _atms = sqlWrapper('SELECT * FROM 3core_atms', {})
    for _idx, _atm in pairs(_atms) do
        local _atmLocation = json.decode(_atm['location'])
        if tostring(_atmLocation.x) == tostring(_coords.x) and tostring(_atmLocation.y) == tostring(_coords.y) and tostring(_atmLocation.z) == tostring(_coords.z) then
            return _atm
        end
    end
    return nil
end

local function _getATMOwner(_coords)
    local _atm = _getATMFromLocation(_coords)
    if not _atm then return end
    return _atm['owner']
end

local function _getATMBalance(_coords)
    local _atm = _getATMFromLocation(_coords)
    if not _atm then return end
    return _atm['balance']
end

local function _checkOwner(_identifier, _coords)
    local _atm = _getATMFromLocation(_coords)
    if not _atm then return end
    return _atm['identifier'] == _identifier
end

local function _updateATMBalance(_src, _coords, _type, _amount)
    local _atm = _getATMFromLocation(_coords)
    if _type == 'add' then
        local _newBalance = _atm['balance'] + _amount
        sqlWrapper('UPDATE 3core_atms SET balance = ? WHERE identifier = ?', {_newBalance, _atm['identifier']})
        TriggerClientEvent('3core-atms:updateATMBalance', _src, _newBalance)
    elseif _type == 'remove' then
        local _newBalance = _atm['balance'] - _amount
        sqlWrapper('UPDATE 3core_atms SET balance = ? WHERE identifier = ?', {_newBalance, _atm['identifier']})
        TriggerClientEvent('3core-atms:updateATMBalance', _src, _newBalance)
    end
end

local function _calcMoney(_amount)
    return (_amount * Config['Fee']) / 100
end

local function _withdrawMoney(_src, _amount)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        local _currentBalance = _player.Functions.GetMoney('bank')
        if _currentBalance >= _amount then
            _player.Functions.RemoveMoney('bank', _amount)
            _player.Functions.AddMoney('cash', _amount)
            TriggerClientEvent('3core-atms:updatePlayerData', _player.PlayerData.source, {['cash'] = _player.Functions.GetMoney('cash'), ['balance'] = _player.Functions.GetMoney('bank')})
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, (Config['Text']['Withdraw']):format(_amount))
            return true
        else
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NoMoney'])
            return false
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        local _currentBalance = _player.getAccount('bank').money
        if _currentBalance >= _amount then
            _player.removeAccountMoney('bank', _amount)
            _player.addMoney(_amount)
            TriggerClientEvent('3core-atms:updatePlayerData', _player.source, {['cash'] = _player.getMoney(), ['balance'] = _player.getAccount('bank').money})
            TriggerClientEvent('3core-atms:notify', _player.source, (Config['Text']['Withdraw']):format(_amount))
            return true
        else
            TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NoMoney'])
            return false
        end
    end
end

local function _depositMoney(_src, _amount)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        local _currentBalance = _player.Functions.GetMoney('cash')
        if _currentBalance >= _amount then
            _player.Functions.RemoveMoney('cash', _amount)
            _player.Functions.AddMoney('bank', _amount)
            TriggerClientEvent('3core-atms:updatePlayerData', _player.PlayerData.source, {['cash'] = _player.Functions.GetMoney('cash'), ['balance'] = _player.Functions.GetMoney('bank')})
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, (Config['Text']['Deposit']):format(_amount))
            return true
        else
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NoMoney'])
            return false
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        local _currentBalance = _player.getMoney()
        if _currentBalance >= _amount then
            _player.removeMoney(_amount)
            _player.addAccountMoney('bank', _amount)
            TriggerClientEvent('3core-atms:updatePlayerData', _player.source, {['cash'] = _player.getMoney(), ['balance'] = _player.getAccount('bank').money})
            TriggerClientEvent('3core-atms:notify', _player.source, (Config['Text']['Deposit']):format(_amount))
            return true
        else
            TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NoMoney'])
            return false
        end
    end
end

local function _transferMoney(_src, _tSrc, _amount)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        local _target = QBCore.Functions.GetPlayer(_tSrc)
        local _currentBalance = _player.Functions.GetMoney('bank')
        if _currentBalance >= _amount then
            if _target then
                _player.Functions.RemoveMoney('bank', _amount)
                _target.Functions.AddMoney('bank', _amount)
                TriggerClientEvent('3core-atms:updatePlayerData', _player.PlayerData.source, {['cash'] = _player.Functions.GetMoney('cash'), ['balance'] = _player.Functions.GetMoney('bank')})
                TriggerClientEvent('3core-atms:updatePlayerData', _target.PlayerData.source, {['cash'] = _target.Functions.GetMoney('cash'), ['balance'] = _target.Functions.GetMoney('bank')})
                TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, (Config['Text']['TransferP']):format(_amount, GetPlayerName(_target.PlayerData.source)))
                TriggerClientEvent('3core-atms:notify', _target.PlayerData.source, (Config['Text']['TransferT']):format(_amount, GetPlayerName(_player.PlayerData.source)))
                return true
            else
                TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NotOnline'])
                return false
            end
        else
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NoMoney'])
            return false
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        local _target = ESX.GetPlayerFromId(_tSrc)
        local _currentBalance = _player.getAccount('bank').money
        if _currentBalance >= _amount then
            if _target then
                _player.removeAccountMoney('bank', _amount)
                _target.addAccountMoney('bank', _amount)
                TriggerClientEvent('3core-atms:updatePlayerData', _player.source, {['cash'] = _player.getMoney(), ['balance'] = _player.getAccount('bank').money})
                TriggerClientEvent('3core-atms:updatePlayerData', _target.source, {['cash'] = _player.getMoney(), ['balance'] = _player.getAccount('bank').money})
                TriggerClientEvent('3core-atms:notify', _player.source, (Config['Text']['TransferP']):format(_amount, GetPlayerName(_target.source)))
                TriggerClientEvent('3core-atms:notify', _target.source, (Config['Text']['TransferT']):format(_amount, GetPlayerName(_player.source)))
                return true
            else
                TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NotOnline'])
                return false
            end
        else
            TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NoMoney'])
            return false
        end
    end
end

local function _esxGetName(_identifier)
    local _character = sqlWrapper('SELECT * FROM users WHERE identifier = ?', {_identifier})
    return _character[1].firstname..' '.._character[1].lastname
end

if Config['FrameworkSettings']['Framework'] == 'QBCore' then
    QBCore.Functions.CreateCallback('3core-atms:getATMData', function(source, cb, atmCoords)
        local _player = QBCore.Functions.GetPlayer(source)
        local _playerData = {
            ['balance'] = _player.Functions.GetMoney('bank'), 
            ['cash'] = _player.Functions.GetMoney('cash'), 
            ['name'] = _player.PlayerData.charinfo.firstname..' '.._player.PlayerData.charinfo.lastname, 
            ['isOwner'] = _checkOwner(_player.PlayerData.citizenid, atmCoords)
        }
        local _atmData = {
            ['atmPrice'] = Config['Price'], 
            ['atmFee'] = Config['Fee'], 
            ['atmOwner'] = _getATMOwner(atmCoords), 
            ['atmBalance'] = _getATMBalance(atmCoords)
        }
        cb(_playerData, _atmData)
    end)
    QBCore.Functions.CreateCallback('3core-atms:canRob', function(source, cb, atmCoords)
        local _atm = _getATMFromLocation(atmCoords)
        if _atm['balance'] > 0 then
            cb(true, nil)
        else
            cb(false, Config['Text']['AtmIsEmpty'])
        end
    end)
elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
    ESX.RegisterServerCallback('3core-atms:getATMData', function(source, cb, atmCoords)
        local _player = ESX.GetPlayerFromId(source)
        local _playerData = {
            ['balance'] = _player.getAccount('bank').money, 
            ['cash'] = _player.getMoney(), 
            ['name'] = _esxGetName(_player.identifier), 
            ['isOwner'] = _checkOwner(_player.identifier, atmCoords)
        }
        local _atmData = {
            ['atmPrice'] = Config['Price'], 
            ['atmFee'] = Config['Fee'], 
            ['atmOwner'] = _getATMOwner(atmCoords), 
            ['atmBalance'] = _getATMBalance(atmCoords)
        }
        cb(_playerData, _atmData)
    end)
    ESX.RegisterServerCallback('3core-atms:canRob', function(source, cb, atmCoords)
        local _atm = _getATMFromLocation(atmCoords)
        if _atm['balance'] > 0 then
            cb(true, nil)
        else
            cb(false, Config['Text']['AtmIsEmpty'])
        end
    end)
end

RegisterServerEvent('3core-atms:buyATM', function(_location)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(source)
        if _player.Functions.GetMoney('cash') >= Config['Price'] then
            _player.Functions.RemoveMoney('cash', Config['Price'])
            sqlWrapper('INSERT INTO 3core_atms (identifier, owner, location, balance) VALUES (?, ?, ?, ?)', {_player.PlayerData.citizenid, _player.PlayerData.charinfo.firstname..' '.._player.PlayerData.charinfo.lastname, json.encode(_location), 0})
            TriggerClientEvent('3core-atms:atmBought', _player.PlayerData.source)
        elseif _player.Functions.GetMoney('bank') >= Config['Price'] then
            _player.Functions.RemoveMoney('bank', Config['Price'])
            sqlWrapper('INSERT INTO 3core_atms (identifier, owner, location, balance) VALUES (?, ?, ?, ?)', {_player.PlayerData.citizenid, _player.PlayerData.charinfo.firstname..' '.._player.PlayerData.charinfo.lastname, json.encode(_location), 0})
            TriggerClientEvent('3core-atms:atmBought', _player.PlayerData.source)
        else
            TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NoMoney'])
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(source)
        if _player.getMoney() >= Config['Price'] then
            _player.removeMoney(Config['Price'])
            sqlWrapper('INSERT INTO 3core_atms (identifier, owner, location, balance) VALUES (?, ?, ?, ?)', {_player.identifier, _esxGetName(_player.identifier), json.encode(_location), 0})
            TriggerClientEvent('3core-atms:atmBought', _player.source)
        elseif _player.getAccount('bank').money >= Config['Price'] then
            _player.removeAccountMoney('bank', Config['Price'])
            sqlWrapper('INSERT INTO 3core_atms (identifier, owner, location, balance) VALUES (?, ?, ?, ?)', {_player.identifier, _esxGetName(_player.identifier), json.encode(_location), 0})
            TriggerClientEvent('3core-atms:atmBought', _player.source)
        else
            TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NoMoney'])
        end
    end
end)

RegisterServerEvent('3core-atms:withdraw', function(_coords, _amount)
    _amount = tonumber(_amount)
    if _withdrawMoney(source, tonumber(_amount)) then
        if Config['FeeActions']['Withdraw'] then
            _updateATMBalance(source, _coords, 'add', _calcMoney(_amount))
        end
    end
end)

RegisterServerEvent('3core-atms:deposit', function(_coords, _amount)
    _amount = tonumber(_amount)
    if _depositMoney(source, _amount) then
        if Config['FeeActions']['Deposit'] then
            _updateATMBalance(source, _coords, 'add', _calcMoney(_amount))
        end
    end
end)

RegisterServerEvent('3core-atms:transfer', function(_coords, _amount, _id)
    _amount = tonumber(_amount)
    _id = tonumber(_id)
    if _transferMoney(source, _id, _amount) then
        if Config['FeeActions']['Transfer'] then
            _updateATMBalance(source, _coords, 'add', _calcMoney(_amount))
        end
    end
end)

RegisterServerEvent('3core-atms:balancewithdraw', function(_coords, _amount)
    _amount = tonumber(_amount)
    local _src = source
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        local _atm = _getATMFromLocation(_coords)
        if _checkOwner(_player.PlayerData.citizenid, _coords) then
            if _atm['balance'] >= _amount then
                _updateATMBalance(_src, _coords, 'remove', _amount)
                _player.Functions.AddMoney('cash', _amount)
                TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, (Config['Text']['Withdraw']):format(_amount))
            else
                TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, Config['Text']['NoMoney'])
            end
        end
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        local _atm = _getATMFromLocation(_coords)
        if _checkOwner(_player.identifier, _coords) then
            if _atm['balance'] >= _amount then
                _updateATMBalance(_src, _coords, 'remove', _amount)
                _player.addMoney(_amount)
                TriggerClientEvent('3core-atms:notify', _player.source, (Config['Text']['Withdraw']):format(_amount))
            else
                TriggerClientEvent('3core-atms:notify', _player.source, Config['Text']['NoMoney'])
            end
        end
    end
end)

RegisterServerEvent('3core-atms:robReward', function(_location)
    local _src = source
    local _atm = _getATMFromLocation(_location)
    if Config['FrameworkSettings']['Framework'] == 'QBCore' then
        local _player = QBCore.Functions.GetPlayer(_src)
        _player.Functions.AddMoney('cash', _atm['balance'])
        _updateATMBalance(_src, _location, 'remove', _atm['balance'])
        TriggerClientEvent('3core-atms:notify', _player.PlayerData.source, (Config['Text']['RobS']):format(_atm['balance']))
    elseif Config['FrameworkSettings']['Framework'] == 'ESX' then
        local _player = ESX.GetPlayerFromId(_src)
        _player.addMoney(_atm['balance'])
        _updateATMBalance(_src, _location, 'remove', _atm['balance'])
        TriggerClientEvent('3core-atms:notify', _player.source, (Config['Text']['RobS']):format(_atm['balance']))
    end
end)