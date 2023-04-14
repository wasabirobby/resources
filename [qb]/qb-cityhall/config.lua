Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.AvailableJobs = { -- Only used when not using qb-jobs.
    ["trucker"] = {["label"] = "Trucker", ["isManaged"] = false},
    ["taxi"] = {["label"] = "Taxi", ["isManaged"] = false},
    ["tow"] = {["label"] = "Tow Truck", ["isManaged"] = false},
    ["reporter"] = {["label"] = "News Reporter", ["isManaged"] = false},
    ["garbage"] = {["label"] = "Garbage Collector", ["isManaged"] = false},
    ["bus"] = {["label"] = "Bus Driver", ["isManaged"] = false},
    ["busls"] = {["label"] = "Bus Driver Los Santos surroundings", ["isManaged"] = false},
    ["hotdog"] = {["label"] = "Hot Dog Stand", ["isManaged"] = false}
}

Config.Cityhalls = {
    { -- Cityhall 1
        coords = vector3(1480.93, -1784.69, 16.84),
        showBlip = true,
        blipData = {
            sprite = 487,
            display = 4,
            scale = 0.65,
            colour = 0,
            title = "City Services"
        },
        licenses = {
            ["id_card"] = {
                label = "ID Card",
                cost = 50,
            },
            ["driver_license"] = {
                label = "Driver License",
                cost = 50,
                metadata = "driver"
            },
            ["weaponlicense"] = {
                label = "Weapon License",
                cost = 50,
                metadata = "weapon"
            },
        }
    },
}

Config.DrivingSchools = {
    { -- Driving School 1
        coords = vector3(1458.5, -1758.73, 13.55),
        showBlip = true,
        blipData = {
            sprite = 225,
            display = 4,
            scale = 0.65,
            colour = 3,
            title = "Driving School"
        },
        instructors = {
            "DJD56142",
            "DXT09752",
            "SRI85140",
        }
    },
}

Config.Peds = {
    -- Cityhall Ped
    {
        model = 'a_m_m_hasjew_01',
        coords = vector4(1480.73, -1784.91, 15.84, 8.93),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        cityhall = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = false
        }
    },
    -- Driving School Ped
    {
        model = 'a_m_m_eastsa_02',
        coords = vector4(1458.32, -1758.23, 12.55, 24.81),
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        drivingschool = true,
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0
        }
    }
}
