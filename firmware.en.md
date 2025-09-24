# Firmware Installation

## Installing Katapult

Before starting the installation, ensure that the system is up-to-date and that the required packages are installed. Execute the following commands if an update or dependency installation is needed:

```
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial usbutils dfu-util
```

These commands will update the package list and install the tools necessary for compiling and flashing Katapult, including the ARM compiler, Python, and utilities for working with USB devices.

Download the Katapult source code from GitHub by executing the following command:

```
git clone https://github.com/Arksine/katapult
```

### Preparing the Katapult Firmware

```
cd katapult
make menuconfig
```

Choose the following options:

![Katapult](img/011.png)

**Important:** Before flashing the firmware, ensure the Katapult build configuration is correct. Flashing with an incorrect configuration may brick the device, requiring a hardware programmer to recover.

### Building the Katapult Firmware

```
make
```

### Entering BOOT Mode on the Unit Microcontroller

Put your microcontroller into BOOT mode: press and hold the BOOT button, briefly press RESET, then release BOOT. Alternatively, unplug USB, hold BOOT, plug in USB, then release BOOT.

### Identifying the Microcontroller ID

```
lsusb
```

You should see something like:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### Flashing the Microcontroller Using Its ID

```
make flash FLASH_DEVICE=2e8a:0003
```

---

## Installing Klipper Firmware

### Preparing the Klipper Firmware

```
cd ~/klipper/
make clean
make menuconfig
```

Choose the following options:

![Klipper settings](img/016.png)

### Building the Klipper Firmware

```
make
```

### Getting the Microcontroller's Serial ID

Reconnect the USB cable a few times, or press RESET if needed, until the device appears:

```
ls /dev/serial/by-id/*
```

You should see something like:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### Installing Required Python Library

```
pip3 install pyserial
```

### Flashing Klipper via Katapult

```
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

Run

```
ls /dev/serial/by-id/*
```

If successful, the ID will contain "Klipper":

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```
