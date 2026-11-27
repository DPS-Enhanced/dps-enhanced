# dps_lib

The DPS look, and a few helpers Qbox does not have.

## What it is for

Every DPS resource should look the same and ask the same questions the same way. `dps_lib` holds
the parts they share, so each resource does not carry its own copy.

It is **not** a layer over Qbox. For players, money, jobs and notices, call `exports.qbx_core`
directly.

## What it does

| Call | Side | What you get |
|---|---|---|
| `exports.dps_lib:GetTheme()` | both | The DPS colours as a table |
| `exports.dps_lib:HasJob(source, wanted, minGrade, needDuty)` | server | `true` if the player holds the job, at that grade or above, and is on duty if you ask |
| `exports.dps_lib:HasJob(wanted, minGrade, needDuty)` | client | The same, for the local player |
| `exports.dps_lib:GetCitizenId(source)` | server | The citizen ID: the key to store against |
| `exports.dps_lib:GetFullName(source)` | server | `Firstname Lastname` of the loaded character |
| `web/dps.css` | web pages | The DPS colours and panel, row, input and button styles |

`wanted` can be one job name, a list, or a table of names and lowest grades:

```lua
exports.dps_lib:HasJob(source, 'police')                      -- any grade
exports.dps_lib:HasJob(source, 'police', 2)                   -- grade 2 or above
exports.dps_lib:HasJob(source, { 'police', 'sheriff' }, 0, true) -- either job, on duty
exports.dps_lib:HasJob(source, { police = 2, sheriff = 0 })   -- a lowest grade for each
```

## Requirements

- [qbx_core](https://github.com/Qbox-project/qbx_core)

## Install

It comes with the pack. `ensure [dps]` starts it. On start the server console prints:

```
[dps_lib] v0.1.0 ready, self-check 9/9
```

The self-check runs the job rule against sample data on your server. If it does not say 9/9, open
an issue and paste the line.

## Configuration

There is no config file. To change the colours, see
[Change the look](../../../docs/change-the-look.md).

## Recent changes

- **27 November 2026.** First version: theme, `HasJob`, `GetCitizenId`, `GetFullName`, shared style
  sheet. Starts clean on FiveM for GTAV Enhanced (Cfx Server build 177). Not yet used by another
  resource, and the style sheet has not been loaded from another resource's page yet.
