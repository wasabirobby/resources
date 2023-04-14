const resName = GetParentResourceName();

var isCreatingGlobalBlip = false;
var blipIdToDuplicate = null;

var isAdmin = false;

// Not good blips are commented
const spritesIDs = {
    [0]: "radar_higher",
    [1]: "radar_level",
    [2]: "radar_lower",
    [3]: "radar_police_ped",
    [4]: "radar_wanted_radius",
    [5]: "radar_area_blip",
    [6]: "radar_centre",
    [7]: "radar_north",
    [8]: "radar_waypoint",
    [9]: "radar_radius_blip",
    [10]: "radar_radius_outline_blip",
    [11]: "radar_weapon_higher",
    [12]: "radar_weapon_lower",
    [13]: "radar_higher_ai",
    [14]: "radar_lower_ai",
    [15]: "radar_police_heli_spin",
    [16]: "radar_police_plane_move",
    [28]: "radar_mp_friendlies",
    [36]: "radar_cable_car",
    [38]: "radar_raceflag",
    [40]: "radar_safehouse",
    [41]: "radar_police",
    [42]: "radar_police_chase",
    [43]: "radar_police_heli",
    [47]: "radar_snitch",
    [50]: "radar_crim_carsteal",
    [51]: "radar_crim_drugs",
    [52]: "radar_crim_holdups",
    [56]: "radar_cop_patrol",
    [57]: "radar_cop_player",
    [58]: "radar_crim_wanted",
    [59]: "radar_heist",
    [60]: "radar_police_station",
    [61]: "radar_hospital",
    [64]: "radar_helicopter",
    [66]: "radar_random_character",
    [67]: "radar_security_van",
    [68]: "radar_tow_truck",
    [71]: "radar_barber",
    [72]: "radar_car_mod_shop",
    [73]: "radar_clothes_store",
    [75]: "radar_tattoo",
    [76]: "radar_armenian_family",
    [77]: "radar_lester_family",
    [78]: "radar_michael_family",
    [79]: "radar_trevor_family",
    [80]: "radar_jewelry_heist",
    [84]: "radar_rampage",
    [85]: "radar_vinewood_tours",
    [86]: "radar_lamar_family",
    [88]: "radar_franklin_family",
    [89]: "radar_chinese_strand",
    [90]: "radar_flight_school",
    [93]: "radar_bar",
    [94]: "radar_base_jump",
    [96]: "radar_biolab_heist",
    [100]: "radar_car_wash",
    [102]: "radar_comedy_club",
    [103]: "radar_darts",
    [104]: "radar_docks_heist",
    [105]: "radar_fbi_heist",
    [106]: "radar_fbi_officers_strand",
    [107]: "radar_finale_bank_heist",
    [108]: "radar_financier_strand",
    [109]: "radar_golf",
    [110]: "radar_gun_shop",
    [112]: "radar_michael_family_exile",
    [113]: "radar_nice_house_heist",
    [118]: "radar_rural_bank_heist",
    [119]: "radar_shooting_range",
    [120]: "radar_solomon_strand",
    [121]: "radar_strip_club",
    [122]: "radar_tennis",
    [123]: "radar_trevor_family_exile",
    [124]: "radar_michael_trevor_family",
    [126]: "radar_triathlon",
    [127]: "radar_off_road_racing",
    [128]: "radar_gang_cops",
    [129]: "radar_gang_mexicans",
    [130]: "radar_gang_bikers",
    [133]: "radar_snitch_red",
    [134]: "radar_crim_cuff_keys",
    [135]: "radar_cinema",
    [136]: "radar_music_venue",
    [137]: "radar_police_station_blue",
    [140]: "radar_weed_stash",
    [141]: "radar_hunting",
    [143]: "radar_objective_blue",
    [144]: "radar_objective_green",
    [145]: "radar_objective_red",
    [146]: "radar_objective_yellow",
    [147]: "radar_arms_dealing",
    [148]: "radar_mp_friend",
    [149]: "radar_celebrity_theft",
    [150]: "radar_weapon_assault_rifle",
    [151]: "radar_weapon_bat",
    [152]: "radar_weapon_grenade",
    [153]: "radar_weapon_health",
    [154]: "radar_weapon_knife",
    [155]: "radar_weapon_molotov",
    [156]: "radar_weapon_pistol",
    [157]: "radar_weapon_rocket",
    [158]: "radar_weapon_shotgun",
    [159]: "radar_weapon_smg",
    [160]: "radar_weapon_sniper",
    [161]: "radar_mp_noise",
    [162]: "radar_poi",
    [163]: "radar_passive",
    [164]: "radar_usingmenu",
    [171]: "radar_gang_cops_partner",
    [173]: "radar_weapon_minigun",
    [175]: "radar_weapon_armour",
    [176]: "radar_property_takeover",
    [177]: "radar_gang_mexicans_highlight",
    [178]: "radar_gang_bikers_highlight",
    [181]: "radar_property_takeover_bikers",
    [182]: "radar_property_takeover_cops",
    [183]: "radar_property_takeover_vagos",
    [184]: "radar_camera",
    [185]: "radar_centre_red",
    [186]: "radar_handcuff_keys_bikers",
    [187]: "radar_handcuff_keys_vagos",
    [188]: "radar_handcuffs_closed_bikers",
    [189]: "radar_handcuffs_closed_vagos",
    [197]: "radar_yoga",
    [198]: "radar_taxi",
    [205]: "radar_shrink",
    [206]: "radar_epsilon",
    [207]: "radar_financier_strand_grey",
    [208]: "radar_trevor_family_grey",
    [209]: "radar_trevor_family_red",
    [210]: "radar_franklin_family_grey",
    [211]: "radar_franklin_family_blue",
    [214]: "radar_franklin_c",
    [225]: "radar_gang_vehicle",
    [226]: "radar_gang_vehicle_bikers",
    [227]: "radar_gang_vehicle_cops",
    [229]: "radar_guncar",
    [233]: "radar_gang_cops_highlight",
    [237]: "radar_custody_bikers",
    [238]: "radar_custody_vagos",
    [251]: "radar_arms_dealing_air",
    [252]: "radar_playerstate_arrested",
    [253]: "radar_playerstate_custody",
    [255]: "radar_playerstate_keyholder",
    [256]: "radar_playerstate_partner",
    [266]: "radar_fairground",
    [267]: "radar_property",
    [268]: "radar_gang_highlight",
    [269]: "radar_altruist",
    [270]: "radar_ai",
    [271]: "radar_on_mission",
    [272]: "radar_cash_pickup",
    [273]: "radar_chop",
    [274]: "radar_dead",
    [276]: "radar_cash_lost",
    [277]: "radar_cash_vagos",
    [278]: "radar_cash_cops",
    [279]: "radar_hooker",
    [280]: "radar_friend",
    [285]: "radar_custody_dropoff",
    [286]: "radar_onmission_cops",
    [287]: "radar_onmission_lost",
    [288]: "radar_onmission_vagos",
    [289]: "radar_crim_carsteal_cops",
    [290]: "radar_crim_carsteal_bikers",
    [291]: "radar_crim_carsteal_vagos",
    [293]: "radar_simeon_family",
    [303]: "radar_bounty_hit",
    [304]: "radar_ugc_mission",
    [305]: "radar_horde",
    [306]: "radar_cratedrop",
    [307]: "radar_plane_drop",
    [308]: "radar_sub",
    [309]: "radar_race",
    [310]: "radar_deathmatch",
    [311]: "radar_arm_wrestling",
    [313]: "radar_shootingrange_gunshop",
    [314]: "radar_race_air",
    [315]: "radar_race_land",
    [316]: "radar_race_sea",
    [317]: "radar_tow",
    [318]: "radar_garbage",
    [326]: "radar_getaway_car",
    [348]: "radar_gang_bike",
    [350]: "radar_property_for_sale",
    [351]: "radar_gang_attack_package",
    [352]: "radar_martin_madrazzo",
    [353]: "radar_enemy_heli_spin",
    [354]: "radar_boost",
    [355]: "radar_devin",
    [356]: "radar_dock",
    [357]: "radar_garage",
    [358]: "radar_golf_flag",
    [359]: "radar_hangar",
    [360]: "radar_helipad",
    [361]: "radar_jerry_can",
    [362]: "radar_mask",
    [363]: "radar_heist_prep",
    [364]: "radar_incapacitated",
    [365]: "radar_spawn_point_pickup",
    [366]: "radar_boilersuit",
    [367]: "radar_completed",
    [368]: "radar_rockets",
    [369]: "radar_garage_for_sale",
    [370]: "radar_helipad_for_sale",
    [371]: "radar_dock_for_sale",
    [372]: "radar_hangar_for_sale",
    [373]: "radar_placeholder_6",
    [374]: "radar_business",
    [375]: "radar_business_for_sale",
    [376]: "radar_race_bike",
    [377]: "radar_parachute",
    [378]: "radar_team_deathmatch",
    [379]: "radar_race_foot",
    [380]: "radar_vehicle_deathmatch",
    [381]: "radar_barry",
    [382]: "radar_dom",
    [383]: "radar_maryann",
    [384]: "radar_cletus",
    [385]: "radar_josh",
    [386]: "radar_minute",
    [387]: "radar_omega",
    [388]: "radar_tonya",
    [389]: "radar_paparazzo",
    [390]: "radar_aim",
    [391]: "radar_cratedrop_background",
    [392]: "radar_green_and_net_player1",
    [393]: "radar_green_and_net_player2",
    [394]: "radar_green_and_net_player3",
    [395]: "radar_green_and_friendly",
    [396]: "radar_net_player1_and_net_player2",
    [397]: "radar_net_player1_and_net_player3",
    [398]: "radar_creator",
    [399]: "radar_creator_direction",
    [400]: "radar_abigail",
    [401]: "radar_blimp",
    [402]: "radar_repair",
    [403]: "radar_testosterone",
    [404]: "radar_dinghy",
    [405]: "radar_fanatic",
    [407]: "radar_info_icon",
    [408]: "radar_capture_the_flag",
    [409]: "radar_last_team_standing",
    [410]: "radar_boat",
    [411]: "radar_capture_the_flag_base",
    [412]: "radar_mp_crew",
    [413]: "radar_capture_the_flag_outline",
    [414]: "radar_capture_the_flag_base_nobag",
    [415]: "radar_weapon_jerrycan",
    [416]: "radar_rp",
    [417]: "radar_level_inside",
    [418]: "radar_bounty_hit_inside",
    [419]: "radar_capture_the_usaflag",
    [420]: "radar_capture_the_usaflag_outline",
    [421]: "radar_tank",
    [422]: "radar_player_heli",
    [423]: "radar_player_plane",
    [424]: "radar_player_jet",
    [425]: "radar_centre_stroke",
    [426]: "radar_player_guncar",
    [427]: "radar_player_boat",
    [428]: "radar_mp_heist",
    [429]: "radar_temp_1",
    [430]: "radar_temp_2",
    [431]: "radar_temp_3",
    [432]: "radar_temp_4",
    [433]: "radar_temp_5",
    [434]: "radar_temp_6",
    [435]: "radar_race_stunt",
    [436]: "radar_hot_property",
    [437]: "radar_urbanwarfare_versus",
    [438]: "radar_king_of_the_castle",
    [439]: "radar_player_king",
    [440]: "radar_dead_drop",
    [441]: "radar_penned_in",
    [442]: "radar_beast",
    [443]: "radar_edge_pointer",
    [444]: "radar_edge_crosstheline",
    [445]: "radar_mp_lamar",
    [446]: "radar_bennys",
    [447]: "radar_corner_number_1",
    [448]: "radar_corner_number_2",
    [449]: "radar_corner_number_3",
    [450]: "radar_corner_number_4",
    [451]: "radar_corner_number_5",
    [452]: "radar_corner_number_6",
    [453]: "radar_corner_number_7",
    [454]: "radar_corner_number_8",
    [455]: "radar_yacht",
    [456]: "radar_finders_keepers",
    [457]: "radar_assault_package",
    [458]: "radar_hunt_the_boss",
    [459]: "radar_sightseer",
    [460]: "radar_turreted_limo",
    [461]: "radar_belly_of_the_beast",
    [463]: "radar_pickup_beast",
    [464]: "radar_pickup_zoned",
    [465]: "radar_pickup_random",
    [466]: "radar_pickup_slow_time",
    [467]: "radar_pickup_swap",
    [468]: "radar_pickup_thermal",
    [469]: "radar_pickup_weed",
    [470]: "radar_weapon_railgun",
    [471]: "radar_seashark",
    [472]: "radar_pickup_hidden",
    [473]: "radar_warehouse",
    [474]: "radar_warehouse_for_sale",
    [475]: "radar_office",
    [476]: "radar_office_for_sale",
    [477]: "radar_truck",
    [478]: "radar_contraband",
    [479]: "radar_trailer",
    [480]: "radar_vip",
    [481]: "radar_cargobob",
    [482]: "radar_area_outline_blip",
    [483]: "radar_pickup_accelerator",
    [484]: "radar_pickup_ghost",
    [485]: "radar_pickup_detonator",
    [486]: "radar_pickup_bomb",
    [487]: "radar_pickup_armoured",
    [488]: "radar_stunt",
    [489]: "radar_weapon_lives",
    [490]: "radar_stunt_premium",
    [491]: "radar_adversary",
    [492]: "radar_biker_clubhouse",
    [493]: "radar_biker_caged_in",
    [494]: "radar_biker_turf_war",
    [495]: "radar_biker_joust",
    [496]: "radar_production_weed",
    [497]: "radar_production_crack",
    [498]: "radar_production_fake_id",
    [499]: "radar_production_meth",
    [500]: "radar_production_money",
    [501]: "radar_package",
    [502]: "radar_capture_1",
    [503]: "radar_capture_2",
    [504]: "radar_capture_3",
    [505]: "radar_capture_4",
    [506]: "radar_capture_5",
    [507]: "radar_capture_6",
    [508]: "radar_capture_7",
    [509]: "radar_capture_8",
    [510]: "radar_capture_9",
    [511]: "radar_capture_10",
    [512]: "radar_quad",
    [513]: "radar_bus",
    [514]: "radar_drugs_package",
    [515]: "radar_pickup_jump",
    [516]: "radar_adversary_4",
    [517]: "radar_adversary_8",
    [518]: "radar_adversary_10",
    [519]: "radar_adversary_12",
    [520]: "radar_adversary_16",
    [521]: "radar_laptop",
    [522]: "radar_pickup_deadline",
    [523]: "radar_sports_car",
    [524]: "radar_warehouse_vehicle",
    [525]: "radar_reg_papers",
    [526]: "radar_police_station_dropoff",
    [527]: "radar_junkyard",
    [528]: "radar_ex_vech_1",
    [529]: "radar_ex_vech_2",
    [530]: "radar_ex_vech_3",
    [531]: "radar_ex_vech_4",
    [532]: "radar_ex_vech_5",
    [533]: "radar_ex_vech_6",
    [534]: "radar_ex_vech_7",
    [535]: "radar_target_a",
    [536]: "radar_target_b",
    [537]: "radar_target_c",
    [538]: "radar_target_d",
    [539]: "radar_target_e",
    [540]: "radar_target_f",
    [541]: "radar_target_g",
    [542]: "radar_target_h",
    [543]: "radar_jugg",
    [544]: "radar_pickup_repair",
    [545]: "radar_steeringwheel",
    [546]: "radar_trophy",
    [547]: "radar_pickup_rocket_boost",
    [548]: "radar_pickup_homing_rocket",
    [549]: "radar_pickup_machinegun",
    [550]: "radar_pickup_parachute",
    [551]: "radar_pickup_time_5",
    [552]: "radar_pickup_time_10",
    [553]: "radar_pickup_time_15",
    [554]: "radar_pickup_time_20",
    [555]: "radar_pickup_time_30",
    [556]: "radar_supplies",
    [557]: "radar_property_bunker",
    [558]: "radar_gr_wvm_1",
    [559]: "radar_gr_wvm_2",
    [560]: "radar_gr_wvm_3",
    [561]: "radar_gr_wvm_4",
    [562]: "radar_gr_wvm_5",
    [563]: "radar_gr_wvm_6",
    [564]: "radar_gr_covert_ops",
    [565]: "radar_adversary_bunker",
    [566]: "radar_gr_moc_upgrade",
    [567]: "radar_gr_w_upgrade",
    [568]: "radar_sm_cargo",
    [569]: "radar_sm_hangar",
    [570]: "radar_tf_checkpoint",
    [571]: "radar_race_tf",
    [572]: "radar_sm_wp1",
    [573]: "radar_sm_wp2",
    [574]: "radar_sm_wp3",
    [575]: "radar_sm_wp4",
    [576]: "radar_sm_wp5",
    [577]: "radar_sm_wp6",
    [578]: "radar_sm_wp7",
    [579]: "radar_sm_wp8",
    [580]: "radar_sm_wp9",
    [581]: "radar_sm_wp10",
    [582]: "radar_sm_wp11",
    [583]: "radar_sm_wp12",
    [584]: "radar_sm_wp13",
    [585]: "radar_sm_wp14",
    [586]: "radar_nhp_bag",
    [587]: "radar_nhp_chest",
    [588]: "radar_nhp_orbit",
    [589]: "radar_nhp_veh1",
    [590]: "radar_nhp_base",
    [591]: "radar_nhp_overlay",
    [592]: "radar_nhp_turret",
    [593]: "radar_nhp_mg_firewall",
    [594]: "radar_nhp_mg_node",
    [595]: "radar_nhp_wp1",
    [596]: "radar_nhp_wp2",
    [597]: "radar_nhp_wp3",
    [598]: "radar_nhp_wp4",
    [599]: "radar_nhp_wp5",
    [600]: "radar_nhp_wp6",
    [601]: "radar_nhp_wp7",
    [602]: "radar_nhp_wp8",
    [603]: "radar_nhp_wp9",
    [604]: "radar_nhp_cctv",
    [605]: "radar_nhp_starterpack",
    [606]: "radar_nhp_turret_console",
    [607]: "radar_nhp_mg_mir_rotate",
    [608]: "radar_nhp_mg_mir_static",
    [609]: "radar_nhp_mg_proxy",
    [610]: "radar_acsr_race_target",
    [611]: "radar_acsr_race_hotring",
    [612]: "radar_acsr_wp1",
    [613]: "radar_acsr_wp2",
    [614]: "radar_bat_club_property",
    [615]: "radar_bat_cargo",
    [616]: "radar_bat_truck",
    [617]: "radar_bat_hack_jewel",
    [618]: "radar_bat_hack_gold",
    [619]: "radar_bat_keypad",
    [620]: "radar_bat_hack_target",
    [621]: "radar_pickup_dtb_health",
    [622]: "radar_pickup_dtb_blast_increase",
    [623]: "radar_pickup_dtb_blast_decrease",
    [624]: "radar_pickup_dtb_bomb_increase",
    [625]: "radar_pickup_dtb_bomb_decrease",
    [626]: "radar_bat_rival_club",
    [627]: "radar_bat_drone",
    [628]: "radar_bat_cash_reg",
    [629]: "radar_cctv",
    [630]: "radar_bat_assassinate",
    [631]: "radar_bat_pbus",
    [632]: "radar_bat_wp1",
    [633]: "radar_bat_wp2",
    [634]: "radar_bat_wp3",
    [635]: "radar_bat_wp4",
    [636]: "radar_bat_wp5",
    [637]: "radar_bat_wp6",
    [638]: "radar_blimp_2",
    [639]: "radar_oppressor_2",
    [640]: "radar_bat_wp7",
    [641]: "radar_arena_series",
    [642]: "radar_arena_premium",
    [643]: "radar_arena_workshop",
    [644]: "radar_race_wars",
    [645]: "radar_arena_turret",
    [646]: "radar_arena_rc_car",
    [647]: "radar_arena_rc_workshop",
    [648]: "radar_arena_trap_fire",
    [649]: "radar_arena_trap_flip",
    [650]: "radar_arena_trap_sea",
    [651]: "radar_arena_trap_turn",
    [652]: "radar_arena_trap_pit",
    [653]: "radar_arena_trap_mine",
    [654]: "radar_arena_trap_bomb",
    [655]: "radar_arena_trap_wall",
    [656]: "radar_arena_trap_brd",
    [657]: "radar_arena_trap_sbrd",
    [658]: "radar_arena_bruiser",
    [659]: "radar_arena_brutus",
    [660]: "radar_arena_cerberus",
    [661]: "radar_arena_deathbike",
    [662]: "radar_arena_dominator",
    [663]: "radar_arena_impaler",
    [664]: "radar_arena_imperator",
    [665]: "radar_arena_issi",
    [666]: "radar_arena_sasquatch",
    [667]: "radar_arena_scarab",
    [668]: "radar_arena_slamvan",
    [669]: "radar_arena_zr380"
}

