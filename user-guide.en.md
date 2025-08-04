## **iDryer Unit User Setup Guide**

### ⚠ Warning! High-voltage Electrical Equipment ⚠

Carefully review all safety precautions before starting any work!

iDryer Unit contains components operating at high voltage (220V) and exposed heating elements. Incorrect wiring or operation may result in electric shock, fire, or device failure.

### **Preparation for Assembly**

Before assembling the unit, complete the following steps:

* Ensure all parts are present.
* Check the fit of all parts, especially those involving moving components.
* Confirm smooth and even movement of all mechanical parts.

### **Preliminary System Check**

It is recommended to first assemble the entire system **on a table**, without mounting it into the case, and perform a test:

* Connect all components.
* Test the operation of the heater, fan, damper servo, and temperature sensors.
* Connect the system to **Klipper** and verify the correct execution of macros.

After successful testing, proceed to install the components into the case.
During final assembly, shorten the sensor and power wires to the minimum required length.

---

## Using `mcu` and `second_mcu`

In the Klipper configuration, the `[mcu]` section defines the primary microcontroller responsible for managing the 3D printer. This usually includes stepper motors, heaters, and sensors. For devices like iDryer Unit connected directly to the control host without a printer mainboard, the primary microcontroller is specified in the `[mcu]` section.

The `[second_mcu]` section is used when an additional microcontroller is needed. This applies to setups involving external devices or expansion modules such as sensors, fans, or control boards interacting with Klipper via USB, CAN, or UART. In a configuration with iDryer Unit connected to the main 3D printer host, such a microcontroller is specified as `second_mcu`.

### Configuration Example

```
[mcu]
serial: /dev/ttyUSB0

[second_mcu my_board]
serial: /dev/ttyUSB1
```

---

## Installing Configuration Files

1. Connect to the host:

```bash
ssh user_name@printer_address
```

2. Navigate to the configuration directory:

```bash
cd ~/Printer_name/config/
```
This may be "klipper_config" or "Printer_data" depending on the version and configuration of the installation

!!! note "Important"

```
Ensure the file printer.cfg is present in this directory. This is the main Klipper configuration file.
```

\=== "mcu"

````
1 Download the setup script:

```bash
wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_mcu.sh
```

2 Grant execution permissions:

```bash
chmod +x download_iDryer_mcu.sh
```

3 Run the script:

```bash
./download_iDryer_mcu.sh
```
````

\=== "second mcu"

````
1 Download the setup script:

```bash
wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_second_mcu.sh
```

2 Grant execution permissions:

```bash
chmod +x download_iDryer_second_mcu.sh
```

3 Run the script:

```bash
./download_iDryer_second_mcu.sh
```
````

A directory containing all necessary configuration files will be created.

#### In the printer.cfg file

To integrate iDryer configuration files into the main Klipper printer configuration, add the appropriate `include` line at the top of the `printer.cfg` file. Refer to `example_printer.cfg` for guidance.

Your edited printer.cfg should resemble the following:

\=== "mcu"
`     ...     [include iDryer_mcu/iDryer.cfg]
    ...
    `
\=== "second mcu"

````
```
...
[include iDryer_second_mcu/iDryer.cfg]
...
```
````

### Configuration Files

If the method above is not feasible, manually download the appropriate configuration files for your setup and transfer them using the Fluid or Mainsail interface.

