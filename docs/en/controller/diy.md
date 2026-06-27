# DIY Controller Assembly

This section is for those who want to build the controller themselves — without a ready-made MCU board.

---

## RP2040 Pinout

![RP2040 Pinout](../../imgweb/rp2040_pinout.png)

---

## RJ45 Connector Pinout

Three RJ45 connectors (U6/U7/U8) for connecting EXT boards. Each connector carries: SRV (servo), T (temperature sensor), FAN (fan), H (heater), SDA/SCL (I²C), +5 V, GND.

![RJ45 Pinout](../../imgweb/rj45_pinout.png)

---

## Prototype Board (EasyEDA)

Minimal budget, assembled by hand on a breadboard. A functional prototype — not intended for permanent use.

→ [EasyEDA Project](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Printer Board + SSR

An old printer board as MCU and solid-state relays for controlling 110–230 V loads. Requires available GPIO outputs and compatible Klipper firmware.
