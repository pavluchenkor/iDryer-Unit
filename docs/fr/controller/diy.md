# Contrôleur DIY

Une section pour ceux qui souhaitent fabriquer le contrôleur eux-mêmes – sans carte MCU prête à l'emploi.

---

## Brochage RP2040

![Brochage RP2040](../../img/rp2040_pinout.png)

---

## Brochage des connecteurs RJ45

Trois connecteurs RJ45 (U6/U7/U8) pour connecter les blocs EXT. Chaque connecteur transmet : SRV (servomoteur), T (capteur de température), FAN (ventilateur), H (résistance chauffante), SDA/SCL (I²C), +5 V, GND.

![Brochage RJ45](../../img/rj45_pinout.png)

---

## Carte de prototypage (EasyEDA)

Budget minimal, assemblée manuellement sur une planche de prototypage. Prototype fonctionnel – non destiné à un fonctionnement permanent.

→ [Projet EasyEDA](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Carte d'imprimante + SSR

Ancienne carte d'imprimante comme MCU et relais à semiconducteur pour contrôler la charge 110–230 V. Nécessite des sorties GPIO disponibles et un micrologiciel Klipper compatible.
