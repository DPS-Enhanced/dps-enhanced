# dps_police

Police for Qbox servers on FiveM for GTAV Enhanced.

## Credit

This is a port of [qbx_policejob](https://github.com/Qbox-project/qbx_policejob) by the Qbox
Project, taken from its `main` branch at commit `7fa438f` (2026-09-26). Their code is the base of
this resource, and it is licensed GPL-3.0, as this resource is.

## What it does

- On and off duty, armory, evidence locker, job vehicles and helicopters.
- Handcuffs (as an item or a command), soft cuffs, escort, search.
- Evidence: bullet casings, blood drops, fingerprints, gunshot residue, evidence bags.
- Fines, speed radars, plate flags, impound and depot.
- Jail, ankle tracker, security cameras.
- Road objects: cones, barriers, signs, lights, spike strips.

**It works for every law enforcement job, not only `police`.** Any job whose `type` is `leo`
counts. With `dps_jobs` that is LSPD, BCSO, SASP, FIB, DOC, DFW and the Coast Guard.

## What we changed from qbx_policejob

- Fines no longer need a banking script. Before, a server without `Renewed-Banking` threw an error
  after the player had already been charged. Now the fine is taken either way, and it is banked to
  the department only if `Renewed-Banking` is running.

## Install

1. Put this folder in `resources/[dps]/`.
2. Do not run `qbx_policejob` as well. This resource answers to its name.
3. `ensure dps_police` after `qbx_core` and `ox_inventory`.

Needs `ox_lib`, `oxmysql`, `qbx_core` and `ox_inventory`.

Works better with, but does not need: `Renewed-Banking` (department account), `qbx_prison` or
`xt-prison` (jail), `InteractSound` (cuff sounds).

These items must exist in ox_inventory: `handcuffs`, `empty_evidence_bag`, `filled_evidence_bag`,
`heavyarmor`, `police_stormram`.

## Commands

| Command | What it does |
|---|---|
| `/cuff`, `/sc` | Cuff or soft cuff the nearest player |
| `/escort` | Escort the nearest player |
| `/jail [id] [time]`, `/unjail [id]` | Send to or release from jail |
| `/fine` | Fine a citizen within 5 metres |
| `/seizecash` | Seize the nearest player's cash |
| `/callsign [text]` | Set your callsign |
| `/spikestrip` | Place a spike strip |
| `/pobject [cone/barrier/roadsign/tent/light/delete]` | Place or remove a road object |
| `/flagplate [plate] [reason]`, `/unflagplate [plate]`, `/plateinfo [plate]` | Flag, unflag or check a plate |
| `/depot [price]`, `/impound` | Depot a vehicle for a fee, or impound it for good |
| `/anklet`, `/ankletlocation [citizenId]` | Fit a tracker, or find one |
| `/takedna [id]` | Take a DNA sample |
| `/clearcasings`, `/clearblood` | Clear evidence nearby |
| `/cam [cam]` | View a security camera |
| `/grantlicense`, `/revokelicense` | Give or take a licence |
| `/paytow [id]`, `/paylawyer [id]` | Pay a tow driver or a lawyer |
| `/911p [message]` | Anyone: send a report to the police |

## Change it

- `config/shared.lua`: stations, garages, armory, radar fines, the top fine allowed.
- `config/client.lua`: job vehicles, their liveries and extras.
- `config/server.lua`: which rank can give licences, tow and lawyer pay.
