lc = 0
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNUICallback("getCase", function(data, cb)
    cb(getCase(tonumber(data.no)))
end)


function getCase(x)
    for i, v in pairs(Config.Cases) do
        if v.no == x then
            return v
        end
    end
end

RegisterNUICallback("checkCoin", function(data, cb)
    QBCore.Functions.TriggerCallback('bp:checkCoin', function(x)
        if x >= data.credit then
            cb(true)
            if data.buytype == "rent" then
                carrent(data.carname)
            elseif data.buytype == "owned" then
                carbuy(data.carname)
            elseif data.buytype == "cash" then
                buycash(data.money)
            elseif data.buytype == "item" then
                buyitem(data.item)
            elseif data.buytype == "pack" then
                buypack(data.price, data.name)
            end
            TriggerServerEvent("bp:deleteCoin", data.credit)
        else
            print("not enough money")
            cb(false)
        end
    end)
end)

function buypack(price, name)
    TriggerServerEvent("frkn:buycash", tonumber(price))
    Citizen.CreateThread(function()
        RequestModel(GetHashKey(name))
        while not HasModelLoaded(GetHashKey(name)) do
            Wait(1000)
        end
        coords = GetEntityCoords(PlayerPedId())
        local ownedvehicle = CreateVehicle(name, vector3(coords.x, coords.y, coords.z - 30.0), true, true)
        SetVehicleNumberPlateText(name, GetVehicleNumberPlateText(name))
        TriggerServerEvent("frkn:setowned", QBCore.Functions.GetVehicleProperties(ownedvehicle),name)
        Wait(5000)
        DeleteVehicle(ownedvehicle)
        DeleteEntity(ownedvehicle)
    end)
end

function buyitem(item)
    TriggerServerEvent("frkn:buyitem", item)
end

function buycash(money)
    TriggerServerEvent("frkn:buycash", money)
end

function carbuy(carownedname)
    Citizen.CreateThread(function()
        RequestModel(GetHashKey(carownedname))
        while not HasModelLoaded(GetHashKey(carownedname)) do
            Wait(1000)
        end
        coords = GetEntityCoords(PlayerPedId())
        local ownedvehicle = CreateVehicle(carownedname, vector3(coords.x, coords.y, coords.z - 30.0), true, true)
        SetVehicleNumberPlateText(ownedvehicle, GetVehicleNumberPlateText(ownedvehicle))
        TriggerServerEvent("frkn:setowned", QBCore.Functions.GetVehicleProperties(ownedvehicle),carownedname)
        Wait(5000)
        DeleteVehicle(ownedvehicle)
        DeleteEntity(ownedvehicle)
    end)
end


function carrent(carname)
    Citizen.CreateThread(function()
        RequestModel(GetHashKey(carname))
        while not HasModelLoaded(GetHashKey(carname)) do
            Wait(1000)
        end
        coords = GetEntityCoords(PlayerPedId())
        local ownedvehicle = CreateVehicle(carname, vector3(coords.x, coords.y, coords.z - 30.0), true, true)
        SetVehicleNumberPlateText(ownedvehicle, GetVehicleNumberPlateText(ownedvehicle))
        TriggerServerEvent("frkn:setrent", QBCore.Functions.GetVehicleProperties(ownedvehicle),carname)
        Wait(5000)
        DeleteVehicle(ownedvehicle)
        DeleteEntity(ownedvehicle)
    end)
end

playercoordstable = {}
RegisterNUICallback("test", function(data, cb)
    playercoordstable = GetEntityCoords(PlayerPedId())
    Citizen.CreateThread(function()
        RequestModel(GetHashKey(data.name))
        while not HasModelLoaded(GetHashKey(data.name)) do
            Wait(1000)
        end
        coords = GetEntityCoords(PlayerPedId())
        local testvehicle = CreateVehicle(data.name, Config.TestDrive.coords)
        SetVehicleNumberPlateText(testvehicle, GetVehicleNumberPlateText(testvehicle))
        SetEntityCoords(PlayerPedId(), Config.TestDrive.coords)
        Citizen.Wait(200)
        SetPedIntoVehicle(PlayerPedId(), testvehicle, -1)
        SetVehicleNumberPlateText(testvehicle, "testcar")
        Citizen.Wait(Config.TestDrive.seconds * 1000)
        SetEntityCoords(PlayerPedId(), playercoordstable)
        DeleteVehicle(testvehicle)
        DeleteEntity(testvehicle)
    end)
end)








RegisterNUICallback("prize", function(data, cb)
    prize = data.prize
    if prize.type == "car" or prize.type == "boat" or prize.type == "helicopter" then
        Citizen.CreateThread(function()
            RequestModel(GetHashKey(prize.item))
            while not HasModelLoaded(GetHashKey(prize.item)) do
                Wait(1000)
            end
            coords = GetEntityCoords(PlayerPedId())
            local xVehicle = CreateVehicle(prize.item, vector3(coords.x, coords.y, coords.z - 30.0), true, true)
            SetVehicleNumberPlateText(xVehicle, GetVehicleNumberPlateText(xVehicle))
            TriggerServerEvent("bp:prize", prize, QBCore.Functions.GetVehicleProperties(xVehicle),prize.item)
            Wait(5000)
            DeleteVehicle(xVehicle)
            DeleteEntity(xVehicle)
        end)
    else
        TriggerServerEvent("bp:prize", prize)
    end
end)

RegisterNUICallback("case", function(data, cb)
    TriggerServerEvent("bp:case", data.name)
end)

RegisterNUICallback("close", function(data, cb)
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(0, 0)
end)

function close()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(0, 0)
end

RegisterNUICallback("getCoin", function(data, cb)
    QBCore.Functions.TriggerCallback('bp:checkCoin', function(x)
        lc = x
        cb(x)
    end)
end)

RegisterNUICallback("checkPrice", function(data, cb)
    if getCase(data.id).credit < lc then
        TriggerServerEvent("bp:deleteCoin", getCase(data.id).credit)
        cb(true)
    end
end)

RegisterCommand("vipopen", function(source, args, rawCommand)
    for k, v in pairs(Config.Table) do
        SendNUIMessage({
            action = "load",
            config = Config,
            RentCar = v.RentCar,
            OwnedCar = v.OwnedCar,
            Item = v.Item,
            BuyingCash = v.BuyingCash,
            PromotionPack = v.PromotionPack,
        })
        SetNuiFocus(1, 1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Time)
        TriggerServerEvent("bp:prize", {type = "coin", item = "coin", count = Config.GivePeriodCoin})
    end
end)
