fx_version 'cerulean'
game 'gta5'

name 'dps_police'
author 'DPS Enhanced. A port of qbx_policejob by the Qbox Project.'
description 'Police for Qbox: duty, cuffs, escort, evidence, fingerprints, fines, impound, radar and jail, for every law enforcement job. A port of qbx_policejob.'
repository 'https://github.com/DPS-Enhanced/dps-enhanced'
version '0.1.0'
license 'GPL-3.0-or-later'

-- This resource takes the place of qbx_policejob. Scripts that call it by that name keep working
-- because of this line. Do not run qbx_policejob next to it.
provide 'qbx_policejob'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua'
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/vue.min.js',
    'html/script.js',
    'html/fingerprint.png',
    'html/main.css',
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'