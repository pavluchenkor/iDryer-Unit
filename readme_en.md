# iDryer Unit - Plastic Drying System for 3D Printers
![iDryer Unit Master](img/IMG_E2204.jpg)

This project represents a plastic drying control system for 3D printers running on Klipper firmware.

## Project Features

- **Drying and Storage Mode**: Ability to dry plastic at temperatures up to 90°C and maintain optimal temperature and humidity for plastic storage.
- **Drying Efficiency**: By using a humidity sensor and a chamber ventilation system, optimal drying results are achieved in the shortest time.
- **Dryer Body**: The body is 3D-printed.
- **Klipper Integration**: All drying process information is displayed in the Klipper interface for easy monitoring and control.
- **Master-Slave Architecture**: One dryer is equipped with an MCU and acts as the master, while other dryers act as slaves.
- **Slave Connection**: Slaves are connected to the master using patch cords through RJ45-8P/8C ports for reliable communication.
- **Support for Up to Four Dryers**: Each dryer can handle one or two spools of plastic simultaneously.
- **Safety**: Klipper safety algorithms and the use of a KSD9700 thermal protector at 130°C for emergency prevention make the system safe for household use.

## Benefits of Use

- **Improved Print Quality**: Dry plastic ensures stable extrusion and high print quality.
- **Efficiency**: Simultaneous drying of multiple spools saves time and increases productivity.
- **Flexibility**: The system can be expanded or customized for specific needs.
- **Safety**: Hardware and software features ensure safe operation of the system.

## Technical Details

- **MCU**: Used for controlling the master dryer and coordinating the work of slaves.
- **KSD9700 thermal protector**: A bimetallic thermal protector at 130°C ensures safety in case of emergency by disconnecting the heater.
- **Temperature Mode**: Drying is carried out at temperatures up to 90°C, suitable for most types of plastic.
- **Connection Interfaces**: RJ45-8P/8C ports are used for connections between dryers, simplifying assembly and providing a reliable connection.

## Installation and Setup

1. **Hardware Assembly**: Assemble the master dryer with an MCU and the necessary slaves.
2. **Connection**: Connect the slaves to the master using patch cords through RJ45-8P/8C ports.
3. **Klipper Setup**: Integrate the drying system into the Klipper configuration.
4. **Testing**: Check the operation of the system and verify correct data display in the Klipper interface.

## Requirements

- 3D printer with Klipper firmware installed.
- MCU for the master dryer.
- KSD9700 thermal protector at 130°C for each dryer.
- RJ45-8P/8C patch cords and ports to connect slaves to the master.

---

# iDryer Configuration for Klipper

This repository contains configuration files for the iDryer plastic dryer, based on Klipper firmware and the iDryer Unit control board with the RP2040 microcontroller. The configuration is intended to automate the plastic drying process for 3D printers, including temperature and humidity control.

## Table of Contents

