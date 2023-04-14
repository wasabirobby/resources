fx_version 'bodacious'

version '0.0.0'

games { 'gta5' }

ui_page 'html/index.html'
files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/*otf',
  'html/*png',
  'images/*.png',
  'images/*.jpg',
  'images/*.webp',
  'images/*.mp4',
  'fonts/*.ttf',
  'fonts/*.otf'
 
}

client_scripts{
  '@PolyZone/client.lua',
  'client/client.lua',
  'config.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@oxmysql/lib/MySQL.lua',
  'server/server.lua',
  'config.lua',
}
