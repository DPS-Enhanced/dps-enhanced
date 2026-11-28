fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps_jobs'
author 'DPS Enhanced'
description 'The DPS job list for Qbox: police, medical, fire and justice, with their ranks and pay. Adds them to qbx_core at start, so qbx_core itself stays stock.'
version '0.1.0'
repository 'https://github.com/DPS-Enhanced/dps-enhanced'
license 'GPL-3.0-or-later'

shared_script '@ox_lib/init.lua'

server_script 'server/main.lua'

files {
    'data/jobs.lua',
}

dependencies {
    'ox_lib',
    'qbx_core',
}
