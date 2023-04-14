Config = Config or {}
Config.Target = {}
Config.Proximity = {}
Config.Polyzones = {}

-- normal, target or proximity
-- normal: Uses qb-core draw texts with polyzones
-- target: Uses targetting (Config.TargetScript)
-- proximity: Uses zerio-proximityprompt
Config.OpenType = "normal"

-- Only for Config.OpenType "target"
-- qb-target or ox_target
Config.Target.Script = "ox_target"
Config.Target.UsageDistance = 2.5
Config.Target.Icon = "fa-solid fa-wrench"
Config.Target.Size = {2, 2, 2} -- 2 numbers if qb-target, 3 numbers if ox_target

-- Only for Config.OpenType "proximity"
Config.Proximity.DrawDistance = 3
Config.Proximity.UsageDistance = 1.5
Config.Proximity.Key = "E"
Config.Proximity.HoldTime = 1000

-- Only for Config.OpenType "normal"
Config.Polyzones.Size = {2, 2}
Config.Polyzones.KeyLabel = "E"
Config.Polyzones.KeyNumber = 38 -- https://docs.fivem.net/docs/game-references/controls/

-- Javascript alpahabetical currency code should be used for this, https://www.techonthenet.com/js/currency_codes.php
Config.Currency = "USD"

Config.Positions = {
    ["mechanic"] = {pos = vector4(1862.17, -1782.69, 13.17, 84.28)}
}

Config.Prices = {
    cosmetics = 400,
    respray = 1000,
    engine = {0, 3250, 5500, 10450, 15250, 20500, 25000},
    brakes = {0, 3250, 5500, 10450, 15250, 20500, 25000},
    transmission = {0, 3250, 5500, 10450, 15250, 20500, 25000},
    suspension = {0, 3250, 5500, 10450, 15250, 20500, 25000},
    armor = {0, 3250, 5500, 10450, 15250, 20500, 25000},
    turbo = {0, 15000},
    wheels = 400,
    customwheels = 600,
    wheelsmoke = 400,
    windowtint = 400,
    neonside = 100,
    neoncolours = 500,
    headlights = 100,
    xenoncolours = 500,
    horn = 500,
    livery = 500,
    plateindex = 1000
}

