Config = {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.TruckerJobTruckDeposit = 125
Config.TruckerJobFixedLocation = false
Config.TruckerJobMaxDrops = 20 -- amount of locations before being forced to return to station to reload
Config.TruckerJobDropPrice = 500
Config.TruckerJobBonus = 20 -- this is a percentage to calculate bonus over 5 deliveries.
Config.TruckerJobPaymentTax = 15

Config.TruckerJobLocations = {
    ["main"] = {
        label = "Truck Shed",
        coords = vector4(-103.76, -365.54, 1.43, 265.33),
    },
    ["vehicle"] = {
        label = "Truck Storage",
        coords = vector4(-116.65, -328.33, 1.45, 359.31),
    },
    ["stores"] ={
        [1] = {
            name = "idlewood", -- store name referenced to qb-shops
            coords = vector4(1912.61, -1779.75, 12.86, 178.99), -- idlewood 24 7
        },
        [2] = {
            name = "247supermarket",
            vector4(-1528.89, 2644.02, 55.85, 280.63), -- vinewood 24 7t/set
        },
    }
}



Config.TruckerJobVehicles = {
    ["rumpo"] = {
        ["label"] = "Rumpo Delivery Van",
        ["cargodoors"] = {
            [0] = 2,
            [1] = 3
        },
        ["trunkpos"] = 1.5
    },
    ["benson"] = {
        ["label"] = "Benson Box Truck",
        ["jobrep"] = 0,
        ["cargodoors"] = {
            [0] = 5
        },
        ["trunkpos"] = 3
    },
    ["mule5"] = {
        ["label"] = "Mule Box Truck",
        ["jobrep"] = 0,
        ["cargodoors"] = {
            [0] = 2,
            [1] = 3
        },
        ["trunkpos"] = 1.5
    },
    ["pounder"] = {
        ["label"] = "Pounder Box Truck",
        ["jobrep"] = 0,
        ["cargodoors"] = {
            [0] = 2,
            [1] = 3
        },
        ["trunkpos"] = 7
    },
    ["boxville4"] = {
        ["label"] = "Boxville StepVan",
        ["jobrep"] = 0,
        ["cargodoors"] = {
            [0] = 2,
            [1] = 3
        },
        ["trunkpos"] = 1.5
    },
}