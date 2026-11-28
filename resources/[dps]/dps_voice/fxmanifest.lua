fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps_voice'
author 'DPS Enhanced'
description 'Voice for FiveM for GTAV Enhanced: talking distance, radio and phone calls on the new server voice API. Answers to the pma-voice calls other scripts already use.'
version '0.1.0'
repository 'https://github.com/DPS-Enhanced/dps-enhanced'
license 'GPL-3.0-or-later'

shared_scripts {
    '@ox_lib/init.lua',
}

server_script 'server/main.lua'
client_script 'client/main.lua'

files {
    'config.lua',
}

dependency 'ox_lib'

-- Scripts written for pma-voice call exports['pma-voice']. This line sends those calls here.
-- Do not run pma-voice next to this resource.
provide 'pma-voice'
