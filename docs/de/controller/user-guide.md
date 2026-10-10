# Klipper: Konfiguration

Diese Seite beschreibt die Installation von Konfigurationsdateien und die Einrichtung von iDryer Unit in der Klipper-Umgebung. Die Controller-Firmware muss vorher installiert werden – siehe Abschnitt „Firmware".

---

## Konfiguration: mcu oder second_mcu

iDryer Unit verbindet sich mit Klipper auf zwei Arten:

=== "mcu (separater Host)"

    iDryer Unit funktioniert als primäres MCU auf einem separaten Host (z. B. Raspberry Pi nur für den Trockner). Konfigurationsabschnitt:

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (gemeinsam mit Drucker)"

    iDryer Unit verbindet sich mit dem Drucker-Host als zweites MCU in einer Klipper-Instanz. Konfigurationsabschnitt:

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    In diesem Fall wird allen Pins das Präfix `iDryer:` hinzugefügt, z. B. `iDryer:H_U1`.

---

## Installation von Konfigurationsdateien

### 1. Mit SSH zum Host verbinden

```bash
ssh user_name@printer_address
```

### 2. Zum Konfigurationsverzeichnis navigieren

```bash
cd ~/printer_data/config/
```

!!! note ""
    Der Pfad kann unterschiedlich sein: `~/klipper_config/` oder `~/printer_data/config/` je nach Installationsversion. Überprüfen Sie, dass sich die Datei `printer.cfg` im Verzeichnis befindet.

### 3. Installationsskript laden und ausführen

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

Das Skript erstellt ein Verzeichnis mit den erforderlichen Konfigurationsdateien.

### Manuelle Installation von Konfigurationsdateien

Wenn die Installation über das Skript nicht möglich ist, laden Sie das Projektarchiv von GitHub herunter und übertragen Sie die erforderlichen Konfigurationsdateien über die Fluidd- oder Mainsail-Oberfläche.

