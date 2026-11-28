# dps_welcome

The first screen a player sees after picking a character: where do you want to start?

For Qbox servers on FiveM for GTAV Enhanced.

## Credit

This is a port of [qbx_spawn](https://github.com/Qbox-project/qbx_spawn) by the Qbox Project
(version 0.1.1). Their spawn logic is the base of this resource, and it is licensed GPL-3.0, as
this resource is.

## What it does

- **A DPS screen** in place of the heist map. A list of cards on the left, the world on the right.
- **A camera over every spawn point.** Move down the list and the camera glides to the next place,
  so you see where you are going before you go.
- **Continue.** The top card is always where you left off.
- **Job spawns.** Police see their station, medics see their hospital. Nobody else sees those cards.
- **Homes.** Any property you own shows as a card (needs `qbx_properties`).
- **A welcome for new characters.** A slow flight in over the city, with the server's name, before
  the list opens.

## Install

1. Put this folder in `resources/[dps]/`.
2. Do not run `qbx_spawn` as well. This resource answers to its name, so `qbx_core` needs no change.
3. `ensure dps_welcome` in `server.cfg`.

Needs `ox_lib`, `oxmysql`, `qbx_core` and `dps_lib`.

When the server starts, look for this line in the console:

```
[dps_welcome] v0.2.0 ready, answering as qbx_spawn (started)
```

If it is red instead, `qbx_core` cannot find the spawn screen. Check that `qbx_spawn` is not also
in your resources folder.

## Change it

Everything is in `config/client.lua`.

| Setting | What it changes |
|---|---|
| `serverName` | The name at the top of the screen and in the welcome |
| `welcome` | Turn the new-character flight on or off, and where it starts |
| `camera` | How far back and how high the camera sits, and how fast it glides |
| `spawns` | The spawn points |

### Add a spawn point

Stand where players should appear, face the way they should face, and note your position
(`/coords` in most admin menus). Then add a block to `spawns`:

```lua
{
    label = 'Del Perro Pier',
    detail = 'West side',
    coords = vec4(-1650.0, -1000.0, 13.0, 50.0),
},
```

### Make it a job spawn

Add `jobs`. Only players with that job see the card.

```lua
jobs = 'police',                       -- one job
jobs = { 'police', 'sheriff' },        -- any of these
jobs = { police = 2 },                 -- police at grade 2 or higher
onDuty = true,                         -- and only while on duty
```

### Change the colours

The screen takes its colours from `dps_lib`. Change the theme there and this screen follows. See
`docs/change-the-look.md` in the pack.

## How to use it in game

- **Up / Down** (or W / S): look at the next spawn point.
- **Enter**: start there.
- **Mouse**: click a card to look, click it again to start.
