# Add a script to the pack

Every DPS resource is one folder inside `resources/[dps]`. The server starts everything in that
folder with one line, `ensure [dps]`, so adding a script never means editing `server.cfg`.

## To use a script

1. Put its folder in `resources/[dps]`.
2. Restart the server.

To stop using it, delete the folder and restart.

## To write a new one

Use this layout. Every DPS resource looks the same, so anyone who has read one can read them all.

```
resources/[dps]/dps_name/
  fxmanifest.lua     what the resource is and which files it loads
  config.lua         everything a server owner may change, with a comment on each line
  client/            code that runs in the player's game
  server/            code that runs on the server
  shared/            code used on both sides
  locales/           text shown to players
  stream_enhanced/   converted models and textures, if it has any
  sql/               database tables, if it has any
  README.md          what it is for, what it does, how to set it up
```

A starting `fxmanifest.lua`:

```lua
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'dps_name'
description 'One sentence: what this does for a player or a server owner'
version '0.1.0'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }
client_script 'client/main.lua'
server_script 'server/main.lua'

dependencies { 'qbx_core', 'ox_lib' }
```

## Rules

1. **No paid or locked dependencies.** Depend only on Qbox, Overextended and other DPS resources.
2. **Call Qbox directly** for players, money and jobs: `exports.qbx_core:GetPlayer(source)`,
   `AddMoney`, `RemoveMoney`, `HasGroup`, `Notify`. Do not write a bridge.
3. **Use `dps_lib`** for the DPS colours and for "has this job and is on duty":
   `exports.dps_lib:HasJob(source, 'police', 0, true)`.
4. **Store against the citizen ID**, never the server ID. Enhanced gives a server ID to the next
   player as soon as the first one leaves. `exports.dps_lib:GetCitizenId(source)` returns it.
5. **One job per resource.** A small fix goes into the resource it fixes, not into a new one.
6. **Test it on an Enhanced server** before you open a pull request.

The full list, with the Enhanced changes to watch for, is in the
[contributing guide](https://github.com/DPS-Enhanced/.github/blob/main/CONTRIBUTING.md).
