Config = Config or {}

-- set this to false if you want to use distance checks
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'
-- Config.UseTarget = GetConvar('UseTarget', 'false')

Config.DefaultTextLocation = "left" -- left, right, top

Config.AllowedVehicles = {
    [1] = {model = "taxi", label = Lang:t("info.taxi_label_1")},
}

Config.Meter = {
    ["defaultPrice"] = 125.0, -- price per mile
    ["startingPrice"] = 0  -- static starting price
}

Config.BossMenu = vector3(1782.56, -1866.66, 13.58)

Config.Location = vector4(1781.55, -1860.68, 13.58, 6.83)

Config.NPCLocations = {
    TakeLocations = {
        [1] = vector4(1826.75, -1827.87, 13.57, 352.32),
        [2] = vector4(1731.85, -1810.06, 13.55, 56.49),
        [3] = vector4(1707.15, -1817.87, 13.55, 103.04),
        
    },
    DeliverLocations = {
        [1] = vector4(-1074.39, -266.64, 37.75, 117.5),
        [2] = vector4(-1412.07, -591.75, 30.38, 298.5),
        [3] = vector4(-679.9, -845.01, 23.98, 269.5),
        [4] = vector4(-158.05, -1565.3, 35.06, 139.5),
    }
}

Config.PZLocations = {

    TakeLocations = {
        [1] = {
            coord = vector3(258.98, -377.9, 44.7),
            height = 17.6,
            width = 4.2,
            heading=69,
            --debugPoly=true,
            minZ=43.75,
            maxZ=45.55
        },
        [2] = {
            coord = vector3(-50.06, -784.57, 44.16),
            height = 17.6,
            width = 4.2,
            heading=62,
            --debugPoly=true,
            minZ=43.21,
            maxZ=45.01
        },
        [3] = {
            coord = vector3(238.93, -858.91, 29.67),
            height = 17.6,
            width = 4.2,
            heading=71,
            --debugPoly=true,
            minZ=28.72,
            maxZ=30.52
        },
        [4] = {
            coord = vector3(823.4, -1882.96, 29.29),
            height = 17.6,
            width = 4.2,
            heading=167,
            --debugPoly=true,
            minZ=28.34,
            maxZ=30.14
        },
    },

    DropLocations = {
        [1] = {
            coord = vector3(-1073.21, -265.35, 37.35),
            height = 21.2,
            width = 4.2,
            heading=296,
            --debugPoly=true,
            minZ=35.0,
            maxZ=39.2
        },
        [2] = {
            coord = vector3(-1411.45, -590.98, 29.99),
            height = 21.2,
            width = 4.2,
            heading=299,
            --debugPoly=true,
            minZ=27.64,
            maxZ=31.84
        },
        [3] = {
            coord = vector3(-678.68, -845.54, 23.53),
            height = 21.2,
            width = 4.2,
            heading=269,
            --debugPoly=true,
            minZ=21.18,
            maxZ=25.38
        },
        [4] = {
            coord = vector3(-159.11, -1565.46, 34.69),
            height = 21.2,
            width = 4.2,
            heading=321,
            --debugPoly=true,
            minZ=32.34,
            maxZ=36.54
        },
    }
}

