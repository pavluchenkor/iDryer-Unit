<div align="center">

<img src="docs/img/iDryer_logo_small.png" width="220" alt="iDryer">

# iDryer Unit

**A modular filament dryer you print and build yourself. Up to four chambers, up to 110 °C.**

[![Documentation](https://img.shields.io/badge/docs-idryer.org-e7352c)](https://docs.idryer.org/en/projects/idryer/unit/) [![Telegram](https://img.shields.io/badge/Telegram-iDryer-2ca5e0)](https://t.me/iDryer) [![Discord](https://img.shields.io/badge/Discord-join-5865f2)](https://discord.gg/jGce5eeHHz) [![License](https://img.shields.io/badge/license-GPL--3.0--or--later-blue)](LICENSE)

<img src="docs/img/iDryer.png" width="420" alt="iDryer Unit">

</div>

---
## What it is

A filament dryer built from off-the-shelf parts in a printed enclosure. One chamber or four, one spool per chamber or two.

Every part it is made of can be bought in a regular shop and replaced when needed: fan, PTC heater, temperature and humidity sensor, servo, thermal cutoff. There are no proprietary spares here.

<div align="center">

<img src="docs/img/iDryerWithSpool.png" width="520" alt="iDryer Unit with a spool">

</div>

## What problem it solves

Engineering filaments pick up moisture from the air, and a part printed from wet material comes out worse than it should: bubbles, weak layers, shrinkage you cannot predict. A consumer dryer applies heat, but gives you neither control nor repeatability, and it handles one spool.

iDryer Unit dries to a defined program, shows you what is happening inside, and runs up to four chambers at once. Each with its own material and its own settings.

## Who it is for

This project is for people who want a tool, not a heated box, and who are ready to build it themselves.

Off-the-shelf dryers are closed. The heater dies and you hunt for a proprietary part; you dislike the control logic and you live with it. Here it is the opposite: schematics, firmware and documentation are open, the enclosure prints on any printer, and any component swaps for an equivalent from most marketplaces.

## Two firmware options

You choose the scenario after assembly. It determines both the firmware and how you control the dryer.

### Klipper

<div align="center">

<img src="docs/img/klipper222252.jpg" width="520" alt="iDryer Unit in the Klipper interface">

</div>

The controller connects to the printer host and runs as `[mcu]` or `[second_mcu]`. You control it straight from Fluidd or Mainsail, with temperature and humidity on the same screen as the print. G-code macros, Telegram bot notifications and an addressable LED strip for mode indication are available.

Use this if Klipper is already running for you and you want everything in one interface.

→ [Klipper firmware installation](https://docs.idryer.org/en/projects/idryer/unit/controller/firmware/)

### Standalone

The controller runs on its own, with its own firmware. You control it through the [portal](https://portal.idryer.org/) and the mobile app, or locally through the screen. This mode also adds scales, RFID and profile handling.

Use this if the dryer sits away from the printer or you need remote control.

→ [iDryer Controller V2](https://github.com/pavluchenkor/iDryerControllerV2)

## Portal and app

<div align="center">

<img src="docs/img/portal1.png" width="420" alt="Portal: device overview"> <img src="docs/img/portal2.png" width="420" alt="Portal: spool tracking">

</div>

<div align="center">

<img src="docs/img/app-01-home.png" width="230" alt="App: home screen"> <img src="docs/img/app-02-device.png" width="230" alt="App: device card"> <img src="docs/img/app-03-session.png" width="230" alt="App: session report">

</div>

In Standalone mode every drying run is recorded: how long it ran, how far the humidity dropped, how much water was removed, how steadily the temperature held.

- [iDryer on the App Store](https://apps.apple.com/app/idryer/id6760609044)
- [iDryer on Google Play](https://play.google.com/store/apps/details?id=org.idryer.mobile)

## How the system is built

A single **MCU** block controls everything. Up to three **EXT** blocks connect to it over RJ45, without a microcontroller of their own.

```
              ┌— RJ45 — [EXT U2]
[MCU] ————————┼— RJ45 — [EXT U3]
              └— RJ45 — [EXT U4]
```

Each block is an independent chamber with its own sensor, heater, fan and damper.

## Humidity control

<div align="center">

<img src="docs/img/IMG_2168.jpg" width="400" alt="Damper"> <img src="docs/img/IMG_2170.jpg" width="400" alt="Damper mechanism">

</div>

Each chamber has a servo-driven damper. It opens to release moisture-laden air and closes to hold heat. The sensor tracks temperature and humidity inside continuously, and the firmware adjusts the damper and the heater to what is actually happening in the chamber.

## Specifications

| Parameter | Value |
|---|---|
| Drying temperature | up to 90 °C, up to 110 °C with a heat-resistant enclosure |
| Modes | drying, storage, profiles |
| Number of chambers | 1–4: MCU plus up to three EXT |
| Module interconnect | RJ45 patch cords |
| Spools | 1 or 2 per chamber, up to 85 mm wide and 200 mm in diameter |
| Enclosure | printed, ABS / ABS-CF / PC / HTPLA |
| Heater | PTC, fully electrically isolated |
| Sensor | SHT3X or any sensor supported by the firmware |
| Thermal cutoff | KSD9700, 130 °C |
| Overcurrent protection | fuse |

## Safety

The device runs on 110–230 V mains and heats for hours, so protection is built into both the hardware and the firmware.

**KSD9700** physically breaks the heater circuit on overheating, regardless of what the firmware thinks. The **fuse** clears fault currents. The **PTC heater** is built so that its body is not live. The firmware monitors temperature and sensor presence and cuts the heat on error.

> **Mains voltage inside.** Disconnect power before any electrical work. This is an electric heating appliance. Never leave it running unattended.

→ [Safety section](https://docs.idryer.org/en/projects/idryer/unit/unit/safety/)

## What you need (BOM)

Per chamber: 100 W PTC heater, blower fan, damper servo, SHT31 sensor, KSD9700 thermal cutoff, OLED screen with an encoder, LED strip, fasteners and wiring.

The full list with photos, quantities and ordering links is in the [bill of materials](https://docs.idryer.org/en/projects/idryer/unit/unit/bom/).

Printable models are in the [CAD section](https://docs.idryer.org/en/projects/idryer/unit/unit/cad/).

### Controller

Ready-made boards: **MCU** is the main board, with the microcontroller and three RJ45 connectors, and **EXT** is one board per additional chamber, without a microcontroller of its own.

You can also build the controller yourself. The documentation covers the RP2040 and connector pinouts, a breadboard prototype project, and a variant using an old printer board with solid-state relays.

→ [MCU and EXT boards](https://docs.idryer.org/en/projects/idryer/unit/controller/board/) · [DIY build](https://docs.idryer.org/en/projects/idryer/unit/controller/diy/)

## Difficulty and cost

| | |
|---|---|
| Soldering | required |
| 3D printing | enclosure and mechanics, ABS or another heat-resistant filament |
| **Hazardous voltage** | **yes, 110–230 V** |
| Skills | assembly by instructions, working with mains voltage |
| Time | one evening to assemble a single chamber |

## Quick start

1. **Choose the scenario**: Klipper or Standalone. It determines the firmware.
2. **Order the parts** from the [bill of materials](https://docs.idryer.org/en/projects/idryer/unit/unit/bom/).
3. **Print the enclosure** using the [models](https://docs.idryer.org/en/projects/idryer/unit/unit/cad/).
4. **Assemble it** following the [instructions](https://docs.idryer.org/en/projects/idryer/unit/unit/assembly/).
5. **Flash and configure**: [Klipper](https://docs.idryer.org/en/projects/idryer/unit/controller/firmware/) or Standalone via [install.idryer.org](https://install.idryer.org/).

## Where it fits in the ecosystem

| Layer | What it does | Repository |
|---|---|---|
| Dryer | Enclosure, mechanics, schematics: **this repository** | iDryer-Unit |
| Controller | Standalone firmware | [iDryerControllerV2](https://github.com/pavluchenkor/iDryerControllerV2) |
| Connectivity | Wi-Fi, portal, app | [iDryer Link](https://github.com/pavluchenkor/iDryer-Link) |
| Connectivity with a screen | The same plus a touch display | [iDryer Touch](https://github.com/pavluchenkor/idryer-touch) |
| Cloud | Portal, app, integrations | [portal.idryer.org](https://portal.idryer.org/) |

## Status

The project is released. Enclosures for one and two spools, both firmware options in service: Klipper and Standalone.

## What is in this repository

| Path | What it is |
|---|---|
| `CAD/` | Enclosure and mechanics models for printing |
| `iDryer_mcu/` | Firmware for the main block |
| `iDryer_second_mcu/` | Firmware for running as a second MCU in Klipper |
| `User-mods/` | Community modifications |

## License

Code, CAD models, drawings and mechanics: [GNU GPL v3.0 or later](LICENSE), [NOTICE](NOTICE).

PCBs and schematics are not published.

The iDryer name is not covered by the license: [TRADEMARKS.md](https://github.com/pavluchenkor/idryer-core/blob/main/TRADEMARKS.md).

## Help

- [Telegram](https://t.me/iDryer)
- [Discord](https://discord.gg/jGce5eeHHz)
- [Documentation](https://docs.idryer.org/en/projects/idryer/unit/)

Guides and teardowns on the channel: [YouTube](https://www.youtube.com/@iDryerProject) · [Rutube](https://rutube.ru/channel/34401569/)

## Contributing

Built your own version, improved the enclosure, found an error in the instructions? Open an issue or send a pull request. Community modifications live in `User-mods/`.

## Next

[Look through the bill of materials](https://docs.idryer.org/en/projects/idryer/unit/unit/bom/): it shows what the build will cost you.
