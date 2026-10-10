# Klipper : Installation du firmware

Cette page décrit l'installation du firmware Klipper sur le contrôleur iDryer Unit (MCU sur RP2040).

L'installation du firmware se fait en deux étapes :

1. Installation du bootloader **Katapult** — permet de reprogrammer Klipper via USB sans entrer en mode BOOT.
2. Installation de **Klipper** via Katapult.

---

## Prérequis

- Hôte avec Klipper installé (Raspberry Pi ou équivalent).
- Câble USB pour le transfert de données.
- Accès SSH au terminal de l'hôte.

---

## Partie 1 : Installation de Katapult

### 1. Préparation de l'environnement

Assurez-vous que le système est à jour et installez les dépendances :

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Téléchargement de Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Configuration de la compilation

```bash
cd katapult
make menuconfig
```

Sélectionnez les paramètres conformément à la capture d'écran :

![Katapult menuconfig](../../img/011.png)

!!! danger "Important"
    Assurez-vous que la configuration est correctement choisie. La réécriture du bootloader avec une compilation incorrecte rendra l'appareil infonctionnel – une programmation est requise pour la récupération.

### 4. Compilation

```bash
make
```

### 5. Placer le contrôleur en mode BOOT

Effectuez l'une des deux procédures suivantes :

- Maintenez `BOOT` enfoncé, connectez l'USB, relâchez `BOOT` (USB déconnecté).
- Maintenez `BOOT` enfoncé, appuyez brièvement sur `RESET`, relâchez `BOOT`.

### 6. Déterminer l'ID USB du contrôleur

```bash
lsusb
```

La sortie affichera une ligne du type :

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Programmer Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Partie 2 : Installation de Klipper

### 8. Configuration de la compilation Klipper

```bash
cd ~/klipper/
make clean
make menuconfig
```

Sélectionnez les paramètres conformément à la capture d'écran :

![Klipper menuconfig](../../img/016.png)

### 9. Compiler Klipper

```bash
make
```

### 10. Installer la bibliothèque Python

```bash
pip3 install pyserial
```

### 11. Déterminer l'ID série

Reconnectez l'USB ou appuyez sur `RESET`, attendez l'apparition de l'appareil :

```bash
ls /dev/serial/by-id/*
```

Résultat attendu :

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Programmer Klipper via Katapult

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Vérifier le résultat

```bash
ls /dev/serial/by-id/*
```

Si la programmation a réussi, l'ID de l'appareil contiendra `Klipper` :

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Étape suivante

Installation des fichiers de configuration iDryer – section « Configuration ».
