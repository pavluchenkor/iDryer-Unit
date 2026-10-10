# Klipper: Instalação de Firmware

Esta página descreve a instalação do firmware Klipper no controlador iDryer Unit (MCU em RP2040).

A instalação do firmware é executada em duas etapas:

1. Instalação do bootloader **Katapult** — permite reprogramar Klipper via USB sem entrar em modo BOOT.
2. Instalação de **Klipper** via Katapult.

---

## Requisitos

- Host com Klipper instalado (Raspberry Pi ou similar).
- Cabo USB para transferência de dados.
- Acesso SSH ao terminal do host.

---

## Parte 1: Instalação do Katapult

### 1. Preparação do ambiente

Certifique-se de que o sistema está atualizado e instale as dependências:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Download do Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Configuração de compilação

```bash
cd katapult
make menuconfig
```

Selecione os parâmetros de acordo com a captura de tela:

![Katapult menuconfig](../../img/011.png)

!!! danger "Importante"
    Certifique-se de que a configuração foi escolhida corretamente. Sobrescrever o bootloader com uma compilação incorreta tornará o dispositivo inoperável – um programador é necessário para a recuperação.

### 4. Compilação

```bash
make
```

### 5. Colocar o controlador em modo BOOT

Execute um dos seguintes procedimentos:

- Mantenha `BOOT` pressionado, conecte USB, solte `BOOT` (com USB desconectado).
- Mantenha `BOOT` pressionado, pressione `RESET` brevemente, solte `BOOT`.

### 6. Determinar o ID USB do controlador

```bash
lsusb
```

A saída exibirá uma linha como:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Programar o Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Parte 2: Instalação do Klipper

### 8. Configuração de compilação do Klipper

```bash
cd ~/klipper/
make clean
make menuconfig
```

Selecione os parâmetros de acordo com a captura de tela:

![Klipper menuconfig](../../img/016.png)

### 9. Compilar Klipper

```bash
make
```

### 10. Instalar biblioteca Python

```bash
pip3 install pyserial
```

### 11. Determinar o ID serial

Reconecte USB ou pressione `RESET`, aguarde o aparecimento do dispositivo:

```bash
ls /dev/serial/by-id/*
```

Resultado esperado:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Programar Klipper via Katapult

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Verificar o resultado

```bash
ls /dev/serial/by-id/*
```

Se a programação foi bem-sucedida, o ID do dispositivo conterá `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Próxima etapa

Instalação dos arquivos de configuração iDryer – seção «Configuração».
