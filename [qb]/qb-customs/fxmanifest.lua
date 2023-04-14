fx_version "cerulean"
game "gta5"

shared_scripts {
    "@qb-core/shared/locale.lua", "locales/en.lua", "locales/*.lua",
    "config.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua", "server/functions.lua", "server/main.lua"
}

client_scripts {
    "@PolyZone/client.lua", "@PolyZone/BoxZone.lua", "@PolyZone/ComboZone.lua",
    "client/functions.lua", "client/main.lua"
}

files {"html/assets/*.js", "html/assets/*.css", "html/index.html"}

-- ui_page "html/index.html"
ui_page "http://localhost:5173"