- [Requirements](#requirements)
- [Preparation](#preparation)
- [Firmware Installation on iDryer Unit](#firmware-installation-on-idryer-unit)
- [Klipper Configuration](#klipper-configuration)
  - [Connecting iDryer MCU](#connecting-idryer-mcu)
  - [Heater Setup](#heater-setup)
  - [Fan Setup](#fan-setup)
  - [Temperature and Humidity Sensors Setup](#temperature-and-humidity-sensors-setup)
  - [G-code Macros](#g-code-macros)
- [Usage](#usage)
- [Notes](#notes)

## Requirements

- **Hardware:**

  - iDryer Unit control board with RP2040 microcontroller
  - NTC 100K thermistor for temperature control (or any other sensor supported by Klipper firmware)
  - Heating element (preferably 220V, 100W)
  - Fan for air circulation in the dryer
  - Temperature and humidity sensor (e.g., SHT3X, or any other supported by Klipper)
  ![iDryer Unit Master](img/IMG_2683.jpg)
  ![iDryer Unit Master](img/IMG_2692.jpg)

- **Software:**

  - Klipper (latest version)
  - Configured 3D printer with Klipper firmware

## Preparation

1. **Hardware Assembly:**

   - Connect the heating element and fan to the iDryer Unit board.
   - Install the thermistor and SHT3X sensor (or any other supported temperature/humidity sensor) in the dryer and connect them to the appropriate pins on the board.

2. **Install Required Files:**

   - Copy `rp2040_pin_aliases.cfg`, `iDryer.cfg`, and other configuration files to the Klipper configuration directory.

## Firmware Installation on iDryer Unit

### 1. Firmware Preparation:

If the firmware for RP2040 is not yet installed:

- In the Klipper firmware configuration menu:
  - Select the **RP2040** architecture.
  - Leave other parameters as default.

### 2. Firmware Compilation:

Compile the firmware:

```bash
make
```

### 3. Installing Firmware on iDryer Unit:

- Connect the iDryer Unit board to your computer in programming mode (holding the BOOT button while connecting).
- Mount the device and upload the firmware:

```bash
sudo mount /dev/sda1 /mnt
sudo cp out/klipper.uf2 /mnt
sudo umount /mnt
```

## Klipper Configuration

### 1. Enabling iDryer Configuration:

Add a line to include the `iDryer.cfg` configuration file in your `printer.cfg` file:

```ini
[include iDryer.cfg]
```

### Connecting iDryer MCU

[Find the serial port of your microcontroller and specify it in the configuration file:](#https://www.klipper3d.org/Installation.html#building-and-flashing-the-micro-controller)

```
ls /dev/serial/by-id/*
```

```ini
[mcu]
serial: /dev/serial/by-id/usb-Klipper_rp2040_DE63581213745233-if00
```

### Heater Setup

```ini
[heater_generic iDryer_M_Heater]
heater_pin: H0
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32
sensor_pin: T0
control: pid
pwm_cycle_time: 0.3
min_temp: 0
max_temp: 120
pid_Kp=32.923
pid_Ki=5.628
pid_Kd=48.150
```

### Fan Setup

```ini
[heater_fan Master_Fan]
fan_speed: 1
pin: FAN0
heater: iDryer_M_Heater
heater_temp: 55
```

### Temperature and Humidity Sensors Setup

You can use any temperature and humidity sensor supported by Klipper. In the example, the **SHT3X** sensor is used, connected via the I2C interface:

```ini
[temperature_sensor iDryer_M_Air]
sensor_type: SHT3X
i2c_address: 68
i2c_software_sda_pin: gpio18
i2c_software_scl_pin: gpio19
```

**Note:** If you use a different temperature or humidity sensor, check the Klipper documentation for the appropriate configuration.

### G-code Macros

To control the drying process with the ability to set temperatures for different materials, use the following macros:

```ini
[gcode_macro iDryer_OFF]
gcode:
    SET_HEATER_TEMPERATURE HEATER=iDryer_M_Heater TARGET=0
    UPDATE_DELAYED_GCODE ID=_UPDATE_UNIT1_DATA DURATION=0
    UPDATE_DELAYED_GCODE ID=_TOGGLE_SERVO1 DURATION=0

[gcode_macro DRY_UNIT1]
gcode:
    {% set unit_temp = params.UNIT_TEMPERATURE|default(40)|int %}
    SET_GCODE_VARIABLE MACRO=DRY_MODE_U1 VARIABLE=temp VALUE={unit_temp}

[gcode_macro ABS_U1]
variable_unit_temp: 80
variable_unit_duration: 240
gcode:
    DRY_MODE_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}

[gcode_macro PA_U1]
variable_unit_temp: 90
variable_unit_duration: 240
gcode:
    DRY_MODE_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}

[gcode_macro PETG_U1]
variable_unit_temp: 65
variable_unit_duration: 240
gcode:
    DRY_MODE_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}

[gcode_macro PLA_U1]
variable_unit_temp: 55
variable_unit_duration: 240
gcode:
    DRY_MODE_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}
```

### Data Update Macro:

```ini
[delayed_gcode _UPDATE_UNIT1_DATA]
gcode:
    {% set unit_data = printer['gcode_macro DRY_MODE_U1'] %}
    {% set temperature = unit_data.temp %}
    {% set delta_high =  unit_data.delta_high %}
    
    { action_respond_info("Unit_1 T: %s H: %.2f%%" %(temperature, printer["sht3x iDryer_M_Air"].humidity)) }
    
    {% if printer['temperature_sensor iDryer_M_Air'].temperature|int > temperature|int %}
        {% set target_temp = 0|int %}
    {% elif printer['temperature_sensor iDryer_M_Air'].temperature|int == temperature|int %}
        {% set target_temp = printer['temperature_sensor iDryer_M_Air'].temperature|int %}
    {% elif printer['temperature_sensor iDryer_M_Air'].temperature|int < temperature|int %}
        {% set target_temp = temperature - printer['temperature_sensor iDryer_M_Air'].temperature + temperature + delta_high %}
        {% if target_temp > temperature + delta_high %}
            {% set target_temp = temperature|int + delta_high|int %}
        {% endif %}
    {% endif %}
    
    SET_HEATER_TEMPERATURE HEATER=iDryer_M_Heater TARGET={target_temp|int}
    UPDATE_DELAYED_GCODE ID=_UPDATE_UNIT1_DATA DURATION=1
```

### Temperature Setup Macros:

- For ABS plastic:

```gcode
ABS_U1
```

- For PLA plastic:

```gcode
PLA_U1
```

- For PETG plastic:

```gcode
PETG_U1
```

## Usage

- Setting the drying temperature:

```gcode
DRY_UNIT1 UNIT_TEMPERATURE=60
```

- Stopping the heater:

```gcode
iDryer_OFF  ; Turn off the dryer heater
```

## Feedback

If you have any questions or suggestions for improving the system, please create an issue in this repository or contact directly.

## Notes

- Ensure the correct connection of the temperature and humidity sensors (e.g., SHT3X or others).
- PID calibration may be required for optimal temperature control.
- Monitor temperature and humidity readings with macros for more accurate drying condition adjustments.
- The project is in the development stage.

***Warning: The use of heating elements and temperature control carries the risk of fire and equipment damage. Always follow manufacturer recommendations and observe safety precautions and electrical safety. Do not leave electrical devices unattended.***