const colors = {
    [0]: "rgb(254, 254, 254)",
    [1]: "rgb(224, 50, 50)",
    [2]: "rgb(113, 203, 113)",
    [3]: "rgb(93, 182, 229)",
    [4]: "rgb(254, 254, 254)",
    [5]: "rgb(238, 198, 78)",
    [6]: "rgb(194, 80, 80)",
    [7]: "rgb(156, 110, 175)",
    [8]: "rgb(254, 122, 195)",
    [9]: "rgb(245, 157, 121)",
    [10]: "rgb(177, 143, 131)",
    [11]: "rgb(141, 206, 167)",
    [12]: "rgb(112, 168, 174)",
    [13]: "rgb(211, 209, 231)",
    [14]: "rgb(143, 126, 152)",
    [15]: "rgb(106, 196, 191)",
    [16]: "rgb(213, 195, 152)",
    [17]: "rgb(234, 142, 80)",
    [18]: "rgb(151, 202, 233)",
    [19]: "rgb(178, 98, 135)",
    [20]: "rgb(143, 141, 121)",
    [21]: "rgb(166, 117, 94)",
    [22]: "rgb(175, 168, 168)",
    [23]: "rgb(231, 141, 154)",
    [24]: "rgb(187, 214, 91)",
    [25]: "rgb(12, 123, 86)",
    [26]: "rgb(122, 195, 254)",
    [27]: "rgb(171, 60, 230)",
    [28]: "rgb(205, 168, 12)",
    [29]: "rgb(69, 97, 171)",
    [30]: "rgb(41, 165, 184)",
    [31]: "rgb(184, 155, 123)",
    [32]: "rgb(200, 224, 254)",
    [33]: "rgb(240, 240, 150)",
    [34]: "rgb(237, 140, 161)",
    [35]: "rgb(249, 138, 138)",
    [36]: "rgb(251, 238, 165)",
    [37]: "rgb(254, 254, 254)",
    [38]: "rgb(44, 109, 184)",
    [39]: "rgb(154, 154, 154)",
    [40]: "rgb(76, 76, 76)",
    [41]: "rgb(242, 157, 157)",
    [42]: "rgb(108, 183, 214)",
    [43]: "rgb(175, 237, 174)",
    [44]: "rgb(255, 167, 95)",
    [45]: "rgb(241, 241, 241)",
    [46]: "rgb(236, 240, 41)",
    [47]: "rgb(255, 154, 24)",
    [48]: "rgb(246, 68, 165)",
    [49]: "rgb(224, 58, 58)",
    [50]: "rgb(138, 109, 227)",
    [51]: "rgb(255, 139, 92)",
    [52]: "rgb(65, 108, 65)",
    [53]: "rgb(179, 221, 243)",
    [54]: "rgb(58, 100, 121)",
    [55]: "rgb(160, 160, 160)",
    [56]: "rgb(132, 114, 50)",
    [57]: "rgb(101, 185, 231)",
    [58]: "rgb(75, 65, 117)",
    [59]: "rgb(225, 59, 59)",
    [60]: "rgb(240, 203, 88)",
    [61]: "rgb(205, 63, 152)",
    [62]: "rgb(207, 207, 207)",
    [63]: "rgb(39, 106, 159)",
    [64]: "rgb(216, 123, 27)",
    [65]: "rgb(142, 131, 147)",
    [66]: "rgb(240, 203, 87)",
    [67]: "rgb(101, 185, 231)",
    [68]: "rgb(101, 185, 231)",
    [69]: "rgb(121, 205, 121)",
    [70]: "rgb(239, 202, 87)",
    [71]: "rgb(239, 202, 87)",
    [72]: "rgb(61, 61, 61)",
    [73]: "rgb(239, 202, 87)",
    [74]: "rgb(101, 185, 231)",
    [75]: "rgb(224, 50, 50)",
    [76]: "rgb(120, 35, 35)",
    [77]: "rgb(101, 185, 231)",
    [78]: "rgb(58, 100, 121)",
    [79]: "rgb(224, 50, 50)",
    [80]: "rgb(101, 185, 231)",
    [81]: "rgb(242, 164, 12)",
    [82]: "rgb(164, 204, 170)",
    [83]: "rgb(168, 84, 242)",
    [84]: "rgb(101, 185, 231)",
    [85]: "rgb(61, 61, 61)",
}

