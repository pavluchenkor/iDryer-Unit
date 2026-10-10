# Klipper: Configuración

Esta página describe la instalación de archivos de configuración y la configuración de iDryer Unit en el entorno de Klipper. El firmware del controlador debe instalarse previamente – véase la sección « Firmware ».

---

## Configuración: mcu o second_mcu

iDryer Unit se conecta a Klipper de dos formas:

=== "mcu (anfitrión separado)"

    iDryer Unit funciona como MCU principal en un anfitrión separado (por ejemplo, Raspberry Pi solo para el secador). Sección de configuración:

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (compartido con la impresora)"

    iDryer Unit se conecta al anfitrión de la impresora como segundo MCU en una instancia de Klipper. Sección de configuración:

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    En este caso, todos los pines reciben el prefijo `iDryer:`, por ejemplo `iDryer:H_U1`.

---

## Instalación de archivos de configuración

### 1. Conexión al anfitrión mediante SSH

```bash
ssh user_name@printer_address
```

### 2. Navegación al directorio de configuración

```bash
cd ~/printer_data/config/
```

!!! note ""
    La ruta puede variar: `~/klipper_config/` o `~/printer_data/config/` según la versión de instalación. Verifique que el archivo `printer.cfg` se encuentre en el directorio.

### 3. Descarga y ejecución del script de instalación

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

El script crea un directorio con los archivos de configuración necesarios.

### Instalación manual de archivos de configuración

Si la instalación mediante script no es posible, descargue el archivo del proyecto desde GitHub y transfiera los archivos de configuración requeridos a través de la interfaz de Fluidd o Mainsail.

[Descargar archivo del proyecto desde GitHub](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Inclusión de la configuración en printer.cfg

Agregue una línea al principio del archivo `printer.cfg`:

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Especificación del ID de serie en iDryer.cfg

Obtenga el ID del controlador:

```bash
ls /dev/serial/by-id/*
```

En el archivo `iDryer.cfg`, en la sección `[mcu iDryer]`, reemplace el marcador de posición por el ID obtenido:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Conexión de módulos adicionales (U2–U4)

Por defecto, está conectado el módulo U1. Descomente las líneas necesarias en `iDryer.cfg`:

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Configuración del hardware

### Elemento calefactor

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

### Ventilador

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# al usar second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Sensor de temperatura y humedad

El ejemplo utiliza SHT3X en el bus I2C:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 o 69
```

!!! note ""
    Los sensores U1 y U2 están conectados a un bus I2C, los sensores U3 y U4 a otro. Las direcciones de los sensores en un mismo bus deben ser diferentes: una en `68`, la otra en `69`. Al usar un sensor diferente, consulte la [documentación de Klipper](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## Calibración PID

Realice la calibración con la tapa del secador cerrada:

1. Abra la consola de Klipper.
2. Ejecute el comando:
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Espere a que se complete.
4. Registre los coeficientes obtenidos en `iDryer.cfg`.

---

## Configuración del servoactuador del obturador

### 1. Determinación de las posiciones extremas

El servoactuador se controla mediante una señal PWM. Diferentes modelos de servos responden de manera diferente a los mismos valores – la calibración siempre es individual.

**No fije el obturador al gabinete** en esta etapa – primero determine el rango de funcionamiento.

Verifique las posiciones extremas con comandos en la consola de Klipper:

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Si el servoactuador está bloqueado contra el gabinete – ajuste el rango.

### 2. Registro de ángulos en la configuración

Verifique la sección del servo en `iDryer.cfg`:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

En el archivo `iDryer.cfg`, en la macro `DRY_U1`, establezca los ángulos:

```ini
variable_servo_open_angle: 40    # grados de la posición abierta
variable_servo_closed_angle: 94  # grados de la posición cerrada
```

### 3. Corrección de la alimentación del servoactuador

Al usar múltiples servoactuadores, es posible que se produzcan fallos debido a la sobrecarga del puerto USB.

**Opción 1 – Resistencia en la alimentación del servo:**

Instale una resistencia de 4–10 Ohms en la alimentación del servoactuador. En las tarjetas de revisión 3, los resistores ya están soldados, pero el valor de resistencia exacto debe seleccionarse individualmente.

**Opción 2 – Hub USB activo:**

Conecte el controlador a través de un hub USB con alimentación separada – esto evita una sobrecarga del puerto del anfitrión.

!!! note ""
    Los problemas de estabilidad de comunicación (desconexiones, reinicios del MCU) pueden ser causados por interferencias electromagnéticas de cables de alimentación o ventiladores. Soluciones: ferrita en el cable USB y supresor RC en paralelo con el ventilador. Véase la sección « Solución de problemas ».

---

## Configuración de delta_high

`variable_delta_high` gestiona la diferencia entre la temperatura del calentador y la temperatura del aire objetivo.

Procedimiento de calibración:

1. Establezca el valor inicial `variable_delta_high: 15`.
2. Inicie el calentamiento con la macro `PA_U1`.
3. Espere a que se estabilice.
4. Verifique la temperatura en la cámara:
   - Si es de 90 °C en la cámara – el valor es adecuado.
   - Si es menor – aumente `variable_delta_high`.
5. Deje funcionando 30 minutos, luego verifique cada 30–60 minutos.

!!! warning ""
    Si el elemento calefactor se pega al gabinete de plástico – el plástico no soporta la temperatura. Reduzca `variable_delta_high`, reimprima el gabinete en ABS o ABS-CF, o cambie el método de fijación del calentador.

---

## Macros de código G

Utilice macros preconfigurados para controlar el secado según el tipo de material:

| Macro | Temperatura | Tiempo |
|---|---|---|
| `PLA_U1` | 55 °C | 180 min |
| `PETG_U1` | 65 °C | 240 min |
| `ABS_U1` | 80 °C | 240 min |
| `PA_U1` | 90 °C | 240 min |
| `TPU_U1` | 60 °C | 300 min |
| `OFF_U1` | apagado | — |

Inicio del modo personalizado:

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Apertura/cierre manual del obturador:

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; abrir
SET_SERVO SERVO=srv_U1 ANGLE=0   ; cerrar
```

---

## Algoritmo de control alternativo – PyUnit

Proyecto de un miembro de la comunidad [@Xatang](https://github.com/xatang). Mantenimiento automático de parámetros de secado y almacenamiento con coeficientes configurables y gráficos informativos.

![PyUnit](../../img/xatang.jpg)

→ [Repositorio PyUnit en GitHub](https://github.com/xatang/PyUnit)
