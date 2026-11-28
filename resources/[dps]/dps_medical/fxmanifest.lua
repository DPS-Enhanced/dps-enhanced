fx_version 'cerulean'
game 'gta5'

name 'dps_medical'
author 'DPS Enhanced. A port of qbx_medical by the Qbox Project.'
description 'Health, injuries, bleeding, last stand and death for Qbox, with DPS illness and patient records. A port of qbx_medical.'
repository 'https://github.com/DPS-Enhanced/dps-enhanced'
version '0.3.0'
license 'GPL-3.0-or-later'

-- This resource takes the place of qbx_medical. Scripts that call exports.qbx_medical keep
-- working because of this line. Do not run qbx_medical next to it.
provide 'qbx_medical'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/**/*.lua',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/damage/apply-damage-effects.lua',
    'client/damage/damage.lua',
    'client/dead.lua',
    'client/laststand.lua',
    'client/load-unload.lua',
    'client/main.lua',
    'client/setdownedstate.lua',
    'client/wounding.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'locales/*.json',
    'config/client.lua',
    'config/shared.lua',
}

dependencies {
    'ox_lib',
    'qbx_core',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
