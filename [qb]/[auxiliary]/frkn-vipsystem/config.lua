Config = {}

Config.Period = 15 -- write in minutes [Example 15 is 15 minutes.]

Config.EnableAnimAndTheme = true
Config.TebexStoreName = "XXT"
Config.TebexStoreUrl = "#"
Config.Anim = 3 -- 1-2-3

Config.Anims = {
    {prizeTime = 3800, embed = '<script src="https://fast.wistia.com/embed/medias/43rwdegi8v.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div id="myVideo" class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_43rwdegi8v videoFoam=true" style="height:100%;position:relative;width:100%">&nbsp;</div></div></div>'},
    {prizeTime = 1800, embed = '<script src="https://fast.wistia.com/embed/medias/erv2cuh9wz.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div id="myVideo" class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_erv2cuh9wz videoFoam=true" style="height:100%;position:relative;width:100%">&nbsp;</div></div></div>'},
    {prizeTime = 4800, embed = '<script src="https://fast.wistia.com/embed/medias/qiowze4ged.jsonp" async></script><script src="https://fast.wistia.com/assets/external/E-v1.js" async></script><div id="myVideo" class="wistia_responsive_padding" style="padding:56.25% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_qiowze4ged videoFoam=true" style="height:100%;position:relative;width:100%">&nbsp;</div></div></div>'},
}

-- Example Local Video Embed
-- <video autoplay id="myVideo">
-- <source src="vids/1.mp4" type="video/mp4">
-- </video>
-- Prize Types
-- Vehicle Types = car - boat - helicopter > gives vehicles to owned vehicles
-- item > gives player to items
-- coin > gives player to coins
Config.GivePeriodCoin = 50
Config.Time = Config.Period * 60000

Config.Cases = {
        
        {
            no = 1,
            name = "Low quality case",
            guaranteed_prize = {type = "item", item = "water"},
            image = "cases/1.png",
            style = "max-width: 72%;margin-left: 20%;margin-top: 10%;margin-bottom: 10%;",
            credit = 30,
            items = {
                {type = "item", item = "weapon_pistol", label = "Pistol", count = 1, rarity = 1},
                {type = "item", item = "water", label = "Water", count = 1, rarity = 2},
                {type = "item", item = "bread", label = "Bread", count = 1, rarity = 3},
                {type = "item", item = "phone", label = "Phone", count = 1, rarity = 4},
                {type = "item", item = "weapon_knife", label = "Knife", count = 1, rarity = 5},
                {type = "item", item = "weapon_bat", label = "Bat", count = 1, rarity = 1},
                {type = "item", item = "pistol_ammo", label = "Ammo", count = 1, rarity = 1},
                {type = "item", item = "weapon_snspistol", label = "Sns Pistol", count = 1, rarity = 1},
            }
        
        },
        {
            no = 2,
            name = "Pistol Case",
            style = "max-width: 50%;margin-left: 20%;",
            image = "cases/2.png",
            credit = 50,
            items = {
                {type = "item", item = "weapon_pistol", count = 1},
                {type = "item", item = "water", count = 1},
                {type = "item", item = "bread", count = 1},
                {type = "item", item = "phone", count = 1},
                {type = "item", item = "weapon_knife", count = 1},
                {type = "item", item = "weapon_bat", count = 1},
                {type = "item", item = "pistol_ammo", count = 1},
                {type = "item", item = "weapon_snspistol", count = 1},
            }
        
        },
        {
            no = 3,
            name = "Pistol Case",
            image = "cases/3.png",
            style = "max-width: 50%;margin-left: 20%;",
            credit = 50,
            items = {
                {type = "item", item = "weapon_pistol", count = 1},
                {type = "item", item = "water", count = 1},
                {type = "item", item = "bread", count = 1},
                {type = "item", item = "phone", count = 1},
                {type = "item", item = "weapon_knife", count = 1},
                {type = "item", item = "weapon_bat", count = 1},
                {type = "item", item = "pistol_ammo", count = 1},
                {type = "item", item = "weapon_snspistol", count = 1},
            }
        
        },
        {
            no = 4,
            name = "Pistol Case",
            image = "cases/4.png",
            style = "max-width: 50%;margin-left: 20%;",
            credit = 50,
            items = {
                {type = "item", item = "weapon_pistol", count = 1},
                {type = "item", item = "water", count = 1},
                {type = "item", item = "bread", count = 1},
                {type = "item", item = "phone", count = 1},
                {type = "item", item = "weapon_knife", count = 1},
                {type = "item", item = "weapon_bat", count = 1},
                {type = "item", item = "pistol_ammo", count = 1},
                {type = "item", item = "weapon_snspistol", count = 1},
            }
        
        },
        {
            no = 5,
            name = "Pistol Case",
            image = "cases/5.png",
            style = "max-width: 50%;margin-left: 20%;",
            credit = 50,
            items = {
                {type = "item", item = "weapon_pistol", count = 1},
                {type = "item", item = "water", count = 1},
                {type = "item", item = "bread", count = 1},
                {type = "item", item = "phone", count = 1},
                {type = "item", item = "weapon_knife", count = 1},
                {type = "item", item = "weapon_bat", count = 1},
                {type = "item", item = "pistol_ammo", count = 1},
                {type = "item", item = "weapon_snspistol", count = 1},
            }
        
        },
        {
            no = 6,
            name = "Pistol Case",
            image = "cases/6.png",
            style = "max-width: 65%;margin-left: 20%;",
            credit = 50,
            items = {
                {type = "item", item = "weapon_pistol", count = 1},
                {type = "item", item = "water", count = 1},
                {type = "item", item = "bread", count = 1},
                {type = "item", item = "phone", count = 1},
                {type = "item", item = "weapon_knife", count = 1},
                {type = "item", item = "weapon_bat", count = 1},
                {type = "item", item = "pistol_ammo", count = 1},
                {type = "item", item = "weapon_snspistol", count = 1},
            }
        
        },
        {
            no = 7,
            name = "MOTO CASE",
            image = "cases/7.png",
            style = "max-width: 65%;margin-left: 20%;margin-bottom: 5%;",
            credit = 50,
            items = {
                
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
                {type = "car", item = "sanchez", label = "Sanchez", count = 1},
            }
        
        }

}