[Projektarchiv von GitHub herunterladen](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Konfiguration in printer.cfg einbinden

Fügen Sie eine Zeile am Anfang der Datei `printer.cfg` hinzu:

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Serielle ID in iDryer.cfg angeben

Rufen Sie die Controller-ID ab:

```bash
ls /dev/serial/by-id/*
```

Ersetzen Sie in der Datei `iDryer.cfg` in der Sektion `[mcu iDryer]` den Platzhalter durch die abgerufene ID:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Verbindung zusätzlicher Module (U2–U4)

Standardmäßig ist Modul U1 verbunden. Heben Sie die Kommentierung erforderlicher Zeilen in `iDryer.cfg` auf:

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Hardware-Einrichtung

### Heizelement

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

### Lüfter

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# bei Verwendung von second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Temperatur- und Feuchtigkeitssensor

Das Beispiel verwendet SHT3X auf dem I2C-Bus:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 oder 69
```

!!! note ""
    Sensoren U1 und U2 sind an einem I2C-Bus angeschlossen, Sensoren U3 und U4 an einem anderen. Sensoradressen auf einem Bus müssen unterschiedlich sein: eine auf `68`, die andere auf `69`. Überprüfen Sie beim Verwenden eines anderen Sensors die [Klipper-Dokumentation](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## PID-Kalibrierung

Führen Sie die Kalibrierung bei geschlossenem Trocknerbauch durch:

1. Öffnen Sie die Klipper-Konsole.
2. Führen Sie den Befehl aus:
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Warten Sie auf Abschluss.
4. Notieren Sie die erhaltenen Koeffizienten in `iDryer.cfg`.

---

## Konfiguration des Servoantriebs für die Klappe

### 1. Bestimmung der Extrempositionen

Der Servoanrieb wird durch ein PWM-Signal gesteuert. Verschiedene Servomodelle reagieren unterschiedlich auf die gleichen Werte – die Kalibrierung ist immer individuell.

**Befestigen Sie die Klappe nicht am Gehäuse** in dieser Phase – bestimmen Sie erst den Betriebsbereich.

Überprüfen Sie die Extrempositionen mit Befehlen in der Klipper-Konsole:

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Wenn der Servoanrieb gegen das Gehäuse stößt – passen Sie den Bereich an.

### 2. Winkel in der Konfiguration speichern

Überprüfen Sie den Servoabschnitt in `iDryer.cfg`:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

In der Datei `iDryer.cfg` im Makro `DRY_U1` legen Sie die Winkel fest:

```ini
variable_servo_open_angle: 40    # Grad der offenen Position
variable_servo_closed_angle: 94  # Grad der geschlossenen Position
```

### 3. Stromversorgungskorrektur des Servoantriebs

Bei Verwendung mehrerer Servoanriebe sind Ausfälle möglich, da die USB-Port-Last des Hosts überschritten wird.

**Option 1 – Widerstand in der Stromversorgung des Servos:**

Installieren Sie einen Widerstand von 4–10 Ohm in der Stromversorgung des Servoantriebs. Auf Revision-3-Platinen sind Widerstände bereits gelötet, jedoch wird der genaue Widerstandswert individuell ausgewählt.

**Option 2 – Aktiver USB-Hub:**

Verbinden Sie den Controller über einen USB-Hub mit separater Stromversorgung – dies verhindert eine Überbelastung des Host-Ports.

!!! note ""
    Kommunikationsstabilitätsprobleme (Ausfälle, MCU-Neustarts) können durch elektromagnetische Störungen von Stromkabeln oder Lüfter verursacht werden. Lösungen – Ferritkern auf dem USB-Kabel und RC-Snubber parallel zum Lüfter. Siehe Abschnitt „Fehlerbehebung".

---

## Konfiguration von delta_high

`variable_delta_high` verwaltet die Differenz zwischen der Heiztemperatur und der angestrebten Lufttemperatur.

Kalibrierverfahren:

1. Stellen Sie den Startwert `variable_delta_high: 15` ein.
2. Starten Sie das Heizen mit dem Makro `PA_U1`.
3. Warten Sie, bis ein Plateau erreicht wird.
4. Überprüfen Sie die Temperatur in der Kammer:
   - Wenn in der Kammer 90 °C – der Wert ist geeignet.
   - Wenn niedriger – erhöhen Sie `variable_delta_high`.
5. Laufen lassen 30 Minuten, dann alle 30–60 Minuten überprüfen.

!!! warning ""
    Wenn das Heizelement am Kunststoffgehäuse klebt – der Kunststoff hält die Temperatur nicht aus. Senken Sie `variable_delta_high`, drucken Sie das Gehäuse aus ABS oder ABS-CF neu, oder ändern Sie die Befestigungsmethode des Heizelements.

---

## G-Code-Makros

Verwenden Sie vorkonfigurierte Makros, um die Trocknung nach Materialtyp zu steuern:

| Makro | Temperatur | Zeit |
|---|---|---|
| `PLA_U1` | 55 °C | 180 min |
| `PETG_U1` | 65 °C | 240 min |
| `ABS_U1` | 80 °C | 240 min |
| `PA_U1` | 90 °C | 240 min |
| `TPU_U1` | 60 °C | 300 min |
| `OFF_U1` | aus | — |

Benutzerdefinierten Modus starten:

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Klappe manuell öffnen/schließen:

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; öffnen
SET_SERVO SERVO=srv_U1 ANGLE=0   ; schließen
```

---

## Alternativer Steuerbetriebsalgorithmus – PyUnit

Projekt von einem Community-Mitglied [@Xatang](https://github.com/xatang). Automatische Wartung von Trocknungs- und Lagerbedingungen mit konfigurierbaren Koeffizienten und aussagekräftigen Diagrammen.

![PyUnit](../../img/xatang.jpg)

→ [PyUnit-Repository auf GitHub](https://github.com/xatang/PyUnit)
