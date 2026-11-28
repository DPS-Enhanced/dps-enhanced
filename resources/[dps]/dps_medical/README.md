# dps_medical

Health, injuries, bleeding, last stand and death for Qbox servers on FiveM for GTAV Enhanced.

## Credit

This is a port of [qbx_medical](https://github.com/Qbox-project/qbx_medical) by the Qbox Project,
taken from its `main` branch at commit `b5649d2` (2026-09-30). Their code is the base of this
resource, and it is licensed GPL-3.0, as this resource is.

The illness, contagion, diagnostic tests and patient records come from
[dps-medical](https://github.com/DaemonAlex/dps-medical) by DelPerroSands.

## What it does today

Everything qbx_medical does: tracks health, armour, damage and injury effects, and handles
bleeding, last stand, death and respawn. Admin commands: `/revive`, `/aheal`, `/kill`.

## What is being added

- Illness: incubation, symptoms, contagion and immunity.
- Diagnostic tests that give a finding for the medic to read.
- A patient chart that follows the patient.
- A medical app for the tablet, and a small one for the phone.

## Install

1. Put this folder in `resources/[dps]/`.
2. Do not run `qbx_medical` as well. This resource answers to its name, so other scripts that
   call `exports.qbx_medical` need no change.
3. `ensure dps_medical` after `qbx_core`.

Needs `ox_lib` and `qbx_core`.