function showNotification(message, duration=false) {
    var notification = $("#notification");
    
    if(duration) {
        notification.toast({
            autohide: true,
            delay: duration
        })
    } else {
        notification.toast({
            autohide: false,
        })
    }

    $("#notification-message").text(message)

    notification.toast("show")
}

function fillSprites(){
    var spritesDiv = $("#blip-sprites");
    
    for (const [id, name] of Object.entries(spritesIDs)) {
        var currentSpritesCount = spritesDiv.children().last().children().length

        var sprite = $(`
            <div class="col-1">
                <img src="images/blips/${name}.png" class="blip-sprite img-fluid p-2">
            </div>
        `)

        sprite.val(id)

        if(currentSpritesCount < 12 && currentSpritesCount > 0) {
            var lastRow = spritesDiv.children().last();

            lastRow.append(sprite)
        } else {
            var newRow = $(`<div class="row"></div>`);

            newRow.append(sprite)

            spritesDiv.append(newRow)
        }

        sprite.click(function(){
            var blipSprite = $(this).val();
            var blipId = $("#edit-blip").val()
            
            $("#edit-blip-sprite").attr("src", `images/blips/${spritesIDs[blipSprite]}.png`)

            $("#blip-sprites").hide();

            $.post(`https://${resName}/edit-blip-sprite`, JSON.stringify({blipSprite: blipSprite, blipId: blipId}))        
        })
    }
} fillSprites()

