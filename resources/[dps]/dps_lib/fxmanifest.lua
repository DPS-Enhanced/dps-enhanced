fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps_lib'
author 'DPS Enhanced'
description 'Shared helper library for DPS Enhanced resources: the DPS look and a few helpers Qbox does not have'
version '0.1.0'
repository 'https://github.com/DPS-Enhanced/dps_lib'
license 'GPL-3.0-or-later'

shared_scripts {
    'shared/theme.lua',
    'shared/job.lua',
}

server_script 'server/main.lua'
client_script 'client/main.lua'

-- NUI pages in other resources can load the shared look:
--   <link rel="stylesheet" href="https://cfx-nui-dps_lib/web/dps.css">
files {
    'web/dps.css',
}

dependency 'qbx_core'
