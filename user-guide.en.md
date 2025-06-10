# iDryer Unit User Manual

## ⚠️ Warning: High-Voltage Equipment ⚠️

Before starting, please review all safety precautions!

iDryer Unit includes components that operate on high voltage (220V) and open heating elements. Incorrect wiring or usage may result in electric shock, fire, or damage to the device.

## Preparation Before Assembly

Before assembling, perform the following steps:

* Make sure all components are present.
* Check the fit of all parts, especially moving components.
* Ensure all mechanical parts move smoothly.

## Pre-Assembly System Test

We recommend assembling and testing the system **on the table**, outside the enclosure:

* Connect all components.
* Verify the heater, fan, damper servo, and temperature sensors are functioning.
* Connect the system to **Klipper** and confirm macro operation.

Once testing is successful, install components into the enclosure. Shorten sensor and power wires to the minimum required length.

---

## Installing Required Files

Copy the following configuration files to your Klipper config directory:

* `rp2040_pin_aliases.cfg`
* `iDryer.cfg`
* Other relevant config files

### Configuration Files

!!! success "📁 Configuration Files"

   [printer](printer.cfg) |
   [iDryer](iDryer.cfg) |
   [alias](rp2040_pin_aliases.cfg) |
   [U1](U1.cfg) |
   [U2](U2.cfg) |
   [U3](U3.cfg) |
   [U4](U4.cfg) |

By default, U1 is connected. You can connect more modules (U2, U3, U4) by including additional config files:

```ini
[include U1.cfg]
[include U2.cfg]
[include U3.cfg]
[include U4.cfg]
```

This expands the system to control multiple dryer units. iDryer can be used either as a separate Klipper instance (e.g., on a dedicated Raspberry Pi) or as a second MCU connected to the main printer board in a single Klipper instance:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_DE63581213745233-if00
```

## Using a Second MCU in Klipper

If your device is connected as a second MCU (e.g., an extra iDryer Unit board), keep in mind:

* The second MCU has its own name in the config (e.g., `iDryer`).
* Pin names must be prefixed with the MCU name and a colon.

### Example

If used as primary MCU:

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
sensor_pin: T_U1
```

If used as second MCU:

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: iDryer:H_U1
sensor_pin: iDryer:T_U1
```

**Important:** Add the `iDryer:` prefix to all pins from the second MCU.

### Where to Add MCU Prefix

Ensure the prefix is used in all sections that reference second MCU pins:

* `[heater_generic]`
* `[temperature_sensor]`
* `[output_pin]`
* `[fan]`
* `[gpio]`

### How to Find the MCU Name

The name is defined in the `[mcu]` section:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_iDryer_Unit123456-if00
```

Use this name as prefix for all relevant pins.

### Shortcut Rule

If a pin belongs to a second MCU, use `MCUName:PinName` format.

## Hardware Setup

### Heater Setup

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
# If iDryer is a second MCU use:
# heater_pin: iDryer:H_U1
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32
sensor_pin: T_U1
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
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
#pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Temperature and Humidity Sensor Setup

