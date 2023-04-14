lua54 'yes'
fx_version 'adamant'
game 'gta5'

ui_page "ui/index.html"

client_scripts {  'config.lua','client.lua' }

server_scripts {  '@mysql-async/lib/MySQL.lua', 'server.lua','config.lua'}
escrow_ignore {
        'config.lua',
    }
 

files { 
       "ui/index.html",
       "bp.png",
       "ui/line.png",
       "bg.png",
        "ui/gif.gif",
        "ui/fonts/*.ttf",
        "ui/cases/*.png",
        "ui/items/*.png",
        "ui/vids/*.mp4",
        "ui/*.mp3",
        "ui/script.js",
        "ui/style.css",
        "ui/images/*.png",
        "ui/images/*.jpg",
        "ui/images/*.gif"
}
 