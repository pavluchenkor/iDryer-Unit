# Contrôleur

Le système est construit sur deux types de cartes : une unité centrale MCU et des modules d'extension EXT.

## iDryer Unit MCU

Carte principale avec microcontrôleur. Gère l'ensemble du système : lit les capteurs, contrôle le chauffage, le ventilateur et l'actionneur de volet. La connexion à l'hôte se fait en USB-C. Trois connecteurs RJ45 pour raccorder les modules EXT.

![Carte MCU](../../img/MCU_PCB.png)

## iDryer Unit EXT

Carte d'extension sans microcontrôleur. Se connecte au MCU via câble de brassage RJ45 et est contrôlée directement par celui-ci. Un module EXT par bloc de séchage supplémentaire.

![Carte EXT](../../img/EXT_PCB.png)