function fillColors(){
    var colorsDiv = $("#blip-colors")

    for (const [id, rgb] of Object.entries(colors)) {
        var currentColorsCount = colorsDiv.children().last().children().length

        var color = $(`<div class="blip-color m-1 col-1"></div>`);
        color.css({"background-color": rgb});
        color.data("color-id", id)

        if(currentColorsCount < 9 && currentColorsCount > 0) {
            var lastRow = colorsDiv.children().last();

            lastRow.append(color);
        } else {
            var newRow = $(`<div class="row"></div>`);

            newRow.append(color)

            colorsDiv.append(newRow) 
        }

        color.click(function(){
            var blipId = $("#edit-blip").val();
            var blipColor = $(this).data("color-id");

            $.post(`https://${resName}/edit-blip-color`, JSON.stringify({blipId: blipId, blipColor: blipColor}))
        })
    }
} fillColors();

function editBlip(blipId, blipData) {
    $("#edit-blip").val(blipId);

    setBlipType(blipData.type)

    $(`#edit-blip-type option[value="${blipData.type}"]`).prop("selected", true)

    $("#edit-blip-name").val(blipData.name)
    $("#edit-blip-scale").val(blipData.scale)
    $("#edit-blip-alpha").val(blipData.alpha)
    $("#edit-blip-sprite").attr("src", `images/blips/${spritesIDs[blipData.sprite]}.png`)
    $("#edit-blip-tick").prop("checked", blipData.ticked)
    $("#edit-blip-outline").prop("checked", blipData.outline)
    
    // If is global hides share btn
    if(!blipData.identifier) {
        $("#edit-blip-share-btn").hide();
        $("#edit-blip").data("is-global", true);
        $("#edit-blip").data("global-id", blipData.id);
    } else {
        $("#edit-blip-share-btn").show();
        $("#edit-blip").data("is-global", false);
    }

    switch(blipData.display){
        case 2: {
            $("#edit-blip-display-both").prop("checked", true)
            $("#edit-blip-display-mainmap").prop("checked", false)
            $("#edit-blip-display-minimap").prop("checked", false)
            break;
        }

        case 3: {
            $("#edit-blip-display-both").prop("checked", false)
            $("#edit-blip-display-mainmap").prop("checked", true)
            $("#edit-blip-display-minimap").prop("checked", false)
            break;
        }

        case 5: {
            $("#edit-blip-display-both").prop("checked", false)
            $("#edit-blip-display-mainmap").prop("checked", false)
            $("#edit-blip-display-minimap").prop("checked", true)
            break;
        }
    }

    $("#map-utilities").hide();
    $("#edit-blip").fadeIn();
    $("#edit-blip").scrollTop(0)
}

