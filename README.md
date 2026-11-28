<p align="center"><img src="https://raw.githubusercontent.com/DPS-Enhanced/.github/main/profile/assets/banner.svg" alt="DPS Enhanced: free, open-source roleplay resources for FiveM for GTAV Enhanced" width="100%"></p>

# DPS Enhanced

A free, open-source server pack for **FiveM for GTAV Enhanced**.

Everything DPS makes lives in this one repository, so you do not have to collect scripts from many
places. It runs on [Qbox](https://github.com/Qbox-project) and
[Overextended](https://github.com/overextended). Nothing here is paid or locked.

## Status

**Early.** The pack is being built one resource at a time. A resource is listed below only after it
has started without errors on our Enhanced test server.

| Resource | What it does | Status |
|---|---|---|
| [`dps_lib`](resources/%5Bdps%5D/dps_lib) | The DPS look (colours and a shared style sheet) and a few helpers Qbox does not have | Starts clean on Enhanced. Used by `dps_welcome`. |
| [`dps_welcome`](resources/%5Bdps%5D/dps_welcome) | The loading screen (video, pictures or the DPS backdrop) and the spawn screen, with a camera over each spawn point, job spawns and a first-time welcome. A port of qbx_spawn and bd_loadingscreen. | Tested in game on Enhanced. |
| [`dps_voice`](resources/%5Bdps%5D/dps_voice) | Voice on Enhanced's new voice system: talking distance, radio and phone calls. Answers to the pma-voice calls other scripts use. | Starts clean. Channels checked with `/voicetest`. Sound between two players not tested yet. |
| [`dps_medical`](resources/%5Bdps%5D/dps_medical) | Health, injuries, bleeding, last stand and death. A port of qbx_medical. Illness and patient records are being added. | Starts clean. Not tested in game yet. |
| [`overlays/ox_inventory`](overlays/ox_inventory) | The DPS item list for ox_inventory, with rules for which items load. | Loads 1,300 items on Enhanced. Not opened in game yet. |

A one-paste install (a txAdmin recipe) is planned. It is not ready yet, so for now you install by
hand with the steps below.

## What you need

| Requirement | Notes |
|---|---|
| A FiveM for GTAV Enhanced server | Download it from the [Cfx server download page](https://docs.fivem.net/docs/server-download/) with **Platform** set to *FiveM for GTAV Enhanced*. Windows or Linux. |
| [qbx_core](https://github.com/Qbox-project/qbx_core) | The framework. Install it the way the [Qbox docs](https://docs.qbox.re/) describe. |
| [ox_lib](https://github.com/overextended/ox_lib) and [oxmysql](https://github.com/overextended/oxmysql) | Qbox needs these too. |
| MariaDB or MySQL | Any recent version. |

## Install

1. Download this repository: the green **Code** button, then **Download ZIP**. Unzip it.
2. Copy the folder `resources/[dps]` into your server's `resources` folder.
3. Open your `server.cfg`. After the lines that start Qbox and ox, add:

   ```
   ensure [dps]
   ```

4. Restart the server.
5. Look at the server console. You should see this line:

   ```
   [dps_lib] v0.1.0 ready, self-check 9/9
   ```

   If you see it, the pack is loaded.

`ensure [dps]` starts every resource inside the `[dps]` folder. To leave one out, delete its folder.

## Settings that matter on Enhanced

These cost us time, so we list them here.

- Do **not** put `sv_enforceGameBuild 1` in `server.cfg`. On Enhanced it means "base game with no
  DLC", and player characters become invisible.
- If you add custom cars or other `.yft` models, add this line to `server.cfg`, or players can
  crash: `increase_pool_size "FragmentStore" 2000`
- Models and textures made for the old FiveM must be converted with Cfx's
  [Alchemist](https://docs.fivem.net/docs/alchemist/) tool before Enhanced can use them.

## Guides

- [Add a script to the pack](docs/add-a-script.md)
- [Change the look](docs/change-the-look.md)

## Contributing

Pull requests are welcome. Read the
[contributing guide](https://github.com/DPS-Enhanced/.github/blob/main/CONTRIBUTING.md) first.

## Thanks

[Qbox](https://github.com/Qbox-project) for the framework,
[Overextended](https://github.com/overextended) for ox_lib and oxmysql, and
[Cfx.re](https://cfx.re) for FiveM and Alchemist.

## Licence

[GNU General Public License v3.0](LICENSE). You can use, change, rename and share everything here.
If you share a changed version, share its source code under the same licence.
