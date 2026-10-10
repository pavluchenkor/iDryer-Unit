# Klipper: Firmware Installation

This page describes installing Klipper firmware on the iDryer Unit controller.

Flashing is done in two steps:

1. Install the **Katapult** bootloader — allows re-flashing Klipper via USB without entering BOOT mode.
2. Install **Klipper** via Katapult.

---

## Requirements

- Host with Klipper installed (Raspberry Pi or equivalent).
- Data transfer USB cable.
- SSH access to the host terminal.

---

## Part 1: Installing Katapult

### 1. Prepare the environment

Make sure the system is up to date and install dependencies:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Clone Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Build configuration

```bash
cd katapult
make menuconfig
```

Select parameters according to the screenshot:

![Katapult menuconfig](../../img/011.png)

!!! danger "Important"
    Make sure the configuration is correct. Overwriting the bootloader with an incorrect build will render the device non-functional — a programmer will be required for recovery.

### 4. Build

```bash
make
```

### 5. Put the controller into BOOT mode

Do one of the following:

- With USB disconnected, hold `BOOT`, connect USB, release `BOOT`.
- Hold `BOOT`, briefly press `RESET`, release `BOOT`.

### 6. Find the controller USB ID

```bash
lsusb
```

The output will contain a line like:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Flash Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Part 2: Installing Klipper

### 8. Configure Klipper build

```bash
cd ~/klipper/
make clean
make menuconfig
```

Select parameters according to the screenshot:

![Klipper menuconfig](../../img/016.png)

### 9. Build Klipper

```bash
make
```

### 10. Install the Python library

```bash
pip3 install pyserial
```

### 11. Find the serial ID

Reconnect USB or press `RESET`, wait for the device to appear:

```bash
ls /dev/serial/by-id/*
```

Expected output:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Flash Klipper via Katapult

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Verify the result

```bash
ls /dev/serial/by-id/*
```

On success, the device ID will contain `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Next step

Install iDryer configuration files → [User guide](user-guide.md)