-- Dont touch if you dont know what you are doing
Config.VehicleCustomisation = {
    {category = "Spoiler", id = 0, pricing = "cosmetics"},
    {category = "Front Bumper", id = 1, pricing = "cosmetics"},
    {category = "Rear Bumper", id = 2, pricing = "cosmetics"},
    {category = "Side Skirt", id = 3, pricing = "cosmetics"},
    {category = "Exhaust", id = 4, pricing = "cosmetics"},
    {category = "Roll Cage", id = 5, pricing = "cosmetics"},
    {category = "Grille", id = 6, pricing = "cosmetics"},
    {category = "Hood", id = 7, pricing = "cosmetics"},
    {category = "Left Fender", id = 8, pricing = "cosmetics"},
    {category = "Right Fender", id = 9, pricing = "cosmetics"},
    {category = "Roof", id = 10, pricing = "cosmetics"},
    {category = "Engine Upgrade", id = 11, pricing = "engine"},
    {category = "Brake Upgrade", id = 12, pricing = "brakes"},
    {category = "Transmission Upgrade", id = 13, pricing = "transmission"},
    {category = "Suspension Upgrade", id = 15, pricing = "suspension"},
    {category = "Armour Upgrade", id = 16, pricing = "armor"},
    {category = "Turbo Upgrade", id = 18, pricing = "turbo"},
    {category = "Vanity Plate", id = 25, pricing = "cosmetics"},
    {category = "Trim A", id = 27, pricing = "cosmetics"},
    {category = "Ornaments", id = 28, pricing = "cosmetics"},
    {category = "Dashboard", id = 29, pricing = "cosmetics"},
    {category = "Dial", id = 30, pricing = "cosmetics"},
    {category = "Door Speaker", id = 31, pricing = "cosmetics"},
    {category = "Seats", id = 32, pricing = "cosmetics"},
    {category = "Steering Wheel", id = 33, pricing = "cosmetics"},
    {category = "Shifter Leaver", id = 34, pricing = "cosmetics"},
    {category = "Plaque", id = 35, pricing = "cosmetics"},
    {category = "Speaker", id = 36, pricing = "cosmetics"},
    {category = "Trunk", id = 37, pricing = "cosmetics"},
    {category = "Hydraulic", id = 38, pricing = "cosmetics"},
    {category = "Engine Block", id = 39, pricing = "cosmetics"},
    {category = "Air Filter", id = 40, pricing = "cosmetics"},
    {category = "Strut", id = 41, pricing = "cosmetics"},
    {category = "Arch Cover", id = 42, pricing = "cosmetics"},
    {category = "Aerial", id = 43, pricing = "cosmetics"},
    {category = "Trim B", id = 44, pricing = "cosmetics"},
    {category = "Fuel Tank", id = 45, pricing = "cosmetics"},
    {category = "Window", id = 46, pricing = "windowtint"},
    {category = "Livery", id = 48, pricing = "livery"}, {
        category = "Horn",
        id = 14,
        pricing = "horn",
        options = {
            {name = "Truck Horn", id = 0}, {name = "Cop Horn", id = 1},
            {name = "Clown Horn", id = 2}, {name = "Musical Horn 1", id = 3},
            {name = "Musical Horn 2", id = 4},
            {name = "Musical Horn 3", id = 5},
            {name = "Musical Horn 4", id = 6},
            {name = "Musical Horn 5", id = 7}, {name = "Sad Trombone", id = 8},
            {name = "Classical Horn 1", id = 9},
            {name = "Classical Horn 2", id = 10},
            {name = "Classical Horn 3", id = 11},
            {name = "Classical Horn 4", id = 12},
            {name = "Classical Horn 5", id = 13},
            {name = "Classical Horn 6", id = 14},
            {name = "Classical Horn 7", id = 15},
            {name = "Scale - Do", id = 16}, {name = "Scale - Re", id = 17},
            {name = "Scale - Mi", id = 18}, {name = "Scale - Fa", id = 19},
            {name = "Scale - Sol", id = 20}, {name = "Scale - La", id = 21},
            {name = "Scale - Ti", id = 22}, {name = "Scale - Do", id = 23},
            {name = "Jazz Horn 1", id = 24}, {name = "Jazz Horn 2", id = 25},
            {name = "Jazz Horn 3", id = 26}, {name = "Jazz Horn Loop", id = 27},
            {name = "Star Spangled Banner 1", id = 28},
            {name = "Star Spangled Banner 2", id = 29},
            {name = "Star Spangled Banner 3", id = 30},
            {name = "Star Spangled Banner 4", id = 31},
            {name = "Classical Horn 8 Loop", id = 32},
            {name = "Classical Horn 9 Loop", id = 33},
            {name = "Classical Horn 10 Loop", id = 34},
            {name = "Classical Horn 8", id = 35},
            {name = "Classical Horn 9", id = 36},
            {name = "Classical Horn 10", id = 37},
            {name = "Funeral Loop", id = 38}, {name = "Funeral", id = 39},
            {name = "Spooky Loop", id = 40}, {name = "Spooky", id = 41},
            {name = "San Andreas Loop", id = 42},
            {name = "San Andreas", id = 43},
            {name = "Liberty City Loop", id = 44},
            {name = "Liberty City", id = 45},
            {name = "Festive 1 Loop", id = 46}, {name = "Festive 1", id = 47},
            {name = "Festive 2 Loop", id = 48}, {name = "Festive 2", id = 49},
            {name = "Festive 3 Loop", id = 50}, {name = "Festive 3", id = 51}
        }
    }
}

