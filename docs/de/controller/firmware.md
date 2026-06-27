# Klipper: Firmware-Installation

Auf dieser Seite wird die Installation der Klipper-Firmware auf den iDryer Unit-Controller (MCU auf RP2040) beschrieben.

Die Firmware-Installation erfolgt in zwei Schritten:

1. Installation des Bootloaders **Katapult** — ermöglicht die Neuprogrammierung von Klipper über USB ohne Eintritt in den BOOT-Modus.
2. Installation von **Klipper** über Katapult.

---

## Anforderungen

- Host mit installiertem Klipper (Raspberry Pi oder ähnlich).
- USB-Datenkabel.
- SSH-Zugriff auf das Host-Terminal.

---

## Teil 1: Katapult-Installation

### 1. Umgebung vorbereiten

Stellen Sie sicher, dass das System aktualisiert ist, und installieren Sie die Abhängigkeiten:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Katapult herunterladen

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Build-Konfiguration

```bash
cd katapult
make menuconfig
```

Wählen Sie die Parameter gemäß dem Screenshot:

![Katapult menuconfig](../../img/011.png)

!!! danger "Wichtig"
    Stellen Sie sicher, dass die Konfiguration korrekt gewählt ist. Das Überschreiben des Bootloaders mit einem fehlerhaften Build führt zur Funktionsunfähigkeit des Geräts – für die Wiederherstellung ist ein Programmierer erforderlich.

### 4. Kompilieren

```bash
make
```

### 5. Controller in den BOOT-Modus versetzen

Führen Sie eines der folgenden Verfahren durch:

- Halten Sie `BOOT` gedrückt, verbinden Sie USB, lassen Sie `BOOT` los (bei USB-Trennung).
- Halten Sie `BOOT` gedrückt, drücken Sie `RESET` kurz, lassen Sie `BOOT` los.

### 6. USB-ID des Controllers bestimmen

```bash
lsusb
```

In der Ausgabe wird eine Zeile wie diese angezeigt:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Katapult programmieren

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Teil 2: Klipper-Installation

### 8. Klipper Build-Konfiguration

```bash
cd ~/klipper/
make clean
make menuconfig
```

Wählen Sie die Parameter gemäß dem Screenshot:

![Klipper menuconfig](../../img/016.png)

### 9. Klipper kompilieren

```bash
make
```

### 10. Python-Bibliothek installieren

```bash
pip3 install pyserial
```

### 11. Serielle ID bestimmen

Verbinden Sie USB neu oder drücken Sie `RESET`, warten Sie auf das Gerät:

```bash
ls /dev/serial/by-id/*
```

Erwartetes Ergebnis:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Klipper über Katapult programmieren

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Ergebnis überprüfen

```bash
ls /dev/serial/by-id/*
```

Bei erfolgreicher Programmierung enthält die Geräte-ID `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Nächster Schritt

Installation der iDryer-Konfigurationsdateien – Abschnitt «Konfiguration».
