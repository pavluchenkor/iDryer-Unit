# Klipper: установка прошивки

На этой странице описана установка прошивки Klipper на контроллер iDryer Unit (MCU на RP2040).

Прошивка выполняется в два этапа:

1. Установка загрузчика **Katapult** — позволяет перепрошивать Klipper через USB без входа в режим BOOT.
2. Установка **Klipper** через Katapult.

---

## Требования

- Хост с установленным Klipper (Raspberry Pi или аналог).
- USB-кабель для передачи данных.
- Доступ к терминалу хоста по SSH.

---

## Часть 1: Установка Katapult

### 1. Подготовка окружения

Убедитесь, что система обновлена, и установите зависимости:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Загрузка Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. Конфигурация сборки

```bash
cd katapult
make menuconfig
```

Выберите параметры в соответствии со скриншотом:

![Katapult menuconfig](../../img/011.png)

!!! danger "Важно"
    Убедитесь, что конфигурация выбрана правильно. Перезапись загрузчика некорректной сборкой приведёт к неработоспособности устройства — для восстановления потребуется программатор.

### 4. Сборка

```bash
make
```

### 5. Перевод контроллера в режим BOOT

Выполните одно из двух:

- При отключённом USB удерживайте `BOOT`, подключите USB, отпустите `BOOT`.
- Удерживайте `BOOT`, кратковременно нажмите `RESET`, отпустите `BOOT`.

### 6. Определение USB ID контроллера

```bash
lsusb
```

В выводе появится строка вида:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Прошивка Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## Часть 2: Установка Klipper

### 8. Конфигурация сборки Klipper

```bash
cd ~/klipper/
make clean
make menuconfig
```

Выберите параметры в соответствии со скриншотом:

![Klipper menuconfig](../../img/016.png)

### 9. Сборка Klipper

```bash
make
```

### 10. Установка Python-библиотеки

```bash
pip3 install pyserial
```

### 11. Определение серийного ID

Переподключите USB или нажмите `RESET`, дождитесь появления устройства:

```bash
ls /dev/serial/by-id/*
```

Ожидаемый результат:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Прошивка Klipper через Katapult

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. Проверка результата

```bash
ls /dev/serial/by-id/*
```

При успешной прошивке ID устройства будет содержать `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## Следующий шаг

Установка конфигурационных файлов iDryer — раздел «Настройка».
