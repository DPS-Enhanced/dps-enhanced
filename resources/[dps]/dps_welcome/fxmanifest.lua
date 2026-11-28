fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'dps_welcome'
author 'DPS Enhanced. A port of qbx_spawn by the Qbox Project.'
description 'Spawn selection for Qbox: a DPS screen with a camera over each spawn point, job spawns and a first-time welcome. A port of qbx_spawn.'
version '0.2.0'
repository 'https://github.com/DPS-Enhanced/dps-enhanced'
license 'GPL-3.0-or-later'

-- This resource takes the place of qbx_spawn. qbx_core looks for a running resource with that
-- name before it opens the spawn screen, and this line is what answers. Do not run qbx_spawn
-- next to it.
provide 'qbx_spawn'

ox_lib 'locale'

shared_script '@ox_lib/init.lua'

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

ui_page 'web/index.html'

-- The loading screen: a port of bd_loadingscreen by BebikDEV (GPL-3.0). Its settings are in
-- web/loading/config.js. qbx_core closes it when the character screen is ready.
loadscreen 'web/loading/index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'yes'

files {
    'config/client.lua',
    'locales/*.json',
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'web/loading/index.html',
    'web/loading/loading.css',
    'web/loading/loading.js',
    'web/loading/config.js',
    'web/loading/dps-logo.svg',
    -- Your own video, pictures and music for the loading screen go in web/loading/ and are
    -- picked up by these lines.
    'web/loading/*.webm',
    'web/loading/*.jpg',
    'web/loading/*.png',
    'web/loading/*.mp3',
    'web/loading/*.ogg',
}

dependencies {
    'ox_lib',
    'oxmysql',
    'qbx_core',
    'dps_lib',
}
