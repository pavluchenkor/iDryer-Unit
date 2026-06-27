# DIY-Steuerung

Ein Abschnitt für diejenigen, die den Regler selbst bauen möchten – ohne vorgefertigte MCU-Platine.

---

## RP2040-Pinbelegung

![RP2040-Pinbelegung](../../img/rp2040_pinout.png)

---

## RJ45-Steckerpin-Belegung

Drei RJ45-Stecker (U6/U7/U8) zum Anschließen von EXT-Blöcken. Jeder Stecker überträgt: SRV (Servo), T (Temperatursensor), FAN (Lüfter), H (Heizelement), SDA/SCL (I²C), +5 V, GND.

![RJ45-Steckerpin-Belegung](../../img/rj45_pinout.png)

---

## Prototypenleiterplatte (EasyEDA)

Minimales Budget, handmontiert auf einer Breadboard-Leiterplatte. Funktionsfähiger Prototyp – nicht für den Dauereinsatz vorgesehen.

→ [EasyEDA-Projekt](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Druckerplatine + SSR

Alte Druckerplatine als MCU und Halbleiterrelais zur Steuerung der Last 110–230 V. Erfordert verfügbare GPIO-Ausgänge und kompatible Klipper-Firmware.
