ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)


Fuel = {}
FuelId = {}
Employe = {}
History = {}
furkankey = 0



local function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

ESX.RegisterServerCallback('frkn-fuelstation:getBankingInformation', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Wait(0) end
    if (xPlayer) then
        -- player get name
        local banking = {
            ['name'] = xPlayer.getName(),
            bankbalance = '$' .. xPlayer.getAccount('bank').money,
            cash = '$' .. xPlayer.getMoney()
        }
        print(json.encode(banking))
        cb(banking)
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('frkn-fuelstation:getPlayer', function(source, cb)
    local src = source
    if not src then return end
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local CID = xPlayer.identifier
    if not CID then return end
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '" .. CID .. "' ", {}, function(result)
        print(result[1].frkn_fuelstation_control)
        cb(result[1].frkn_fuelstation_control)
    
    end)
end)

RegisterNetEvent('frkn-fuelstation:setPlayer')
AddEventHandler('frkn-fuelstation:setPlayer', function()
    local src = source
    if not src then return end
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local CID = xPlayer.identifier
    if not CID then return end
    MySQL.Async.execute("UPDATE `users` SET frkn_fuelstation_control = @frkn_fuelstation_control WHERE `identifier` = '" .. CID .. "' ", {
        ['@frkn_fuelstation_control'] = 1
    }, function(result)
    end)
end)

RegisterNetEvent('frkn-fuelstation:setTransfer')
AddEventHandler('frkn-fuelstation:setTransfer', function(cid)
    local src = source
    if not src then return end
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local CID = xPlayer.identifier
    if not CID then return end
    MySQL.Async.execute("UPDATE frkn_fuel SET owner = @owner WHERE owner = '" .. CID .. "'",
        {['@owner'] = cid},
        function(result)
            TriggerEvent('frkn-fuelstation:setPlayer')
        end)

end)



RegisterNetEvent('frkn-fuelstation:buy')
AddEventHandler('frkn-fuelstation:buy', function(id, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    print(id, price)
    xPlayer.removeAccountMoney('bank', price)
    MySQL.Async.execute("UPDATE frkn_fuel SET owner = @owner WHERE id = @id",
        {["id"] = id, ["owner"] = CID}
)
end)

RegisterNetEvent('frkn-fuelstation:tankerfill')
AddEventHandler('frkn-fuelstation:tankerfill', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    local tankerdata = 0
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(result)
        if result[1].level == 1 then
            tankerdata = 2000
        elseif result[1].level == 2 then
            tankerdata = 4000
        elseif result[1].level == 3 then
            tankerdata = 6000
        elseif result[1].level == 4 then
            tankerdata = 8000
        end
        MySQL.Async.execute("UPDATE frkn_fuel SET tanker = @tanker WHERE owner = @owner",
            {["owner"] = CID, ["tanker"] = tankerdata})
    end)
end)


RegisterNetEvent('frkn-fuelstation:levelupdate')
AddEventHandler('frkn-fuelstation:levelupdate', function(id, level)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    local tankerdata = 0
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(result)
            
            if result[1].level == 4 then
                TriggerClientEvent('frkn-fuelstation:notify', src, 'You can not upgrade anymore!', 2)
            else
                MySQL.Async.execute("UPDATE frkn_fuel SET level = @level WHERE owner = '" .. CID .. "'",
                    {["owner"] = CID, ["level"] = result[1].level + 1})
                xPlayer.removeMoney(Config.UpdatePrice)
                if result[1].level == 1 then
                    tankerdata = 4000
                elseif result[1].level == 2 then
                    tankerdata = 6000
                elseif result[1].level == 3 then
                    tankerdata = 8000
                end 
                MySQL.Async.execute("UPDATE frkn_fuel SET tanker_limit = @tanker_limit WHERE owner = @owner",
                    {["owner"] = CID, ["tanker_limit"] = tankerdata})
            end
    end)
end)



RegisterNetEvent('frkn-fuelstation:withdraw')
AddEventHandler('frkn-fuelstation:withdraw', function(jsprice)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(result)
        print(result[1].price - jsprice)
        local dataprice = tonumber(result[1].price)
        local inputprice = tonumber(jsprice)
        local newprice = dataprice - inputprice
        MySQL.Async.execute("UPDATE frkn_fuel SET gas_station_revenue = @gas_station_revenue WHERE owner = @owner",
            {["owner"] = CID, ["gas_station_revenue"] = newprice})
        xPlayer.addMoney(newprice)
    end)