Config.Table = {
    {
        RentCar = {
            {label = "Mercedes Benz Amg", name = "t20", image = "./images/Daco_202882.png", coin = 100},
            {label = "Bmw", name = "t20", image = "./images/Daco_202882.png", coin = 120},
            {label = "Mercedes Benz", name = "t20", image = "./images/Daco_202882.png", coin = 100},
        },
        OwnedCar = {
            {label = "MCLAREN 625LT",
            name = "t20",
            maximumspeed = "340 km/h",
            trunkcapacity = "2 L",
            acceleration100 = "3.6 sec",
            fueltankcapacity = "150 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/t20.png", 
            coin = 120},

            {label = "ZENTORNO",
            name = "zentorno",
            maximumspeed = "320 km/h",
            trunkcapacity = "1 L",
            acceleration100 = "3.2 sec",
            fueltankcapacity = "120 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/zentorno.png", 
            coin = 135},

            {label = "ADDER VIP",
            name = "adder",
            maximumspeed = "340 km/h",
            trunkcapacity = "1 L",
            acceleration100 = "3.0 sec",
            fueltankcapacity = "140 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/adder.png", 
            coin = 125},

            {label = "OSIRIS VIP",
            name = "osiris",
            maximumspeed = "360 km/h",
            trunkcapacity = "1 L",
            acceleration100 = "2.8 sec",
            fueltankcapacity = "70 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/osiris.png", 
            coin = 155},

            {label = "CHEETAH VIP",
            name = "cheetah",
            maximumspeed = "290 km/h",
            trunkcapacity = "5 L",
            acceleration100 = "4 sec",
            fueltankcapacity = "100 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/cheetah.png", 
            coin = 100},

            {label = "TURISMO R VIP",
            name = "turismor",
            maximumspeed = "350 km/h",
            trunkcapacity = "2 L",
            acceleration100 = "2.5 sec",
            fueltankcapacity = "50 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/turismor.png", 
            coin = 180},

            
            {label = "TURISMO 2 VIP",
            name = "turismo2",
            maximumspeed = "260 km/h",
            trunkcapacity = "7 L",
            acceleration100 = "6 sec",
            fueltankcapacity = "170 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/turismo2.png", 
            coin = 105},

            {label = "REAPER  VIP",
            name = "reaper",
            maximumspeed = "270 km/h",
            trunkcapacity = "5 L",
            acceleration100 = "4 sec",
            fueltankcapacity = "120 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/reaper.png", 
            coin = 175},

            {label = "AUTARCH  VIP",
            name = "autarch",
            maximumspeed = "320 km/h",
            trunkcapacity = "4 L",
            acceleration100 = "2.3 sec",
            fueltankcapacity = "40 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/autarch.png", 
            coin = 200},

            {label = "NERO  VIP",
            name = "nero",
            maximumspeed = "320 km/h",
            trunkcapacity = "4 L",
            acceleration100 = "2.3 sec",
            fueltankcapacity = "40 L",
            insurance = "30 days",
            extras = "Full Tuning",
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/nero.png", 
            coin = 200},
        },
        Item = {
            {label = "Radio", name = "t20",category="electronic",desc="Thanks to this item, you can communicate through private channels", image = "./images/radio.png", coin = 22},
            {label = "Psp", name = "t20",category="electronic",desc="Thanks to this item, you can play games that no one else has access to.", image = "./images/psp.png", coin = 25},
            {label = "Scanner", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/radio-scanner.png", coin = 25},
            {label = "Supp", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/pistol_suppressor.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
            {label = "Usb", name = "t20",category="electronic",desc="With this item you can access the radio channels of the police and statesmen..", image = "./images/np_unknown-usb-device.png", coin = 25},
        },
        BuyingCash = {
            {label = "Golden State", money = "50000", image = "./images/money.png", coin = 120},
            {label = "Golden State", money = "50000", image = "./images/money.png", coin = 120},
            {label = "Golden State", money = "50000", image = "./images/money.png", coin = 120},
            {label = "Golden State", money = "50000", image = "./images/money.png", coin = 120},
            
        },
        PromotionPack = {
            {label = "Bmw", 
            price="150000", 
            name = "t20", 
            image = "https://raw.githubusercontent.com/MericcaN41/gta5carimages/main/images/zentorno.png", 
            coin = 120},
        },
    },
}


Config.TestDrive = {
	seconds = 5,
	coords  = vector3(-966.5, -3355.7, 13.9),
	range   = 400,
}

Config.Day =14