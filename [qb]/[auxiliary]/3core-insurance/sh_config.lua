Config = {}

Config['FrameworkSettings'] = {
    ['Framework'] = 'QBCore', -- QBCore or ESX
    ['QBCoreFileName'] = 'qb-core',
    ['ESXEvent'] = 'esx:getSharedObject',
    ['SQLWrapper'] = 'oxmysql' -- oxmysql / mysql-async
}

Config['PayTime'] = 5 -- In minutes

Config['KeyMapping'] = {
    ['Command'] = 'opencontrol',
    ['Description'] = 'Open Insurance Control Panel',
    ['Key'] = 'F7'
}

Config['NpcSettings'] = {
    ['coords'] = vector4(1845.45, -1916.22, 14.02, 235.09),
    ['hash'] = 'a_m_m_business_01'
}

Config['Prices'] = {
    ['basic'] = 1500,
    ['standart'] = 2000,
    ['premium'] = 4000
}

Config['OpenMenuKey'] = 38

Config['Text'] = {
    ['OpenMenu'] = 'Press ~INPUT_CONTEXT~ to open the insurance menu',
    ['NotEnoughMoney'] = 'You do not have enough money',
    ['CameraSet'] = 'The camera is set to %s',
    ['CameraDestroyed'] = 'The camera was destroyed',
    ['Lock'] = 'The vehicle is %s',
    ['Gps'] = 'The gps is %s',
    ['Engine'] = 'The vehicle engine is %s',
    ['Paid'] = 'You have paid %s for your vehicle insurance',
    ['Canceled'] = 'Your vehicle insurance was canceled because you don\'t have enough money'
}