[Download project archive from Github](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

#### In the iDryer.cfg file

In the terminal

```
ls /dev/serial/by-id/*
```

output

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

In the iDryer.cfg file, replace the mcu serial with the obtained ID

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

By default, iDryer.cfg connects the first unit - U1, but you can connect additional units such as U2, U3, U4 by uncommenting the respective configuration files:

```ini
[include U1.cfg]
[include U2.cfg]
[include U3.cfg]
[include U4.cfg]
```

Thus, the system can be expanded to control multiple dryers. iDryer can be configured either as a standalone Klipper instance running on a Raspberry Pi for independent operation or as a second MCU connected to the printer's mainboard using the same Klipper instance.

## **iDryer Unit User Setup Guide**

### Equipment Configuration

### Heater Configuration

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
# if your iDryer is used as a second MCU use
# heater_pin: iDryer:H_U1
# and change everywhere!
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32 #Generic 3950
sensor_pin: T_U1
control: pid
pwm_cycle_time: 0.3
min_temp: 0
max_temp: 120
pid_Kp=32.923
pid_Ki=5.628
pid_Kd=48.150
```

### Fan Configuration

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
#pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Temperature and Humidity Sensor Configuration

You may use any temperature and humidity sensor supported by Klipper. This example uses the **SHT3X** sensor connected via the I2C interface. Sensors for dryers U1 and U2 are connected to one I2C bus, while sensors for dryers U3 and U4 are connected to a different bus. Sensor addresses on each bus must be distinct:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68 # 68 or 69
```

**Note:** If using a different temperature or humidity sensor, refer to the Klipper documentation for appropriate configuration.

## **Final System Setup**

### **PID Controller Calibration**

Before using the system, calibrate the heater's **PID controller**.

* **Recommended drying temperature**: **90°C**.
* The `iDryer.cfg` configuration already contains preliminary PID settings, but **autotuning** is recommended for your specific setup.

**Calibration Steps:**

With the dryer lid closed:

1. Open the Klipper console.
2. Run the command:

   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Wait for calibration to complete.
4. Record the resulting **Kp, Ki, Kd** values into the iDryer.cfg configuration.

Example heater section in `iDryer.cfg`:

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32
sensor_pin: T_U1
control: pid
pwm_cycle_time: 0.3
min_temp: 0
max_temp: 125
pid_Kp=29.625
pid_Ki=0.945
pid_Kd=232.186
```

---

### **Configuring "variable\_delta\_high" Parameter**

The `variable_delta_high` variable manages the temperature differential between the heater and the chamber.

* **Initial value for variable\_delta\_high:** 15°C
* To tune it correctly:

  1. Set `variable_delta_high=15`.
  2. Start heating using the `PA_U1` macro.
  3. Wait until the heater temperature stabilizes.
  4. Check the chamber temperature:

     * **If 90°C is reached** - keep the current `variable_delta_high` value.
     * **If lower** - increase `variable_delta_high`.
  5. Let the dryer run for **30 minutes**, then check the heater state every **30-60 minutes**.

**Important!**
If the heater **sticks to the plastic**, the plastic cannot withstand the temperature - reduce `variable_delta_high`, reprint the case with a different filament, or change the heater mount design.

**To disable heating** - use the macro OFF\_U1

---

### **Damper Servo Setup**

The servo controls the dryer chamber ventilation.

#### **Basic Servo Operation Principles**

* Servo is controlled via **PWM signal**.
* Different servos may respond differently to the same PWM values.
* Servo tuning must be **individual**.

#### **Setting Damper End Positions**

1. **Do not fix the damper to the case during initial setup**.
2. Determine **maximum and minimum** servo rotation angles:

   ```
   SET_SERVO SERVO=srv_U1 ANGLE=0
   ```

   ```
   SET_SERVO SERVO=srv_U1 ANGLE=90
   ```
3. If the servo hits the case - adjust the range.

#### **Configuration Settings**

In the `iDryer.cfg` file:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

Adjust values for variable\_servo\_open\_angle and variable\_servo\_closed\_angle:

```
[gcode_macro DRY_U1]
variable_temp: 5
variable_humidity: 5
variable_duration: 5
variable_delta_high: 30
variable_servo_angle: 0
variable_servo_open_angle: 40 #degrees
variable_servo_closed_angle: 94 #degrees
variable_servo_open_time: 10 #second
variable_servo_closed_time: 300 #second
variable_data: {}
```

---

#### **Servo Power Correction**

If multiple servos are used and issues occur, consider using an **active USB hub**.

Solution:

1. **Current limiting via resistor**

   * Install a **4-10 Ohm resistor** in the servo power line.
   * 3rd revision boards already include such resistors, but the needed resistance may vary.
   * This helps reduce peak load on the host's USB port.
2. **Using an active hub**

   * Connecting via a powered USB hub helps avoid overloading the host system.

---

## System Operation Overview

### G-code Macros

To control the drying process with preset temperatures for various materials, use the following macros:

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

### Temperature Setting Macros:

* For ABS plastic:

```gcode
    ABS_U1
```

* For Nylon:

```gcode
    PA_U1
```

* For Polycarbonate:

```gcode
    PC_U1
```

## Usage

* Set drying temperature:

```gcode
    DRY_UNIT1 UNIT_TEMPERATURE=60
```

* Stop heating:

```gcode
    iDryer_OFF  ; Turn off dryer heating
```

### **Example Commands for Dryer Operation**

* **Turn off drying**:

  ```gcode
  OFF_U1
  ```
* **Start drying for ABS**:

  ```gcode
  ABS_U1
  ```
* **Start drying for PLA**:

  ```gcode
  PLA_U1
  ```
* **Manually open damper**:

  ```gcode
  SET_SERVO SERVO=srv_U1 ANGLE=90
  ```

---

## **Conclusion**

Configuring the iDryer Unit requires precise tuning of PID parameters, `variable_delta_high`, and servo operation. When properly set up, the system will function reliably and efficiently, ensuring high-quality filament drying.

## Alternative Control Algorithm

High-End option by @Xatang

Automatic maintenance of optimal drying and storage parameters, with customizable variables and coefficients, and informative charts.

![xatang](imgweb/xatang.jpg)

[Visit the project repository on GitHub](https://github.com/xatang/PyUnit)

## General Safety Precautions:

Disconnect the unit from power before any work.

Do not touch exposed live parts.

Inspect wiring integrity before powering on.

Do not operate the device with a damaged case or exposed wires.

Do not leave the device unattended while powered on.

Ensure proper grounding of all metal parts.

If you detect a burning smell, smoke, or the case overheats - immediately disconnect the unit.

Avoid moisture or condensation on device components.

**Additional Connection Requirements:**

Use a circuit breaker or overload protection relay.

All connections must maintain electrical insulation.

Failure to follow these rules may result in serious injury or death!

If you lack experience with electrical equipment, consult a qualified professional.

## Questions?

### Contact & Support

[![Telegram](https://img.shields.io/badge/Telegram-Join%20Group-blue?style=for-the-badge\&logo=telegram)](https://t.me/iDryer)
[![YouTube](https://img.shields.io/badge/YouTube-Watch%20video-red?style=for-the-badge\&logo=youtube)](https://www.youtube.com/@iDryerProject)
[![GitHub](https://img.shields.io/badge/GitHub-View%20Project-blue?style=for-the-badge\&logo=github)](https://github.com/pavluchenkor/iDryer-Unit)
[![Discord](https://img.shields.io/discord/123456789012345678?label=Discord\&logo=discord\&logoColor=white\&color=5865F2\&style=for-the-badge)](https://discord.gg/hpNDbvxC)
