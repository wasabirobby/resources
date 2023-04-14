Config = {}

Config['FrameworkSettings'] = {
    ['Framework'] = 'QBCore', -- QBCore or ESX
    ['QBCoreFileName'] = 'qb-core',
    ['PlayerLoadedQBCore'] = 'QBCore:Client:OnPlayerLoaded',
    --['ESXEvent'] = 'esx:getSharedObject',
    --['PlayerLoadedESX'] = 'esx:playerLoaded',
    ['SQLWrapper'] = 'oxmysql', -- oxmysql, mysql-async
}

Config['NpcSettings'] = {
    ['Coords'] = vector4(1476.72, -1780.94, 16, 233.83),
    ['Hash'] = 'a_m_m_business_01'
}

Config['BlipSettings'] = {
    ['Sprite'] = 374,
    ['Color'] = 3,
    ['Scale'] = 0.5,
    ['Label'] = 'Investments Center'
}  

Config['Investments'] = {
    ['DayTime'] = {
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016738561380335758/unknown.png',
            ['Profit'] = 10000,
            ['Hours'] = 1
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016741981445177374/unknown.png',
            ['Profit'] = 25000,
            ['Hours'] = 2
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742033928503417/unknown.png',
            ['Profit'] = 40000,
            ['Hours'] = 3
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742083635187762/unknown.png',
            ['Profit'] = 55000,
            ['Hours'] = 4
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742143580180640/unknown.png',
            ['Profit'] = 75000,
            ['Hours'] = 5
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742188589265008/unknown.png',
            ['Profit'] = 100000,
            ['Hours'] = 6
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742234290409532/unknown.png',
            ['Profit'] = 125000,
            ['Hours'] = 7
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742282105471057/unknown.png',
            ['Profit'] = 150000,
            ['Hours'] = 8
        }
    },
    ['LongTerm'] = {
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016738561380335758/unknown.png',
            ['Cost'] = 100000,
            ['Profit'] = 15000,
            ['Hours'] = 100
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016741981445177374/unknown.png',
            ['Cost'] = 500000,
            ['Profit'] = 75000,
            ['Hours'] = 100
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742033928503417/unknown.png',
            ['Cost'] = 1000000,
            ['Profit'] = 150000,
            ['Hours'] = 100
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742083635187762/unknown.png',
            ['Cost'] = 2500000,
            ['Profit'] = 375000,
            ['Hours'] = 100
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742143580180640/unknown.png',
            ['Cost'] = 5000000,
            ['Profit'] = 750000,
            ['Hours'] = 100
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742188589265008/unknown.png',
            ['Cost'] = 100000,
            ['Profit'] = 33000,
            ['Hours'] = 200
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742234290409532/unknown.png',
            ['Cost'] = 500000,
            ['Profit'] = 165000,
            ['Hours'] = 200
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742234290409532/unknown.png',
            ['Cost'] = 1000000,
            ['Profit'] = 330000,
            ['Hours'] = 200
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016738561380335758/unknown.png',
            ['Cost'] = 2500000,
            ['Profit'] = 825000,
            ['Hours'] = 200
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016741981445177374/unknown.png',
            ['Cost'] = 5000000,
            ['Profit'] = 1650000,
            ['Hours'] = 200
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742033928503417/unknown.png',
            ['Cost'] = 100000,
            ['Profit'] = 53000,
            ['Hours'] = 300
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742083635187762/unknown.png',
            ['Cost'] = 500000,
            ['Profit'] = 265000,
            ['Hours'] = 300
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742143580180640/unknown.png',
            ['Cost'] = 1000000,
            ['Profit'] = 530000,
            ['Hours'] = 300
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742188589265008/unknown.png',
            ['Cost'] = 2500000,
            ['Profit'] = 1325000,
            ['Hours'] = 300
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742234290409532/unknown.png',
            ['Cost'] = 5000000,
            ['Profit'] = 2650000,
            ['Hours'] = 300
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742282105471057/unknown.png',
            ['Cost'] = 100000,
            ['Profit'] = 75000,
            ['Hours'] = 400
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016738561380335758/unknown.png',
            ['Cost'] = 500000,
            ['Profit'] = 375000,
            ['Hours'] = 400
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016741981445177374/unknown.png',
            ['Cost'] = 1000000,
            ['Profit'] = 750000,
            ['Hours'] = 400
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742033928503417/unknown.png',
            ['Cost'] = 2500000,
            ['Profit'] = 1875000,
            ['Hours'] = 400
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742083635187762/unknown.png',
            ['Cost'] = 5000000,
            ['Profit'] = 3750000,
            ['Hours'] = 400
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742143580180640/unknown.png',
            ['Cost'] = 100000,
            ['Profit'] = 100000,
            ['Hours'] = 500
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742188589265008/unknown.png',
            ['Cost'] = 500000,
            ['Profit'] = 500000,
            ['Hours'] = 500
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742234290409532/unknown.png',
            ['Cost'] = 1000000,
            ['Profit'] = 1000000,
            ['Hours'] = 500
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016742282105471057/unknown.png',
            ['Cost'] = 2500000,
            ['Profit'] = 2500000,
            ['Hours'] = 500
        },
        {
            ['ImgLink'] = 'https://cdn.discordapp.com/attachments/928768829675429938/1016738561380335758/unknown.png',
            ['Cost'] = 5000000,
            ['Profit'] = 5000000,
            ['Hours'] = 500
        }
    }
}

Config['Text'] = {
    ['OpenMenu'] = 'Press ~INPUT_CONTEXT~ to open the investments menu',
    ['NotEnough'] = 'Not enough money'
}