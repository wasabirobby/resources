local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bp:gi')
AddEventHandler('bp:gi', function(item, count)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)      
    xPlayer.Functions.AddItem(item, count)
end)

RegisterNetEvent('bp:prize')
AddEventHandler('bp:prize', function(prize, props,prizecarname)
        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)        
        if prize.type == "item" then
            xPlayer.Functions.AddItem(prize.item, prize.count)
            return
        end
        
        if prize.type == "coin" then
            local result = MySQL.Sync.fetchAll("SELECT players.credits FROM players WHERE players.citizenid = @citizenid", {['@citizenid'] = xPlayer.PlayerData.citizenid})
            if result then
                newcredit = result[1].credits + prize.count
                MySQL.Async.execute('UPDATE players SET `credits` = @credits WHERE citizenid = @citizenid  ', {['@credits'] = newcredit, ['@citizenid'] = xPlayer.PlayerData.citizenid})
            end
            return
        end
        
        if prize.type == "car" or prize.type == "boat" or prize.type == "helicopter" then
            if props then
                MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                    xPlayer.PlayerData.license,
                    xPlayer.PlayerData.citizenid,
                    prizecarname,
                    GetHashKey(prizecarname),
                    json.encode(props),
                    props.plate,
                    'pillboxgarage',
                    0
                })
            end
        end
end)

RegisterNetEvent('frkn:buycash')
AddEventHandler('frkn:buycash', function(money)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)   
    xPlayer.Functions.AddMoney('bank', tonumber(money))
end)

RegisterNetEvent('frkn:buyitem')
AddEventHandler('frkn:buyitem', function(item)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddItem(item, 1)
end)


RegisterNetEvent('frkn:setowned')
AddEventHandler('frkn:setowned', function(props,carname)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            xPlayer.PlayerData.license,
            xPlayer.PlayerData.citizenid,
            carname,
            GetHashKey(carname),
            json.encode(props),
            props.plate,
            'pillboxgarage',
            0
        })
end)


QBCore.Functions.CreateCallback('bp:checkCoin', function(source, cb)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll("SELECT players.credits FROM players WHERE players.citizenid = @citizenid", {['@citizenid'] =xPlayer.PlayerData.citizenid})
    cb(result[1].credits)
end)

RegisterNetEvent('bp:deleteCoin')
AddEventHandler('bp:deleteCoin', function(credit)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll("SELECT players.credits FROM players WHERE players.citizenid = @citizenid", {['@citizenid'] = xPlayer.PlayerData.citizenid})
    if result then
        newcredit = result[1].credits - credit
        MySQL.Async.execute('UPDATE players SET `credits` = @credits WHERE citizenid = @citizenid  ', {['@credits'] = newcredit, ['@citizenid'] = xPlayer.PlayerData.citizenid})
    end
end)

RegisterNetEvent('bp:case')
AddEventHandler('bp:case', function(name)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddItem(name, 1)
end)


RegisterNetEvent('frkn:setrent')
AddEventHandler('frkn:setrent', function(props,carrentname)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local date = os.date("%Y-%m-%d %H:%M:%S")
    local datefinish = os.date("%Y-%m-%d %H:%M:%S", os.time() + (Config.Day * 24 * 60 * 60))
    MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state,datefinish) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)', {
        xPlayer.PlayerData.license,
        xPlayer.PlayerData.citizenid,
        carrentname,
        GetHashKey(carrentname),
        json.encode(props),
        props.plate,
        'pillboxgarage',
        0,
        datefinish
    })
end)



AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    MySQL.Async.execute("DELETE FROM player_vehicles WHERE datefinish < NOW()", {})
end)

QBCore.Commands.Add('coinadd', 'Give Player Coin (Admin Only)', {}, true, function(source, args)
    local player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if player then
        MySQL.Async.execute("UPDATE players SET `credits` = @credi WHERE citizenid = @citizenid", {
            ['@citizenid'] = player.PlayerData.citizenid,
            ['@credi'] = tonumber(args[2])
        })
    end
end, 'god')