You can use any Klipper-supported temp/humidity sensor. The example uses **SHT3X** over I2C. U1/U2 share one I2C bus, U3/U4 share another. Sensor addresses must differ on each bus:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68
```

**Note:** Check Klipper docs if using a different sensor.

## Final System Setup

### PID Calibration

Before use, calibrate the **PID heater regulator**:

* **Suggested drying temp**: **90°C**
* Default PID values are in `iDryer.cfg`, but **autotune** is advised for your system.

**To calibrate:**

1. Close dryer lid.
2. In Klipper console, run:

   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Wait for it to finish.
4. Copy the new **Kp, Ki, Kd** into `iDryer.cfg`:

```ini
[heater_generic iDryer_U1_Heater]
...
pid_Kp=29.625
pid_Ki=0.945
pid_Kd=232.186
```

### Setting `variable_delta_high`

Controls temp difference between heater and chamber:

* **Initial value:** 15°C
* Steps:

  1. Set `variable_delta_high=15`
  2. Run `PA_U1` macro
  3. Wait for heater to stabilize
  4. Measure chamber temp:

     * If \~90°C → keep value
     * If lower → increase delta

**Test** for 30 minutes and check every 30-60 mins.

**If heater touches plastic**, reduce `variable_delta_high`, reprint parts, or modify mount.

**Turn off heating:** `OFF_U1`

### Damper Servo Setup

Controls air ventilation in chamber.

#### Servo Basics

* Uses **PWM** signal
* Different servos = different responses
* Must tune individually

#### Setting Servo Range

1. **Don’t mount damper yet**
2. Test min/max angles:

   ```
   SET_SERVO SERVO=srv_U1 ANGLE=0
   SET_SERVO SERVO=srv_U1 ANGLE=90
   ```
3. Adjust if it hits enclosure

#### In Config:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

Set angle variables:

```ini
[gcode_macro DRY_U1]
variable_servo_open_angle: 40
variable_servo_closed_angle: 94
variable_servo_open_time: 10
variable_servo_closed_time: 300
```

### Power Correction for Servo

If multiple servos cause issues:

1. **Resistor to limit current**

   * Add 4-10 Ohm resistor in servo VCC line
   * Present on rev3 boards, value may vary

2. **Active USB Hub**

   * Use powered hub to offload host

## Additional Tips

* Monitor temp/humidity via Klipper.
* Check hardware regularly.
* Adjust heater/damper mounts as needed.

## System Macros

### G-code Macros

```ini
[gcode_macro OFF_U1]
gcode:
    UPDATE_DELAYED_GCODE ID=_UPDATE_U1 DURATION=0
    UPDATE_DELAYED_GCODE ID=_TOGGLE_SERVO_U1 DURATION=0
    SET_HEATER_TEMPERATURE HEATER=iDryer_U1_Heater TARGET=0


[gcode_macro PLA_U1]
variable_unit_temp: 55
variable_unit_duration: 180
gcode:
    DRY_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}


[gcode_macro PETG_U1]
variable_unit_temp: 65
variable_unit_duration: 240
gcode:
    DRY_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}


[gcode_macro TPU_U1]
variable_unit_temp: 60
variable_unit_duration: 300
gcode:
    DRY_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}


[gcode_macro ABS_U1]
variable_unit_temp: 80
variable_unit_duration: 240
gcode:
    DRY_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}


[gcode_macro PA_U1]
variable_unit_temp: 90
variable_unit_duration: 240
gcode:
    DRY_U1 UNIT_TEMPERATURE={unit_temp} HUMIDITY=10 TIME={unit_duration}
```


### Run Example

```gcode
   ABS_U1     ; For ABS
   PA_U1      ; For Nylon
   PC_U1      ; For PC
```

### Use Example

```gcode
   DRY_UNIT1 UNIT_TEMPERATURE=60
```

```gcode
   iDryer_OFF
```

### Manual Commands

```gcode
   OFF_U1
   ABS_U1
   PLA_U1
   SET_SERVO SERVO=srv_U1 ANGLE=90
```

---

## Conclusion

Proper iDryer Unit tuning (PID, delta, servo) ensures stable, efficient filament drying.

## Alternative High-End Algorithm

**By @Xatang**

Advanced auto-drying and storage control with graphs and tunable variables.

![xatang](imgweb/xatang.jpg)

[Visit GitHub project](https://github.com/xatang/PyUnit)

---

## General Safety Guidelines

* Unplug before service
* Avoid contact with live parts
* Inspect wiring before use
* Don’t use with damaged case/wires
* Never leave powered on unattended
* Ensure proper grounding
* If smoke/smell/heat → unplug
* Avoid moisture/condensation

### Additional Electrical Safety

* Use circuit breaker or overload relay
* Ensure all insulation is intact

**Violation of these rules can lead to injury or fire. If unsure, consult an electrician.**

---

## Need Help?

### Support

[![Telegram](https://img.shields.io/badge/Telegram-Join%20Group-blue?style=for-the-badge&logo=telegram)](https://t.me/iDryer)
[![YouTube](https://img.shields.io/badge/YouTube-Watch%20video-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/@iDryerProject)
[![GitHub](https://img.shields.io/badge/GitHub-View%20Project-blue?style=for-the-badge&logo=github)](https://github.com/pavluchenkor/iDryer-Unit)
[![Discord](https://img.shields.io/discord/123456789012345678?label=Discord&logo=discord&logoColor=white&color=5865F2&style=for-the-badge)](https://discord.gg/1332280943465201724)