function hideBlip(blipId) {
    $.post(`https://${resName}/hide-blip`, JSON.stringify({blipId: blipId}))
}

function showBlip(blipId) {
    $.post(`https://${resName}/show-blip`, JSON.stringify({blipId: blipId}))
}

function addBlip(blipId, blipData, canBeEdited){
    var container = $("#blips-container");
    var lastRow = container.children().last();

    var currentBlipsInRow = lastRow.children().length;

    var blipDiv = $(`
        <div class="blip col border rounded m-2">
            <nav class="col-12 float-end">
                <ul class="pagination float-end">
                    <li class="page-item">
                        <i class="blip-duplicate icon-hoverable bi bi-back float-end fs-3 mx-2"></i>
                    </li>     
                    <li class="page-item">
                        ${blipData.isHidden && '<i class="blip-toggle icon-hoverable bi bi-eye-slash float-end fs-3"></i>' || '<i class="blip-toggle icon-hoverable bi bi-eye float-end fs-3"></i>'}
                    </li>
                </ul>
            </nav>

            <p class="blip-name text-center fs-2 fw-bold mt-1">${blipData.name}</p>
            <p class="blip-street text-center fs-5 fw-light">${blipData.streetName}</p>
        </div>
    `);

    if(blipData.type == "coords") {
        blipDiv.append(`
            <img src="images/blips/${spritesIDs[blipData.sprite]}.png" class="blip-sprite rounded mx-auto d-block mb-3" alt="...">
        `)
    } else if(blipData.type == "area") {
        blipDiv.append(`<p class="text-center fs-4">Area</p>`)
    }else if(blipData.type == "radius") {
        blipDiv.append(`<p class="text-center fs-4">Radius</p>`)
    }

    if(!blipData.identifier) {
        blipDiv.addClass("border-warning");
    }

    if(currentBlipsInRow < 4 && currentBlipsInRow > 0) {
        lastRow.append(blipDiv);
    } else {
        var newRow = $(`<div class="row"></div>`);

        newRow.append(blipDiv);
        newRow.append(blipDiv);

        container.append(newRow);
    }

    if(canBeEdited) {
        blipDiv.click(function(){
            editBlip(blipId, blipData);
        })
    }

    blipDiv.find('.blip-toggle').click(function(e) {
        e.preventDefault();
        e.stopPropagation();

        let eyeDiv = $(this)

        if(eyeDiv.hasClass("bi-eye")) {
            eyeDiv.removeClass("bi-eye");
            eyeDiv.addClass("bi-eye-slash");

            hideBlip(blipId)
        } else {
            eyeDiv.removeClass("bi-eye-slash");
            eyeDiv.addClass("bi-eye");

            showBlip(blipId)
        }
    });

    blipDiv.find(".blip-duplicate").click(function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        blipIdToDuplicate = blipId;
        
        $("#map-utilities").hide();
        $("#create-blip-mode").modal("show");
    });
}

