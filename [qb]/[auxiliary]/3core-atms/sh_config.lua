Config = {}

-- Adjust this for your framework

Config['FrameworkSettings'] = {
    ['Framework'] = 'QBCore', -- QBCore or ESX
    ['QBCoreFileName'] = 'qb-core',
    ['ESXEvent'] = 'esx:getSharedObject',
    ['SQLWrapper'] = 'oxmysql', -- oxmysql, mysql-async
}

-- ATM Price

Config['Price'] = 100000

-- Percentage that will go to the atm owner

Config['Fee'] = 16

-- The actions that will take fee

Config['FeeActions'] = {
    ['Withdraw'] = true,
    ['Deposit'] = false,
    ['Transfer'] = true
}

-- ATMS Props

Config['ATMS'] = {
    'prop_atm_01', 
    'prop_atm_02', 
    'prop_fleeca_atm', 
    'prop_atm_03'
}

-- Text translation

Config['Text'] = {
    ['OpenATM'] = 'Press ~INPUT_CONTEXT~ to access the ATM',
    ['NoMoney'] = 'Not enough money to process the request',
    ['Deposit'] = 'You have deposited %s$',
    ['Withdraw'] = 'You have withdrawn %s$',
    ['TransferP'] = 'You have transferred %s$ to %s',
    ['TransferT'] = 'You got %s$ from %s',
    ['NotOnline'] = 'The target is not online',
    ['RobS'] = 'You have stole %s$ from this atm',
    ['AtmIsEmpty'] = 'This ATM is empty'
}