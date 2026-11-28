# dps_jobs

The DPS job list for Qbox: police, medical, fire and justice, with their ranks and pay.

## What it does

When the server starts, it gives its job list to `qbx_core`. Your `qbx_core` stays stock, so
updating `qbx_core` never wipes these jobs.

| Job name | Department | Ranks |
|---|---|---|
| `police` | Los Santos Police Department | 12 |
| `bcso` | Blaine County Sheriff's Office | 10 |
| `sasp` | San Andreas Highway Patrol | 10 |
| `fib` | Federal Investigation Bureau | 8 |
| `doc` | Department of Corrections | 9 |
| `dfw` | Department of Fish & Wildlife | 7 |
| `uscg` | Coast Guard | 8 |
| `natguard` | National Guard | 8 |
| `sams` | San Andreas Medical Services (ambulance) | 7 |
| `lsmc` | Los Santos Medical Center (hospital) | 6 |
| `lsfd` | Los Santos Fire Department | 9 |
| `judge` | Judge | 1 |
| `lawyer` | Law Firm | 2 |
| `da` | District Attorney's Office | 4 |

A job here with the same name as one in `qbx_core` replaces it. `police`, `judge` and `lawyer`
replace the stock ones.

## Install

1. Put this folder in `resources/[dps]/`.
2. `ensure dps_jobs` after `qbx_core` in `server.cfg`.
3. Look for this line in the console:

```
[dps_jobs] v0.1.0 ready: 14 jobs added to qbx_core
```

Needs `ox_lib` and `qbx_core`.

## Change it

Everything is in `data/jobs.lua`.

- **Change pay:** edit the `payment` number on a rank.
- **Rename a rank:** edit its `name`.
- **Add a rank:** add a line with the next number.
- **Add a job:** copy a whole block, give it a new lower-case name, and change the rest.

Restart the resource after a change.

## Give yourself a job

As an admin, in game: `/setjob <your id> police 4`