function addBlips(blips, isAdmin) {
    $("#blips-container").empty();

    if(Object.keys(blips).length > 0) {
        let globalBlips = {} // Separated so it can be added after local blips (sorting)

        for (const [blipId, blipData] of Object.entries(blips)) {
            if(blipData){
                if(blipData.identifier) {
                    addBlip(blipId, blipData, true)
                } else {
                    globalBlips[blipId] = blipData
                }
            }
        }

        for (const [blipId, blipData] of Object.entries(globalBlips)) {
            if(blipData){
                addBlip(blipId, blipData, isAdmin)
            }
        }
    } else {
        $("#blips-container").append(`<p class="mt-4 fs-1 text-center">No blips created</p>`);
    }
}

$("#edit-blip-sprite").click(function(){
    $("#blip-sprites").fadeIn();
})

$("#edit-blip-close-btn").click(function(){
    var editBlipDiv = $("#edit-blip");
    var blipId = parseInt(editBlipDiv.val());

    $.post(`https://${resName}/save-blip`, JSON.stringify({blipId: blipId}), function(isSuccessful){
        $("#edit-blip").hide();
        openBlipsMenu()
    })
})

$("#map-utilities-close-btn").click(function(){
    $("#map-utilities").fadeOut();
    $.post(`https://${resName}/close`)
})

