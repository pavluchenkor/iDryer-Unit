# Klipper: Instalación de firmware

En esta página se describe la instalación del firmware Klipper en el controlador iDryer Unit (MCU en RP2040).

La instalación del firmware se realiza en dos pasos:

1. Instalación del cargador de arranque **Katapult** — permite reprogramar Klipper a través de USB sin entrar en modo BOOT.
2. Instalación de **Klipper** a través de Katapult.

---

## Requisitos

- Host con Klipper instalado (Raspberry Pi o equivalente).
- Cable USB para transferencia de datos.
- Acceso SSH a la terminal del host.

---

## Parte 1: Instalación de Katapult

### 1. Preparación del entorno

Asegúrese de que el sistema esté actualizado e instale las dependencias:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Descargar Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Configuración de compilación

```bash
cd katapult
make menuconfig
```

Seleccione los parámetros de acuerdo con la captura de pantalla:

![Katapult menuconfig](../../img/011.png)

!!! danger "Importante"
    Asegúrese de que la configuración se haya elegido correctamente. Sobrescribir el cargador de arranque con una compilación incorrecta inutilizará el dispositivo – se requiere un programador para la recuperación.

### 4. Compilación

```bash
make
```

### 5. Poner el controlador en modo BOOT

Ejecute uno de los siguientes procedimientos:

- Mantenga `BOOT` presionado, conecte USB, suelte `BOOT` (con USB desconectado).
- Mantenga `BOOT` presionado, presione `RESET` brevemente, suelte `BOOT`.

### 6. Determinar el ID USB del controlador

```bash
lsusb
```

La salida mostrará una línea como esta:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Programar Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Parte 2: Instalación de Klipper

### 8. Configuración de compilación de Klipper

```bash
cd ~/klipper/
make clean
make menuconfig
```

Seleccione los parámetros de acuerdo con la captura de pantalla:

![Klipper menuconfig](../../img/016.png)

### 9. Compilar Klipper

```bash
make
```

### 10. Instalar la biblioteca de Python

```bash
pip3 install pyserial
```

### 11. Determinar el ID serie

Reconecte USB o presione `RESET`, espere a que aparezca el dispositivo:

```bash
ls /dev/serial/by-id/*
```

Resultado esperado:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Programar Klipper a través de Katapult

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Verificar el resultado

```bash
ls /dev/serial/by-id/*
```

Si la programación fue exitosa, el ID del dispositivo contendrá `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Siguiente paso

Instalación de los archivos de configuración iDryer – sección «Configuración».
