-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(1715.05, -1776.09, 28.83),-- LS Vespucci Unity Station
    },
    ['ambulance'] = {
        vector3(2011.45, -1372.21, 17.25)}, -- County general
    ['realestate'] = {
        vector3(727.68, -1256.33, 14.91),--ecole LS vinewood
    },
    ['taxi'] = {
        vector3(1731.6, -1894.03, 13.58),--unity station
    },
    ['cardealer'] = {
        vector3(929.32, -1509.36, 13.57),-- marina premium deluxe
    },
    ['mechanic'] = {
        vector3(2036.92, -1826.11, 13.56),-- idlewood paintspray
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(1716.38, -1782.8, 28.83), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {-- County general
        { coords = vector3(2011.45, -1372.21, 17.25), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(727.68, -1256.33, 14.91), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(1731.6, -1894.03, 13.58), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(2036.92, -1826.11, 13.56), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0, 0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