$("#create-blip-btn").click(function(){
    $("#map-utilities").hide();

    $("#create-blip-mode").modal("show");
})

$("#edit-blip-name").change(function(){
    var blipId = $("#edit-blip").val()
    var blipName = $(this).val();
    
    $.post(`https://${resName}/edit-blip-name`, JSON.stringify({blipId: blipId, blipName: blipName}))
})

$("#edit-blip-scale").change(function(){
    var blipId = $("#edit-blip").val()
    var blipScale = $(this).val();

    $.post(`https://${resName}/edit-blip-scale`, JSON.stringify({blipId: blipId, blipScale: blipScale}))
})

$("#edit-blip-alpha").change(function(){
    var blipId = $("#edit-blip").val()
    var blipAlpha = $(this).val();

    $.post(`https://${resName}/edit-blip-alpha`, JSON.stringify({blipId: blipId, blipAlpha: blipAlpha}))
})

$("#edit-blip-tick").change(function(){
    var blipId = $("#edit-blip").val()
    var blipTick = $(this).prop("checked");

    $.post(`https://${resName}/edit-blip-tick`, JSON.stringify({blipId: blipId, blipTick: blipTick}))
})

$("#edit-blip-outline").change(function(){
    var blipId = $("#edit-blip").val()
    var blipOutline = $(this).prop("checked");

    $.post(`https://${resName}/edit-blip-outline`, JSON.stringify({blipId: blipId, blipOutline: blipOutline}))
})

$("#edit-blip-delete-btn").click(function(){
    $("#delete-blip-modal").modal("show");
})

$("#delete-blip-btn").click(function(){
    var editBlipDiv = $("#edit-blip");
    var blipId = $("#edit-blip").val()

    if(editBlipDiv.data("is-global")) {
        var globalId = parseInt(editBlipDiv.data("global-id"));

        $.post(`https://${resName}/delete-global-blip`, JSON.stringify({globalId: globalId, blipId: blipId}))
    } else {
        $.post(`https://${resName}/delete-blip`, JSON.stringify({blipId: blipId}))
    }

    $("#delete-blip-modal").modal("hide");
    
    $("#edit-blip").hide();
    
    openBlipsMenu()
})

$('input[type=range]').on('input', function () {
    $(this).trigger('change');
});

$('input[type=radio][name=edit-blip-display]').change(function() {
    var blipId = $("#edit-blip").val()
    var display = $(this).data("display");

    $.post(`https://${resName}/edit-blip-display`, JSON.stringify({blipId: blipId, blipDisplay: display}))
});

$("#create-blip-from-coords-btn").click(function(){
    $("#x-coord").val("");
    $("#y-coord").val("");
    
    $("#x-coord").removeClass("is-invalid");
    $("#y-coord").removeClass("is-invalid");

    $("#create-blip-mode").modal("hide")
    $("#create-from-coords-modal").modal("show")
})

$("#confirm-from-coords").click(function(){
    var isEverythingFilled = true;

    var xInput = $("#x-coord")
    var yInput = $("#y-coord")

    var xCoord = xInput.val();
    var yCoord = yInput.val();

    if(!xCoord || xCoord != parseFloat(xCoord)) {
        xInput.addClass("is-invalid");
        isEverythingFilled = false
    } else {
        xInput.removeClass("is-invalid")
    }

    if(!yCoord || yCoord != parseFloat(yCoord)) {
        yInput.addClass("is-invalid");
        isEverythingFilled = false
    } else {
        yInput.removeClass("is-invalid")
    }

    if(isEverythingFilled) {
        $("#create-from-coords-modal").modal("hide")

        if(blipIdToDuplicate) {
            $.post(`https://${resName}/duplicate-blip-from-coords`, JSON.stringify({blipIdToDuplicate: blipIdToDuplicate, x: xCoord, y: yCoord}), function(data){
                blipIdToDuplicate = null;

                $.post(`https://${resName}/focus`)
                
                openBlipsMenu()
            });
        } else {
            $.post(`https://${resName}/create-blip-from-coords`, JSON.stringify({isGlobal: isCreatingGlobalBlip, x: xCoord, y: yCoord}), function(data){
                $.post(`https://${resName}/focus`)
                
                openBlipsMenu()
            });
        }
    }
})

