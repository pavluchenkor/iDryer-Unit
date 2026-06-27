# Klipper : Configuration

Cette page décrit l'installation des fichiers de configuration et la configuration de iDryer Unit dans l'environnement Klipper. Le micrologiciel du contrôleur doit être installé au préalable – voir la section « Firmware ».

---

## Configuration : mcu ou second_mcu

iDryer Unit se connecte à Klipper de deux façons :

=== "mcu (hôte séparé)"

    iDryer Unit fonctionne comme MCU principal sur un hôte séparé (par exemple, Raspberry Pi dédiée au sèche-filament). Section de configuration :

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (partagé avec l'imprimante)"

    iDryer Unit se connecte à l'hôte de l'imprimante en tant que second MCU dans une instance Klipper. Section de configuration :

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    Dans ce cas, tous les pins reçoivent le préfixe `iDryer:`, par exemple `iDryer:H_U1`.

---

## Installation des fichiers de configuration

### 1. Connexion à l'hôte par SSH

```bash
ssh user_name@printer_address
```

### 2. Navigation vers le répertoire de configuration

```bash
cd ~/printer_data/config/
```

!!! note ""
    Le chemin peut varier : `~/klipper_config/` ou `~/printer_data/config/` selon la version d'installation. Vérifiez que le fichier `printer.cfg` se trouve dans le répertoire.

### 3. Téléchargement et exécution du script d'installation

=== "mcu"

    ```bash
    wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_mcu.sh
    chmod +x download_iDryer_mcu.sh
    ./download_iDryer_mcu.sh
    ```

=== "second_mcu"

    ```bash
    wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_second_mcu.sh
    chmod +x download_iDryer_second_mcu.sh
    ./download_iDryer_second_mcu.sh
    ```

Le script crée un répertoire avec les fichiers de configuration nécessaires.

### Installation manuelle des fichiers de configuration

Si l'installation via script n'est pas possible, téléchargez l'archive du projet depuis GitHub et transférez les fichiers de configuration requis via l'interface Fluidd ou Mainsail.

[Télécharger l'archive du projet depuis GitHub](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Inclusion de la configuration dans printer.cfg

Ajoutez une ligne au début du fichier `printer.cfg` :

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Spécification de l'ID de série dans iDryer.cfg

Récupérez l'ID du contrôleur :

```bash
ls /dev/serial/by-id/*
```

Dans le fichier `iDryer.cfg`, dans la section `[mcu iDryer]`, remplacez l'espace réservé par l'ID obtenu :

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Connexion de modules supplémentaires (U2–U4)

Par défaut, le module U1 est connecté. Décommentez les lignes nécessaires dans `iDryer.cfg` :

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Configuration du matériel

### Élément chauffant

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32
sensor_pin: T_U1
control: pid
pwm_cycle_time: 0.3
min_temp: 0
max_temp: 120
pid_Kp: 32.923
pid_Ki: 5.628
pid_Kd: 48.150
```

### Ventilateur

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# lors de l'utilisation de second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Capteur de température et d'humidité

L'exemple utilise SHT3X sur le bus I2C :

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 ou 69
```

!!! note ""
    Les capteurs U1 et U2 sont connectés à un bus I2C, les capteurs U3 et U4 à un autre. Les adresses des capteurs sur un même bus doivent être différentes : l'une sur `68`, l'autre sur `69`. Lors de l'utilisation d'un capteur différent, consultez la [documentation Klipper](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## Étalonnage PID

Effectuez l'étalonnage avec le couvercle du sèche-filament fermé :

1. Ouvrez la console Klipper.
2. Exécutez la commande :
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Attendez la fin.
4. Enregistrez les coefficients obtenus dans `iDryer.cfg`.

---

## Configuration du servo-actionneur de l'obturateur

### 1. Détermination des positions extrêmes

Le servo-actionneur est contrôlé par un signal PWM. Différents modèles de servos réagissent différemment aux mêmes valeurs – l'étalonnage est toujours individuel.

**Ne fixez pas l'obturateur au boîtier** à ce stade – commencez par déterminer la plage de fonctionnement.

Vérifiez les positions extrêmes avec les commandes dans la console Klipper :

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Si le servo-actionneur est bloqué contre le boîtier – ajustez la plage.

### 2. Enregistrement des angles dans la configuration

Vérifiez la section servo dans `iDryer.cfg` :

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

Dans le fichier `iDryer.cfg`, dans la macro `DRY_U1`, définissez les angles :

```ini
variable_servo_open_angle: 40    # degrés de la position ouverte
variable_servo_closed_angle: 94  # degrés de la position fermée
```

### 3. Correction de l'alimentation du servo-actionneur

Lors de l'utilisation de plusieurs servos-actionneurs, des défaillances sont possibles en raison du dépassement de charge du port USB.

**Option 1 – Résistance dans l'alimentation du servo :**

Installez une résistance de 4–10 Ohms dans l'alimentation du servo-actionneur. Sur les cartes de révision 3, les résistances sont déjà soudées, mais la valeur de résistance exacte doit être sélectionnée individuellement.

**Option 2 – Hub USB actif :**

Connectez le contrôleur via un hub USB avec alimentation séparée – cela évite une surcharge du port hôte.

!!! note ""
    Les problèmes de stabilité de communication (coupures, redémarrages du MCU) peuvent être causés par des interférences électromagnétiques provenant des câbles d'alimentation ou du ventilateur. Solutions – ferrite sur le câble USB et snubber RC en parallèle avec le ventilateur. Voir la section « Dépannage ».

---

## Configuration de delta_high

`variable_delta_high` gère la différence entre la température du chauffage et la température d'air cible.

Procédure d'étalonnage :

1. Définissez la valeur initiale `variable_delta_high: 15`.
2. Démarrez le chauffage avec la macro `PA_U1`.
3. Attendez la stabilisation.
4. Vérifiez la température dans la chambre :
   - Si elle est à 90 °C dans la chambre – la valeur convient.
   - Si elle est inférieure – augmentez `variable_delta_high`.
5. Laissez fonctionner 30 minutes, puis vérifiez l'état toutes les 30–60 minutes.

!!! warning ""
    Si l'élément chauffant colle au boîtier en plastique – le plastique ne résiste pas à la température. Baissez `variable_delta_high`, réimprimez le boîtier en ABS ou ABS-CF, ou modifiez la méthode de fixation du chauffage.

---

## Macros G-Code

Utilisez des macros préconfigurées pour contrôler le séchage par type de matériau :

| Macro | Température | Temps |
|---|---|---|
| `PLA_U1` | 55 °C | 180 min |
| `PETG_U1` | 65 °C | 240 min |
| `ABS_U1` | 80 °C | 240 min |
| `PA_U1` | 90 °C | 240 min |
| `TPU_U1` | 60 °C | 300 min |
| `OFF_U1` | arrêt | — |

Lancement du mode personnalisé :

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Ouverture/fermeture manuelle de l'obturateur :

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; ouvrir
SET_SERVO SERVO=srv_U1 ANGLE=0   ; fermer
```

---

## Algorithme de contrôle alternatif – PyUnit

Projet d'un membre de la communauté [@Xatang](https://github.com/xatang). Maintien automatique des paramètres de séchage et de stockage avec coefficients configurables et graphiques informatifs.

![PyUnit](../../img/xatang.jpg)

→ [Dépôt PyUnit sur GitHub](https://github.com/xatang/PyUnit)