Config.NpcSkins = {
    [1] = {
        'a_f_m_skidrow_01',
        'a_f_m_soucentmc_01',
        'a_f_m_soucent_01',
        'a_f_m_soucent_02',
        'a_f_m_tourist_01',
        'a_f_m_trampbeac_01',
        'a_f_m_tramp_01',
        'a_f_o_genstreet_01',
        'a_f_o_indian_01',
        'a_f_o_ktown_01',
        'a_f_o_salton_01',
        'a_f_o_soucent_01',
        'a_f_o_soucent_02',
        'a_f_y_beach_01',
        'a_f_y_bevhills_01',
        'a_f_y_bevhills_02',
        'a_f_y_bevhills_03',
        'a_f_y_bevhills_04',
        'a_f_y_business_01',
        'a_f_y_business_02',
        'a_f_y_business_03',
        'a_f_y_business_04',
        'a_f_y_eastsa_01',
        'a_f_y_eastsa_02',
        'a_f_y_eastsa_03',
        'a_f_y_epsilon_01',
        'a_f_y_fitness_01',
        'a_f_y_fitness_02',
        'a_f_y_genhot_01',
        'a_f_y_golfer_01',
        'a_f_y_hiker_01',
        'a_f_y_hipster_01',
        'a_f_y_hipster_02',
        'a_f_y_hipster_03',
        'a_f_y_hipster_04',
        'a_f_y_indian_01',
        'a_f_y_juggalo_01',
        'a_f_y_runner_01',
        'a_f_y_rurmeth_01',
        'a_f_y_scdressy_01',
        'a_f_y_skater_01',
        'a_f_y_soucent_01',
        'a_f_y_soucent_02',
        'a_f_y_soucent_03',
        'a_f_y_tennis_01',
        'a_f_y_tourist_01',
        'a_f_y_tourist_02',
        'a_f_y_vinewood_01',
        'a_f_y_vinewood_02',
        'a_f_y_vinewood_03',
        'a_f_y_vinewood_04',
        'a_f_y_yoga_01',
        'g_f_y_ballas_01',
    },
    [2] = {
        'ig_barry',
        'ig_bestmen',
        'ig_beverly',
        'ig_car3guy1',
        'ig_car3guy2',
        'ig_casey',
        'ig_chef',
        'ig_chengsr',
        'ig_chrisformage',
        'ig_clay',
        'ig_claypain',
        'ig_cletus',
        'ig_dale',
        'ig_dreyfuss',
        'ig_fbisuit_01',
        'ig_floyd',
        'ig_groom',
        'ig_hao',
        'ig_hunter',
        'csb_prolsec',
        'ig_joeminuteman',
        'ig_josef',
        'ig_josh',
        'ig_lamardavis',
        'ig_lazlow',
        'ig_lestercrest',
        'ig_lifeinvad_01',
        'ig_lifeinvad_02',
        'ig_manuel',
        'ig_milton',
        'ig_mrk',
        'ig_nervousron',
        'ig_nigel',
        'ig_old_man1a',
        'ig_old_man2',
        'ig_oneil',
        'ig_orleans',
        'ig_ortega',
        'ig_paper',
        'ig_priest',
        'ig_prolsec_02',
        'ig_ramp_gang',
        'ig_ramp_hic',
        'ig_ramp_hipster',
        'ig_ramp_mex',
        'ig_roccopelosi',
        'ig_russiandrunk',
        'ig_siemonyetarian',
        'ig_solomon',
        'ig_stevehains',
        'ig_stretch',
        'ig_talina',
        'ig_taocheng',
        'ig_taostranslator',
        'ig_tenniscoach',
        'ig_terry',
        'ig_tomepsilon',
        'ig_tylerdix',
        'ig_wade',
        'ig_zimbor',
        's_m_m_paramedic_01',
        'a_m_m_afriamer_01',
        'a_m_m_beach_01',
        'a_m_m_beach_02',
        'a_m_m_bevhills_01',
        'a_m_m_bevhills_02',
        'a_m_m_business_01',
        'a_m_m_eastsa_01',
        'a_m_m_eastsa_02',
        'a_m_m_farmer_01',
        'a_m_m_fatlatin_01',
        'a_m_m_genfat_01',
        'a_m_m_genfat_02',
        'a_m_m_golfer_01',
        'a_m_m_hasjew_01',
        'a_m_m_hillbilly_01',
        'a_m_m_hillbilly_02',
        'a_m_m_indian_01',
        'a_m_m_ktown_01',
        'a_m_m_malibu_01',
        'a_m_m_mexcntry_01',
        'a_m_m_mexlabor_01',
        'a_m_m_og_boss_01',
        'a_m_m_paparazzi_01',
        'a_m_m_polynesian_01',
        'a_m_m_prolhost_01',
        'a_m_m_rurmeth_01',
    }
}

Config.CabSpawns = {
    vector4(1785.77, -1851.93, 13.41, 100.08),
    vector4(1775.21, -1852.35, 13.41, 92.22),
    vector4(1767.01, -1852.07, 13.41, 87.06),
    vector4(1757.3, -1851.44, 13.41, 88.33),
    vector4(1760.6, -1859.43, 13.41, 275.0),
    vector4(1772.32, -1859.48, 13.41, 269.78),
    vector4(1781.0, -1859.24, 13.41, 265.81),
}