$("#create-blip-place-blip-btn").click(function(){
    $("#create-blip-mode").modal("hide")

    showNotification("Where your blip should be?")
    
    if(blipIdToDuplicate) {
        $.post(`https://${resName}/duplicate-blip`, JSON.stringify({blipIdToDuplicate: blipIdToDuplicate}), function(data){
            hideNotification()
            
            blipIdToDuplicate = null;

            $.post(`https://${resName}/focus`)
            
            openBlipsMenu()
        });
    } else {
        $.post(`https://${resName}/create-blip`, JSON.stringify({isGlobal: isCreatingGlobalBlip}), function(data){
            hideNotification()
            $.post(`https://${resName}/focus`)
    
            openBlipsMenu()
        })
    }
})

$("#from-coords-close-btn").click(function(){
    $("#create-blip-mode").modal("show");
})

$("#blip-mode-close-btn").click(function(){
    openBlipsMenu()
})

$("#edit-blip-share-btn").click(function(){
    var editBlipDiv = $("#edit-blip");
    var blipId = parseInt(editBlipDiv.val());

    $.post(`https://${resName}/save-blip`, JSON.stringify({blipId: blipId}), function(isSuccessful){
        if(isSuccessful){
            var playerIdInput = $("#player-id")
            
            playerIdInput.val("");
            playerIdInput.removeClass("is-invalid");

            $("#share-choose-id").modal("show");
        }
    })
})

$("#share-btn").click(function(){
    var playerIdInput = $("#player-id")

    var playerId = playerIdInput.val();

    if(!playerId || playerId != parseInt(playerId)) {
        playerIdInput.addClass("is-invalid");
    } else {
        var blipId = $("#edit-blip").val()

        $.post(`https://${resName}/share-blip`, JSON.stringify({playerId: parseInt(playerId), blipId: blipId}));

        $("#share-choose-id").modal("hide");
    }
});

$("#refresh-blips-btn").click(function(){
    $("#map-utilities").hide();
    openBlipsMenu()
})

function mapActive(){
    showNotification("Press SPACEBAR to open the menu", 3000)
}

function hideNotification(){
    $("#notification").toast("hide");
}

function openBlipsMenu(){
    if(isCreatingGlobalBlip) {
        isCreatingGlobalBlip = false
    }

    $.post(`https://${resName}/get-saved-blips`, {}, function(blips){
        blips = JSON.parse(blips)

        addBlips(blips, isAdmin)

        $("#map-utilities").fadeIn();
    })
}

function activateAdmin(){
    isAdmin = true

    $("#create-global-blip-btn").show();

    $("#create-global-blip-btn").click(function(){
        isCreatingGlobalBlip = true;
        
        $("#map-utilities").hide();
        $("#create-blip-mode").modal("show");
    });
}

window.addEventListener('message', (event) => {
	let data = event.data
    let action = data.action;

	if(action == 'mapActive') {
		mapActive();
	} else if(action == 'mapClosed') {
        hideNotification();
    } else if(action == 'openBlipsMenu') {
        openBlipsMenu();
    } else if(action == "activateAdmin") {
        activateAdmin();
    }
})

function setBlipType(type) {
    switch(type) {
        case 'coords': {
            $("#edit-blip-scale-container").show();
            $("#edit-blip-tick-container").show();
            $("#edit-blip-outline-container").show();
            $("#edit-blip-sprite-container").show();
            $("#edit-blip-height-width-container").hide();

            let blipScaleDiv = $("#edit-blip-scale");

            blipScaleDiv.attr("min", 0.5);
            blipScaleDiv.attr("max", 2.0);
            blipScaleDiv.attr("step", 0.01);
            break;
        }

        case 'area': {
            $("#edit-blip-scale-container").hide();
            $("#edit-blip-tick-container").hide();
            $("#edit-blip-outline-container").hide();
            $("#edit-blip-sprite-container").hide();
            $("#edit-blip-height-width-container").show();

            break;
        }

        case 'radius': {
            $("#edit-blip-scale-container").show();
            $("#edit-blip-tick-container").hide();
            $("#edit-blip-outline-container").hide();
            $("#edit-blip-sprite-container").hide();
            $("#edit-blip-height-width-container").hide();

            let blipScaleDiv = $("#edit-blip-scale");

            blipScaleDiv.attr("min", 1.0);
            blipScaleDiv.attr("max", 10000.0);
            blipScaleDiv.attr("step", 1.0);
            break;
        }
    }
}

$("#edit-blip-type").change(function() {
    let blipType = $(this).val()
    let blipId = $("#edit-blip").val()

    setBlipType(blipType)

    $.post(`https://${resName}/edit-blip-type`, JSON.stringify({blipId: blipId, blipType: blipType}))
})

$("#edit-blip-width").change(function() {
    let blipWidth = $(this).val()
    let blipId = $("#edit-blip").val()

    $.post(`https://${resName}/edit-blip-width`, JSON.stringify({blipId: blipId, blipWidth: blipWidth}))
})

$("#edit-blip-height").change(function() {
    let blipHeight = $(this).val()
    let blipId = $("#edit-blip").val()
    
    $.post(`https://${resName}/edit-blip-height`, JSON.stringify({blipId: blipId, blipHeight: blipHeight}))
})