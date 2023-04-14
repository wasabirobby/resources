-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Police Job'
author 'wasabirobby#5110'
version '1.3.3'

shared_scripts { '@ox_lib/init.lua', 'configuration/*.lua' }

client_scripts { 'bridge/**/client.lua', 'client/*.lua' }

server_scripts { '@mysql-async/lib/MySQL.lua', 'bridge/**/server.lua', 'server/*.lua' }

dependencies { 'mysql-async', 'ox_lib' }

provides { 'esx_policejob', 'qb-policejob' }

escrow_ignore {
  'configuration/*.lua',
  'bridge/**/*.lua',
  'client/client.lua',
  'client/radial.lua',
  'client/cl_customize.lua',
  'server/sv_customize.lua'
}

dependency '/assetpacks'