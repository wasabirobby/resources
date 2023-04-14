Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 2

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Locations = {
    ["duty"] = {
        [1] = vector3(1587.61, -1676.29, 13.11), 
        [2] = vector3(-449.811, 6012.909, 31.815),
    },
    ["vehicle"] = {
        [1] = vector4(1578.4, -1712.76, 5.89, 353.94),
        [2] = vector4(1574.67, -1712.7, 5.89, 359.97),
        [3] = vector4(1570.1, -1712.94, 5.89, 1.47),
    },
    ["stash"] = {
        [1] = vector3(1583.04, -1676.39, 13.12),
        --[2] = vector3(1582.02, -1679.58, 13.1),
        --[3] = vector3(1578.56, -1675.11, 13.12),
        --[4] = vector3(1578.21, -1676.33, 13.12),
    },
    ["impound"] = {
        [1] = vector3(1585.84, -1677.9, 5.9),
        [2] = vector3(1528.09, -1676.63, 5.89),
    },
    ["helicopter"] = {
        [1] = vector4(1566.28, -1653.88, 30.21, 37.85),
        [2] = vector4(1564.67, -1700.24, 28.4, 213.57),
    },
    ["armory"] = {
        [1] = vector3(1582.97, -1667.67, 13.12),
    },
    ["trash"] = {
        [1] = vector3(1565.81, -1703.37, 13.12),
    },
    ["fingerprint"] = {
        [1] = vector3(1582.29, -1706.14, 13.11),
    },
    ["evidence"] = {
        [1] = vector3(1579.25, -1698.93, 13.11),
        [2] = vector3(1579.85, -1696.34, 13.11),
        [3] = vector3(1586.11, -1696.3, 13.11),
    },
    ["stations"] = {
        [1] = {label = "Police Station", coords = vector4(1722.44, -1786.94, 13.34, 352.95)},
        [2] = {label = "Prison", coords = vector4(1539.86, -1675.23, 13.55, 179.09)},
        [3] = {label = "Police Station Paleto", coords = vector4(-451.55, 6014.25, 31.716, 223.81)},
    },
}

Config.ArmoryWhitelist = {}

Config.PoliceHelicopter = "POLMAV"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Market intersection ", coords = vector3(1364.23, -1389.48, 16.61), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true, isOnline = true},
        [2] = {label = "Pacific Bank CAM#1", coords = vector3(-1900.06, 1159.41, 76.59), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = true, isOnline = true},
        [3] = {label = "Pacific Bank CAM#2", coords = vector3(-1906.23, 1144.7, 52.92), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Chase Bank CAM#1", coords = vector3(1336.34, -965.04, 77.25), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = true, isOnline = true},
        [5] = {label = "Verona Mall CAM#1", coords = vector3(1154.55, -1414.78, 51.07), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = true, isOnline = true},
        [6] = {label = "Pasadena Hotel BLVD CAM#1", coords = vector3(362.43, -1549.32, 36.86), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = true, isOnline = true},
        [7] = {label = "Palomino Creek Bank CAM#1", coords = vector3(2306.48, -17.07, 30.59), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "Palomino Creek Bank CAM#2", coords = vector3(2303.7, -18.5, 33.17), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = true, isOnline = true},
        [9] = {label = "Pacific Bank CAM#3", coords = vector3(-1917.37, 1148.91, 45.27), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Pacific Bank CAM#4", coords = vector3(-1918.08, 1136.6, 45.83), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "Pacifict Bank CAM#5", coords = vector3(-1932.03, 1162.69, 53.31), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = true, isOnline = true},
        [12] = {label = "SF Tunnel CAM#1", coords = vector3(-1715.28, -744.12, 41.03), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = true, isOnline = true},
        [13] = {label = "LSPD Pershing CAM#1", coords = vector3(1541.6, -1651.5, 28.37), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = true, isOnline = true},
        [14] = {label = "Court Room CAM#1", coords = vector3(1505.07, -1775.18, 22.61), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "LSPD Garage CAM#1", coords = vector3(1554.9, -1721.04, 10.71), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = true, isOnline = true},
        [16] = {label = "LSPD Armory", coords = vector3(1587.03, -1668.91, 16.17), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = true, isOnline = true},
        [17] = {label = "LSPD Locker ROOM CAM#1", coords = vector3(1583.62, -1673.73, 16.06), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "LSPD Stash room", coords = vector3(1572.98, -1696.4, 15.75), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "LSPD Cells CAM#1", coords = vector3(1576.14, -1685.35, 16.07), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = true, isOnline = true},
        [20] = {label = "Robada PD CAM#1", coords = vector3(-1436.12, 2659.08, 68.93), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = true, isOnline = true},
        [21] = {label = "Robada PD CAM#1", coords = vector3(-1473.24, 2633.33, 68.84), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = true, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		--["police"] = "Police Car 1",
		--["police2"] = "Police Car 2",
		--["police3"] = "Police Car 3",
		--["police4"] = "Police Car 4",
		--["policeb"] = "Police Car 5",
		--["policet"] = "Police Car 6",
		--["sheriff"] = "Sheriff Car 1",
		--["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 1
	[1] = {
		["police"] = "Police Car 1",
	    ["police2"] = "Police Car 2",
	--[[["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",--]]

	},
	-- Grade 2
	[2] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		--["police4"] = "Police Car 4",
		--["policeb"] = "Police Car 5",
		--["policet"] = "Police Car 6",
		--["sheriff"] = "Sheriff Car 1",
		--["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 3
	[3] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		--["policeb"] = "Police Car 5",
		--["policet"] = "Police Car 6",
		--["sheriff"] = "Sheriff Car 1",
		--["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 4
	[4] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		--["sheriff"] = "Sheriff Car 1",
		--["sheriff2"] = "Sheriff Car 2",
	},-- Grade 5
	[5] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},-- Grade 6
	[6] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	}
}

Config.WhitelistedVehicles = {}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_SMG"] = "9x19mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
}

Config.Radars = {
	vector4(1365.22, -1396.06, 13.01, 12.29),
	vector4(-2577.99, 573.42, 14.11, 261.5),
	vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
	vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
	vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
	vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
	vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
	vector4(657.315, -218.819, 44.06, 320.0),
	vector4(2118.287, 6040.027, 50.928, 172.0),
	vector4(-106.304, -1127.5530, 30.778, 230.0),
	vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    [1] = {
        name = "heavyarmor",
        amount = 2,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [3] = {
        name = "police_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        [1] = {
            name = "weapon_pistol",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [2] = {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [3] = {
            name = "weapon_pumpshotgun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [4] = {
            name = "weapon_smg",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [5] = {
            name = "weapon_carbinerifle",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                }
            },
            type = "weapon",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [6] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [7] = {
            name = "pistol_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [8] = {
            name = "smg_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [9] = {
            name = "shotgun_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [10] = {
            name = "rifle_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [11] = {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 11,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [12] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 12,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [13] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 13,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [14] = {
            name = "police_stormram",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 14,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [15] = {
            name = "armor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [16] = {
            name = "radio",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 16,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        },
        [17] = {
            name = "heavyarmor",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 17,
            authorizedJobGrades = {0, 1, 2, 3, 4,5,6}
        }
    }
}

Config.VehicleSettings = {
    ["car1"] = { --- Model name
        ["extras"] = {
            ["1"] = true, -- on/off
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    },
    ["car2"] = {
        ["extras"] = {
            ["1"] = true,
            ["2"] = true,
            ["3"] = true,
            ["4"] = true,
            ["5"] = true,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = true,
            ["12"] = true,
            ["13"] = true,
        },
		["livery"] = 1,
    }
}
