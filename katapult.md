#### Install Katapult:

```
git clone https://github.com/Arksine/katapult
```

#### Prepare Katapult Firmware:

```
cd katapult
make menuconfig
```

Select the following options.

*Micro-controller Architecture (Raspberry Pi RP2040/RP235x) --->*

 *Processor model (rp2040) --->*

 *Flash chip (GENERIC_03H with CLKDIV 4) --->*

 *Build Katapult deployment application (16KiB bootloader) --->*

 *Communication Interface (USBSERIAL) --->*

 *USB ids --->*

 *() GPIO pins to set on bootloader entry*

 *[*] Support bootloader entry on rapid double click of reset button*

 *[ ] Enable bootloader entry on button (or gpio) state*

 *[ ] Enable Status LED*

**Important:** Ensure your Katapult build configuration is correct before uploading the deployer. Overwriting your existing bootloader with an incorrectly configured build will brick your device and require a programmer to recover.

#### Build Katapult Firmware:

```
make
```

#### Connect Unit MCU in BOOT Mode:

Put your MCU into BOOT mode.

#### Find MCU ID:

```
lsusb
```

#### Flash MCU by ID:

```
make flash FLASH_DEVICE=2e8a:0003
```

---

#### Prepare Klipper Firmware:

```
cd ~/klipper/
make clean
make menuconfig
```

Select the following options.

*[*] Enable extra low-level configuration options*

*Micro-controller Architecture (Raspberry Pi RP2040/RP235x) --->*

 *Processor model (rp2040) --->*

 *Bootloader offset (16KiB bootloader) --->*

 *Communication Interface (USBSERIAL) --->*

 *USB ids --->*

 *() GPIO pins to set at micro-controller startup*

#### Build Klipper Firmware:

```
make
```

#### Get MCU Serial ID:

Reconnect the USB multiple times if necessary until the serial device appears.

```
ls /dev/serial/by-id/*
```

#### Install Required Python Library:

```
pip3 install pyserial
```

#### Flash Klipper Using Katapult:

```
cd ~/katapult/scripts
python3 flashtool.py -d <serial ID>
```