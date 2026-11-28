<p align="center"><img src="https://raw.githubusercontent.com/DPS-Enhanced/.github/main/profile/assets/banner.svg" alt="DPS Enhanced: free, open-source roleplay resources for FiveM for GTAV Enhanced" width="100%"></p>

# DPS Enhanced

Free, open-source resources for [Qbox](https://github.com/Qbox-project) servers on
**FiveM for GTAV Enhanced**.

This repository is the front door. It holds the install guide and the notes that apply to every
resource. **The resources themselves each live in their own repository.**

## The resources

| Resource | What it does | Status |
|---|---|---|
| [**dps_welcome**](https://github.com/DPS-Enhanced/dps_welcome) | Loading screen with video or pictures, and a spawn screen with a camera over each spawn point | Tested in game |
| [**dps_police**](https://github.com/DPS-Enhanced/dps_police) | Police for every law enforcement job: duty, cuffs, evidence, fines, impound, jail | Starts clean |
| [**dps_medical**](https://github.com/DPS-Enhanced/dps_medical) | Health, injuries, bleeding, last stand and death | Starts clean |
| [**dps_voice**](https://github.com/DPS-Enhanced/dps_voice) | Voice chat on the new Enhanced voice system: talking distance, radio, phone calls | Starts clean |
| [**dps_jobs**](https://github.com/DPS-Enhanced/dps_jobs) | The DPS job list: police, medical, fire and justice, with ranks and pay | Starts clean |
| [**dps_lib**](https://github.com/DPS-Enhanced/dps_lib) | The DPS look and a few helpers the other resources share | Starts clean |

*Tested in game* means it has been played on an Enhanced server. *Starts clean* means it loads on an
Enhanced server with no errors, and has not been played yet.

Also here: [`overlays/ox_inventory`](overlays/ox_inventory), the DPS item list for ox_inventory.

## What you need

| Requirement | Notes |
|---|---|
| A FiveM for GTAV Enhanced server | Download it from the [Cfx server download page](https://docs.fivem.net/docs/server-download/) with **Platform** set to *FiveM for GTAV Enhanced*. Windows or Linux. |
| [qbx_core](https://github.com/Qbox-project/qbx_core) | The framework. Install it the way the [Qbox docs](https://docs.qbox.re/) describe. |
| [ox_lib](https://github.com/overextended/ox_lib), [oxmysql](https://github.com/overextended/oxmysql), [ox_target](https://github.com/overextended/ox_target), [ox_inventory](https://github.com/overextended/ox_inventory) | The Overextended libraries. |
| MariaDB or MySQL | Any recent version. |

Each resource lists anything extra it needs in its own README.

## Install a resource

1. Open the resource's repository from the table above.
2. Click the green **Code** button, then **Download ZIP**. Unzip it.
3. Rename the folder to the resource's name, for example `dps_police`. GitHub adds `-main` to the
   folder name, and the resource will not start with that on the end.
4. Put the folder in your server's `resources` folder. A `[dps]` folder keeps them together.
5. Add `ensure` and the resource's name to your `server.cfg`, after the lines that start Qbox and ox.
6. Restart the server and look at the console. Each resource prints a line when it is ready.

Start `dps_lib` first. Other DPS resources use it.

A one-paste install (a txAdmin recipe) is planned. It is not ready yet.

## Settings that matter on Enhanced

These cost us time, so we list them here.

- Do **not** put `sv_enforceGameBuild 1` in `server.cfg`. On Enhanced it means "base game with no
  DLC", and player characters become invisible.
- If you add custom cars or other `.yft` models, add this line to `server.cfg`, or players can
  crash: `increase_pool_size "FragmentStore" 2000`
- Models and textures made for the old FiveM must be converted with Cfx's
  [Alchemist](https://docs.fivem.net/docs/alchemist/) tool before Enhanced can use them.
- Voice: Enhanced replaced Mumble. Add the line `voice_internal` to `server.cfg` before any voice
  resource.

## Guides

- [Add a script](docs/add-a-script.md)
- [Change the look](docs/change-the-look.md)

## Contributing

Pull requests are welcome, on the repository of the resource you are changing. Read the
[contributing guide](https://github.com/DPS-Enhanced/.github/blob/main/CONTRIBUTING.md) first.

## Thanks

[Qbox](https://github.com/Qbox-project) for the framework and the resources ours are ported from,
[Overextended](https://github.com/overextended) for the ox libraries, and
[Cfx.re](https://cfx.re) for FiveM and Alchemist.

## Licence

[GNU General Public License v3.0](LICENSE). You can use, change, rename and share everything here.
If you share a changed version, share its source code under the same licence.