end)

RegisterNetEvent('frkn-fuelstation:nameChange')
AddEventHandler('frkn-fuelstation:nameChange', function(name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(result)
        MySQL.Async.execute("UPDATE frkn_fuel SET fuel_name = @fuel_name WHERE owner = @owner",
            {["owner"] = CID, ["fuel_name"] = name})
    
    end)
end)




local currentcontrol = false
ESX.RegisterServerCallback('frkn-fuelstation:currentopen', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(result)
        for k, v in pairs(result) do
            fuel = {
                id = v.id,
                owner = v.owner,
                fuelname = v.fuel_name,
                coordinat = v.coordinat,
                price = v.price,
                tanker = v.tanker,
                level = v.level,
                gas_station_revenue = v.gas_station_revenue,
                tanker_limit = v.tanker_limit,
                level1price = Config.Level1UpdatePrice,
                level2price = Config.Level2UpdatePrice,
                level3price = Config.Level3UpdatePrice,
                level4price = Config.Level4UpdatePrice,
            }
            currentcontrol = true
            table.insert(Fuel, fuel)
            FuelId = v.id
            cb(fuel)
        end
        MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel_history` WHERE station = '" .. fuel.id .. "'", function(resulthistory)
            for k, v in pairs(resulthistory) do
                
                print(v.id)
            end
        end)
        if result[1].owner == CID then
            cb(json.encode(result[1]))
        else
            end
    end)
    currentcontrol = false
end)




ESX.RegisterServerCallback('frkn-fuelstation:openEmploye', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel_employe` WHERE `citizenid` = '" .. CID .. "' ", {}, function(station)
            
            MySQL.Async.fetchAll("SELECT * FROM frkn_fuel WHERE id= '" .. station[1].station_id .. "'", {}, function(openemp)
                for k, v in pairs(openemp) do
                    emp = {
                        id = v.id,
                        owner = v.owner,
                        fuelname = v.fuel_name,
                        coordinat = v.coordinat,
                        price = v.price,
                        tanker = v.tanker,
                        level = v.level,
                        gas_station_revenue = v.gas_station_revenue,
                        tanker_limit = v.tanker_limit,
                        level1price = Config.Level1UpdatePrice,
                        level2price = Config.Level2UpdatePrice,
                        level3price = Config.Level3UpdatePrice,
                        level4price = Config.Level4pdatePrice,
                    }
                    table.insert(Employe, emp)
                    cb(emp)
                end
            end)
    end)
end)










ESX.RegisterServerCallback('frkn-fuelstation:getemployebyk', function(source, cb, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * from frkn_fuel WHERE owner = @owner", {['@owner'] = CID, }, function(result)
        for k, v in pairs(result) do
            MySQL.Async.fetchAll("SELECT * FROM frkn_fuel_employe WHERE station_id = @stationid", {['@stationid'] = v.id, }, function(salak)
                cb(salak)
            end)
        end
    end)
end)



ESX.RegisterServerCallback('frkn-fuelstation:getTanker', function(source, cb, id)
    MySQL.Async.fetchAll("SELECT tanker FROM frkn_fuel WHERE id = @id", {['@id'] = id, }, function(result)
        for k, v in pairs(result) do
            if v.tanker <= 0 then
                cb(false, v.tanker)
            else
                cb(true, v.tanker)
            end
        end
    end)
end)

ESX.RegisterServerCallback('frkn-fuelstation:getOwner', function(source, cb, id)
    MySQL.Async.fetchAll("SELECT owner FROM frkn_fuel WHERE id = @id", {['@id'] = id, }, function(result)
        for k, v in pairs(result) do
            cb(v.owner)
        end
    end)
end)


local tablek = {}
local tablefill = {}
local tableprice = {}
RegisterNetEvent('frkn-fuel:setTanker')
AddEventHandler('frkn-fuel:setTanker', function(fill, k, price)
        
        tablek = k
        tablefill = fill
        tableprice = price

end)




