# Řadič DIY

Oddíl pro ty, kteří si chtějí sestavit řadič sami – bez předem připravené desky MCU.

---

## Rozlož pinů RP2040

![Rozlož pinů RP2040](../../img/rp2040_pinout.png)

---

## Rozlož pinů konektorů RJ45

Tři konektory RJ45 (U6/U7/U8) pro připojení bloků EXT. Každý konektor přenáší: SRV (servo), T (teplotní senzor), FAN (ventilátor), H (topný prvek), SDA/SCL (I²C), +5 V, GND.

![Rozlož pinů RJ45](../../img/rj45_pinout.png)

---

## Prototypovací deska (EasyEDA)

Minimální rozpočet, ruční montáž na nepájivé desce. Funkční prototyp – není určen pro trvalý provoz.

→ [Projekt EasyEDA](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Deska tiskárny + SSR

Stará deska tiskárny jako MCU a polovodičová relé pro ovládání zátěže 110–230 V. Vyžaduje dostupné výstupy GPIO a kompatibilní firmware Klipper.
