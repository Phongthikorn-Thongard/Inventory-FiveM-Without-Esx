fx_version 'cerulean'
game 'gta5'

author 'SkyeZ'
description 'Inventory created for Utopia'
version '1.0.0'

client_script {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/common.lua',
    'server/function.lua',
    'server/classes/player.lua',
    'server/commands.lua'
}

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/css/style.css',
    'nui/js/inventory.js',
    'nui/js/setup-config.js',
    'nui/js/config.js',
    'nui/image/*'
}