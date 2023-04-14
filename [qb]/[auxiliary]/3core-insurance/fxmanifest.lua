fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_script 'sh_config.lua'

client_script 'cl_main.lua'

server_scripts {
    'sv_db.lua',
    'sv_main.lua'
}

ui_page 'public/index.html'

files {'public/index.html', 'public/build/bundle.js', 'public/build/bundle.css'}