-- COLORS
Config.ResprayOptions = {
    {
        category = "Standard",
        id = 0,
        colours = {
            {name = "Black", id = 0}, {name = "Carbon Black", id = 147},
            {name = "Graphite", id = 1}, {name = "Anhracite Black", id = 11},
            {name = "Black Steel", id = 2}, {name = "Dark Steel", id = 3},
            {name = "Silver", id = 4}, {name = "Bluish Silver", id = 5},
            {name = "Rolled Steel", id = 6}, {name = "Shadow Silver", id = 7},
            {name = "Stone Silver", id = 8}, {name = "Midnight Silver", id = 9},
            {name = "Cast Iron Silver", id = 10}, {name = "Red", id = 27},
            {name = "Torino Red", id = 28}, {name = "Formula Red", id = 29},
            {name = "Lava Red", id = 150}, {name = "Blaze Red", id = 30},
            {name = "Grace Red", id = 31}, {name = "Garnet Red", id = 32},
            {name = "Sunset Red", id = 33}, {name = "Cabernet Red", id = 34},
            {name = "Wine Red", id = 143}, {name = "Candy Red", id = 35},
            {name = "Hot Pink", id = 135}, {name = "Pfsiter Pink", id = 137},
            {name = "Salmon Pink", id = 136},
            {name = "Sunrise Orange", id = 36}, {name = "Orange", id = 38},
            {name = "Bright Orange", id = 138}, {name = "Gold", id = 99},
            {name = "Bronze", id = 90}, {name = "Yellow", id = 88},
            {name = "Race Yellow", id = 89}, {name = "Dew Yellow", id = 91},
            {name = "Dark Green", id = 49}, {name = "Racing Green", id = 50},
            {name = "Sea Green", id = 51}, {name = "Olive Green", id = 52},
            {name = "Bright Green", id = 53},
            {name = "Gasoline Green", id = 54}, {name = "Lime Green", id = 92},
            {name = "Midnight Blue", id = 141}, {name = "Galaxy Blue", id = 61},
            {name = "Dark Blue", id = 62}, {name = "Saxon Blue", id = 63},
            {name = "Blue", id = 64}, {name = "Mariner Blue", id = 65},
            {name = "Harbor Blue", id = 66}, {name = "Diamond Blue", id = 67},
            {name = "Surf Blue", id = 68}, {name = "Nautical Blue", id = 69},
            {name = "Racing Blue", id = 73}, {name = "Ultra Blue", id = 70},
            {name = "Light Blue", id = 74}, {name = "Chocolate Brown", id = 96},
            {name = "Bison Brown", id = 101}, {name = "Creeen Brown", id = 95},
            {name = "Feltzer Brown", id = 94}, {name = "Maple Brown", id = 97},
            {name = "Beechwood Brown", id = 103},
            {name = "Sienna Brown", id = 104}, {name = "Saddle Brown", id = 98},
            {name = "Moss Brown", id = 100},
            {name = "Woodbeech Brown", id = 102},
            {name = "Straw Brown", id = 99}, {name = "Sandy Brown", id = 105},
            {name = "Bleached Brown", id = 106},
            {name = "Schafter Purple", id = 71},
            {name = "Spinnaker Purple", id = 72},
            {name = "Midnight Purple", id = 142},
            {name = "Bright Purple", id = 145}, {name = "Cream", id = 107},
            {name = "Ice White", id = 111}, {name = "Frost White", id = 112}
        }
    }, {
        category = "Matte",
        id = 1,
        colours = {
            {name = "Black", id = 12}, {name = "Gray", id = 13},
            {name = "Light Gray", id = 14}, {name = "Ice White", id = 131},
            {name = "Blue", id = 83}, {name = "Dark Blue", id = 82},
            {name = "Midnight Blue", id = 84},
            {name = "Midnight Purple", id = 149},
            {name = "Schafter Purple", id = 148}, {name = "Red", id = 39},
            {name = "Dark Red", id = 40}, {name = "Orange", id = 41},
            {name = "Yellow", id = 42}, {name = "Lime Green", id = 55},
            {name = "Green", id = 128}, {name = "Forest Green", id = 151},
            {name = "Foliage Green", id = 155}, {name = "Olive Darb", id = 152},
            {name = "Dark Earth", id = 153}, {name = "Desert Tan", id = 154}
        }
    }, {
        category = "Metals",
        id = 2,
        colours = {
            {name = "Brushed Steel", id = 117},
            {name = "Brushed Black Steel", id = 118},
            {name = "Brushed Aluminium", id = 119},
            {name = "Pure Gold", id = 158}, {name = "Brushed Gold", id = 159},
            {name = "Chrome", id = 120}
        }
    }
}
