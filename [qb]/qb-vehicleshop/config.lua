Config = {}
Config.UsingTarget = GetConvar('UseTarget', 'false') == 'true'
Config.Commission = 0.10 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-1658.91, 1210.18, 7.26)-- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.PreventFinanceSelling = false -- allow/prevent players from using /transfervehicle if financed
Config.Shops = {
    ['pdm'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
            vector2(-1631.2952880859, 1198.8344726562),
            vector2(-1722.0686035156, 1195.7862548828),
            vector2(-1708.5783691406, 1260.4697265625),
            vector2(-1697.1658935547, 1267.5938720703),
            vector2(-1657.7310791016, 1229.125),
            vector2(-1630.4431152344, 1203.7769775391)
            },
            ['minZ'] =  5, -- min height of the shop zone
            ['maxZ'] =  27, -- max height of the shop zone
            ['size'] = 5, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Ottos Autos', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 523, -- Blip sprite
        ['blipColor'] = 1, -- Blip color
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-1639.12, 1201.91, 7.22), -- Blip Location
        ['ReturnLocation'] = vector3(-1629.57, 1200.72, 7.19), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-1597.57, 1219.5, 7.19, 18.58), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(1441.99, -2600.15, 12.76, 269.46), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1662.31, 1214.42, 7.26, 279.96), -- where the vehicle will spawn on display
                defaultVehicle = 'tezeract', -- Default display vehicle
                chosenVehicle = 'tezeract', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-1656.33, 1212.25, 13.68, 265.52),
                defaultVehicle = 'schafter2',
                chosenVehicle = 'schafter2',
            },
            [3] = {
                coords = vector4(-1664.21, 1221.67, 13.68, 219.51),
                defaultVehicle = 'comet2',
                chosenVehicle = 'comet2',
            },
            [4] = {
                coords = vector4(-1677.51, 1208.58, 13.68, 221.48),
                defaultVehicle = 'vigero',
                chosenVehicle = 'vigero',
            },
            [5] = {
                coords = vector4(-1655.95, 1206.53, 21.16, 349.22),
                defaultVehicle = 't20',
                chosenVehicle = 't20',
            },
            [6] = {
                coords = vector4(-1648.13, 1205.81, 21.16, 260.51),
                defaultVehicle = 'italirsx',
                chosenVehicle = 'italirsx',
            },
            [7] = {
                coords = vector4(-1662.91, 1219.64, 21.16, 228.5),
                defaultVehicle = 'infernus',
                chosenVehicle = 'infernus',
            },
            [8] = {
                coords = vector4(-1679.01, 1208.96, 20.67, 271.72),
                defaultVehicle = 'italigtb',
                chosenVehicle = 'italigtb',
            },
        },
    },
    ['luxury'] = {
        ['Type'] = 'managed', -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
            vector2(958.52380371094, -1497.4583740234),
            vector2(923.41394042969, -1499.0393066406),
            vector2(925.03466796875, -1563.7824707031),
            vector2(958.26062011719, -1566.8427734375)
            },
            ['minZ'] = 10, -- min height of the shop zone
            ['maxZ'] = 19, -- max height of the shop zone
            ['size'] = 5, -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['ShopLabel'] = 'Marina Luxury Vehicle Shop',
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 523, -- Blip sprite
        ['blipColor'] = 83, -- Blip color
        ['TestDriveTimeLimit'] = 0.5,
        ['Location'] = vector3(935.24, -1529.31, 13.57),
        ['ReturnLocation'] = vector3(932.28, -1528.89, 13.57), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(902.72, -1529.98, 13.55, 270.99), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(1441.99, -2600.15, 12.76, 269.46), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(930.63, -1538.93, 13.57, 271.55),
                defaultVehicle = 'italirsx',
                chosenVehicle = 'italirsx',
            },
            [2] = {
                coords = vector4(931.01, -1547.49, 13.57, 359.02),
                defaultVehicle = 'italigtb',
                chosenVehicle = 'italigtb',
            },
            [3] = {
                coords = vector4(935.61, -1539.35, 13.57, 138.45),
                defaultVehicle = 'nero',
                chosenVehicle = 'nero',
            },
            [4] = {
                coords = vector4(941.75, -1517.47, 13.77, 5.97),
                defaultVehicle = 'bati',
                chosenVehicle = 'bati',
            },
            [5] = {
                coords = vector4(941.75, -1515.47, 13.77, 5.97),
                defaultVehicle = 'carbonrs',
                chosenVehicle = 'carbonrs',
            },
            [6] = {
                coords = vector4(941.75, -1519.47, 13.77, 5.97),
                defaultVehicle = 'hexer',
                chosenVehicle = 'hexer',
            },
        },
    }, -- Add your next table under this comma
    ['boats'] = {
        ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = {--polygon that surrounds the shop
                vector2(-729.39, -1315.84),
                vector2(-766.81, -1360.11),
                vector2(-754.21, -1371.49),
                vector2(-716.94, -1326.88)
            },
            ['minZ'] = 0.0, -- min height of the shop zone
            ['maxZ'] = 5.0, -- max height of the shop zone
            ['size'] = 6.2, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Marina Shop', -- Blip name
        ['showBlip'] = true, -- true or false
        ['blipSprite'] = 410, -- Blip sprite
        ['blipColor'] = 3, -- Blip color
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
        ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-722.23, -1351.98, 0.14, 135.33), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
                defaultVehicle = 'seashark', -- Default display vehicle
                chosenVehicle = 'seashark', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-732.84, -1333.5, -0.50, 229.5),
                defaultVehicle = 'dinghy',
                chosenVehicle = 'dinghy',
            },
            [3] = {
                coords = vector4(-737.84, -1340.83, -0.50, 229.5),
                defaultVehicle = 'speeder',
                chosenVehicle = 'speeder',
            },
            [4] = {
                coords = vector4(-741.53, -1349.7, -2.00, 229.5),
                defaultVehicle = 'marquis',
                chosenVehicle = 'marquis',
            },
        },
    },
    --['air'] = {
     --   ['Type'] = 'free-use', -- no player interaction is required to purchase a vehicle
      --  ['Zone'] = {
       --     ['Shape'] = {--polygon that surrounds the shop
        --        vector2(-1607.58, -3141.7),
        --        vector2(-1672.54, -3103.87),
        --        vector2(-1703.49, -3158.02),
        --        vector2(-1646.03, -3190.84)
        --    },
       --     ['minZ'] = 12.99, -- min height of the shop zone
       --     ['maxZ'] = 16.99, -- max height of the shop zone
        --    ['size'] = 7.0, -- size of the vehicles zones
       -- },
       -- ['Job'] = 'none', -- Name of job or none
       -- ['ShopLabel'] = 'Air Shop', -- Blip name
       -- ['showBlip'] = true, -- true or false
       -- ['blipSprite'] = 251, -- Blip sprite
        --['blipColor'] = 3, -- Blip color
       -- ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        --['Location'] = vector3(-1652.76, -3143.4, 13.99), -- Blip Location
       -- ['ReturnLocation'] = vector3(-1628.44, -3104.7, 13.94), -- Location to return vehicle, only enables if the vehicleshop has a job owned
       -- ['VehicleSpawn'] = vector4(-1617.49, -3086.17, 13.94, 329.2), -- Spawn location when vehicle is bought
       -- ['TestDriveSpawn'] = vector4(-1625.19, -3103.47, 13.94, 330.28), -- Spawn location for test drive
       -- ['ShowroomVehicles'] = {
           -- [1] = {
           --     coords = vector4(-1651.36, -3162.66, 12.99, 346.89), -- where the vehicle will spawn on display
          --      defaultVehicle = 'volatus', -- Default display vehicle
         --       chosenVehicle = 'volatus' -- Same as default but is dynamically changed when swapping vehicles
         --   },
          --  [2] = {
         --       coords = vector4(-1668.53, -3152.56, 12.99, 303.22),
          --      defaultVehicle = 'luxor2',
         --       chosenVehicle = 'luxor2'
         --   },
         --   [3] = {
           --     coords = vector4(-1632.02, -3144.48, 12.99, 31.08),
           --     defaultVehicle = 'nimbus',
            --    chosenVehicle = 'nimbus'
           -- },
           -- [4] = {
           --     coords = vector4(-1663.74, -3126.32, 12.99, 275.03),
           --     defaultVehicle = 'frogger',
           --     chosenVehicle = 'frogger'
          --  },
       -- },
 --   },
 --   ['truck'] = {
  --      ['Type'] = 'free-use', -- no player interaction is required to purchase a car
   --     ['Zone'] = {
  --          ['Shape'] = {--polygon that surrounds the shop
   --             vector2(872.23, -1173.5),
   --             vector2(868.88, -1162.7),
   --             vector2(900.91, -1156.54),
   --             vector2(901.96, -1173.71),
   --             vector2(883.59, -1174.47),
   --             vector2(884.59, -1161.29),
    --            vector2(890.06, -1155.0),
   --             vector2(907.71, -1168.71)
  --          },
   --         ['minZ'] = 23.0, -- min height of the shop zone
    --        ['maxZ'] = 28.0, -- max height of the shop zone
   --         ['size'] = 5.75 -- size of the vehicles zones
    --    },
    --    ['Job'] = 'none', -- Name of job or none
    ----    ['ShopLabel'] = 'Truck Motor Shop', -- Blip name
    --    ['showBlip'] = true, -- true or false
    --    ['blipSprite'] = 477, -- Blip sprite
     --   ['blipColor'] = 2, -- Blip color
    --    ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
     --   ['Location'] = vector3(900.47, -1155.74, 25.16), -- Blip Location
     --   ['ReturnLocation'] = vector3(900.47, -1155.74, 25.16), -- Location to return vehicle, only enables if the vehicleshop has a job owned
   --     ['VehicleSpawn'] = vector4(909.35, -1181.58, 25.55, 177.57), -- Spawn location when vehicle is bought
    --    ['TestDriveSpawn'] = vector4(867.65, -1192.4, 25.37, 95.72), -- Spawn location for test drive
     --   ['ShowroomVehicles'] = {
      --      [1] = {
       --         coords = vector4(890.84, -1170.92, 25.08, 269.58), -- where the vehicle will spawn on display
      --          defaultVehicle = 'hauler', -- Default display vehicle
       --         chosenVehicle = 'hauler', -- Same as default but is dynamically changed when swapping vehicles
     --       },
        --    [2] = {
        --        coords = vector4(878.45, -1171.04, 25.05, 273.08),
       --         defaultVehicle = 'phantom',
       --         chosenVehicle = 'phantom'
       --     },
       --     [3] = {
       --         coords = vector4(880.44, -1163.59, 24.87, 273.08),
        --        defaultVehicle = 'mule',
       --         chosenVehicle = 'mule'
       --     },
       --     [4] = {
      --          coords = vector4(896.95, -1162.62, 24.98, 273.08),
     --           defaultVehicle = 'mixer',
     --           chosenVehicle = 'mixer'
     --       },
    --    },
   -- },
}
