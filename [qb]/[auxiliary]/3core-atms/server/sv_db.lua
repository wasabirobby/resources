sqlWrapper = function(_query, _parameters, _cb)
    local _res = nil
    local _IsBusy = true
    if Config['FrameworkSettings']['SQLWrapper'] == 'mysql-async' then
        if string.find(_query, "SELECT") then
            MySQL.Async.fetchAll(_query, _parameters, function(_result)
                if _cb then
                    _cb(_result)
                else
                    _res = _result
                    _IsBusy = false
                end
            end)
        else
            MySQL.Async.execute(_query, _parameters, function(_result)
                if _cb then
                    _cb(_result)
                else
                    _res = _result
                    _IsBusy = false
                end
            end)
        end
    elseif Config['FrameworkSettings']['SQLWrapper'] == 'oxmysql' then
        if string.find(_query, "INSERT") then
            if _cb then
                exports.oxmysql:insert(_query, _parameters, function(_result) cb(_result) end)
            else
                _res = exports.oxmysql:insert_async(_query, _parameters)
                _IsBusy = false
            end
        elseif string.find(_query, "UPDATE") then
            if _cb then
                exports.oxmysql:update(_query, _parameters, function(_result) cb(_result) end)
            else
                _res = exports.oxmysql:update_async(_query, _parameters)
                _IsBusy = false
            end
        elseif string.find(_query, "SELECT") then
            if _cb then
                exports.oxmysql:query(_query, _parameters, function(_result) cb(_result) end)
            else
                _res = exports.oxmysql:query_async(_query, _parameters)
                _IsBusy = false
            end
        end
    end
    while _IsBusy do Citizen.Wait(0) end
    return _res
end