RegisterNetEvent('frkn-fuel:setTanker')
AddEventHandler('frkn-fuel:setTanker', function(fill, k, price)
    print(fill)
    print(k)
    print(price)
    MySQL.Async.fetchAll("SELECT * FROM frkn_fuel WHERE id = @id", {
        ['@id'] = k
    }, function(resulthistory)
        for i, v in pairs(resulthistory) do
            print(v.tanker)
            if v.tanker < 1 then
                else
                MySQL.Async.execute("UPDATE frkn_fuel SET tanker = @tanker, gas_station_revenue = @gas_station_revenue WHERE id = @id",
                    {["id"] = k, ["tanker"] = v.tanker - fill, ["gas_station_revenue"] = v.gas_station_revenue + price})
            end
        end
    end)
end)






RegisterNetEvent('frkn-fuelstation:employeadd')
AddEventHandler('frkn-fuelstation:employeadd', function(citizenid, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(station)
        MySQL.Async.execute("INSERT INTO frkn_fuel_employe (citizenid,name,station_id) VALUES (@citizenid,@name,@stationid)",
            {["citizenid"] = citizenid, ["name"] = name, ["stationid"] = station[1].id})
    end)
end)


RegisterNetEvent('frkn-fuelstation:employedelete')
AddEventHandler('frkn-fuelstation:employedelete', function(citizenid, name)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    -- MySQL.Async.execute("DELETE FROM `gangs_members` WHERE `cid`='" .. member .. "'")
    -- MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel` WHERE `owner` = '" .. CID .. "' ", {}, function(station)
    MySQL.Async.execute("DELETE FROM frkn_fuel_employe WHERE citizenid = @citizenid",
        {["citizenid"] = citizenid})
-- end)
end)



-- ESX.RegisterServerCallback('frkn-fuelstation:history', function(source, cb)
--     local src = source
--     local xPlayer = ESX.GetPlayerFromId(src)
--     local CID = xPlayer.identifier
--     for k, v in pairs(Fuel) do
--         MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel_history` WHERE station = '" .. v.id .. "'", function(history)
--             cb(history)
--         end)
--     end
-- end)
ESX.RegisterServerCallback('frkn-fuelstation:employehistory', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local CID = xPlayer.identifier
    for k, v in pairs(Employe) do
        MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel_history` WHERE station = '" .. v.id .. "'", {}, function(history)
            cb(history)
        end)
    end
end)


RegisterNetEvent('frkn-fuel:setfuelData')
AddEventHandler('frkn-fuel:setfuelData', function(fill, playerName, vehicleModel, vehiclePlate, price, k)
    MySQL.Async.execute("INSERT INTO frkn_fuel_history (fuel,player_name,vehicle,plate,price,station) VALUES (@fuel,@player_name,@vehicle,@plate,@price,@station)",
        {["fuel"] = fill, ["player_name"] = playerName, ["vehicle"] = vehicleModel, ["plate"] = vehiclePlate, ["price"] = price, ["station"] = k}
)
end)


RegisterNetEvent("frkn-fuelstation:server:PayForFuel", function(amount)
    local src = source
    if not src then return end
    local player = ESX.GetPlayerFromId(src)
    if not player then return end
    player.removeMoney(amount)
end)


AddEventHandler(
    "onResourceStart",
    function(c)
        if c == GetCurrentResourceName() then
            MySQL.ready(
                function()
                    getFuelInfo()
                end
        )
        end
    end
)
local a = {}
local functioncontrol = false
ESX.RegisterServerCallback('frkn-fuelstation:info', function(source, e)
    Citizen.Wait(100)
    e(a)
end)


function getFuelInfo()
    MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel`", {}, function(d)
        a = d
    end)
end


local s = {}
ESX.RegisterServerCallback('frkn-fuelstation:history', function(source, cb)
    gethistory()
    Citizen.Wait(100)
    cb(s)
end)
function gethistory()
    if currentcontrol == true then
        MySQL.Async.fetchAll("SELECT * FROM `frkn_fuel_history` WHERE `station` = '" .. FuelId .. "' ", {}, function(u)
            s = u
        end)
    end
end


local data = {}
ESX.RegisterServerCallback('frkn-fuelstation:getusers', function(source, z)
    getuserInfo()
    Citizen.Wait(100)
    print(json.encode(data))
    z(data)
end)

function getuserInfo()
    MySQL.Async.fetchAll("SELECT * FROM users", {}, function(b)
        print(json.encode(b))
        data = b
    end)
end
