# Klipper: настройка

На этой странице описана установка конфигурационных файлов и настройка iDryer Unit в среде Klipper. Прошивка контроллера должна быть установлена заранее — см. раздел «Прошивка».

---

## Конфигурация: mcu или second_mcu

iDryer Unit подключается к Klipper двумя способами:

=== "mcu (отдельный хост)"

    iDryer Unit работает как основной MCU на отдельном хосте (например, Raspberry Pi только для сушилки). Секция в конфиге:

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (совместно с принтером)"

    iDryer Unit подключается к хосту принтера как второй MCU на одном экземпляре Klipper. Секция в конфиге:

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    В этом случае во всех пинах добавляется префикс `iDryer:`, например `iDryer:H_U1`.

---

## Установка конфигурационных файлов

### 1. Подключитесь к хосту по SSH

```bash
ssh user_name@printer_address
```

### 2. Перейдите в директорию конфигурации

```bash
cd ~/printer_data/config/
```

!!! note ""
    Путь может отличаться: `~/klipper_config/` или `~/printer_data/config/` в зависимости от версии установки. Убедитесь, что в директории находится файл `printer.cfg`.

### 3. Загрузите и запустите скрипт установки

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

Скрипт создаст директорию с необходимыми конфигурационными файлами.

### Ручная установка конфигурационных файлов

Если установка через скрипт невозможна, скачайте архив проекта с GitHub и перенесите нужные конфигурационные файлы через интерфейс Fluidd или Mainsail.

[Скачать архив проекта с GitHub](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Подключите конфиг в printer.cfg

Добавьте строку в начало файла `printer.cfg`:

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Укажите серийный ID в iDryer.cfg

Получите ID контроллера:

```bash
ls /dev/serial/by-id/*
```

В файле `iDryer.cfg` в секции `[mcu iDryer]` замените плейсхолдер на полученный ID:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Подключение дополнительных блоков (U2–U4)

По умолчанию подключён блок U1. Раскомментируйте нужные строки в `iDryer.cfg`:

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Настройка оборудования

### Нагреватель

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

### Вентилятор

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# при использовании second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Датчик температуры и влажности

В примере используется SHT3X на шине I2C:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 или 69
```

!!! note ""
    Датчики U1 и U2 подключены к одной шине I2C, датчики U3 и U4 — к другой. Адреса датчиков на одной шине должны отличаться: один на `68`, другой на `69`. При использовании другого датчика сверьтесь с [документацией Klipper](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## Калибровка PID

Выполните калибровку при закрытой крышке сушилки:

1. Откройте консоль Klipper.
2. Выполните команду:
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Дождитесь завершения.
4. Запишите полученные коэффициенты в `iDryer.cfg`.

---

## Настройка сервопривода заслонки

### 1. Определение крайних положений

Сервопривод управляется ШИМ-сигналом. Разные модели сервоприводов по-разному реагируют на одни и те же значения — настройка всегда индивидуальна.

**Не прикручивайте заслонку к корпусу** на этом этапе — сначала определите рабочий диапазон.

Проверьте крайние положения командами в консоли Klipper:

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Если сервопривод упирается в корпус — скорректируйте диапазон.

### 2. Запись углов в конфиг

Проверьте секцию сервопривода в `iDryer.cfg`:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

В файле `iDryer.cfg` в макросе `DRY_U1` задайте углы:

```ini
variable_servo_open_angle: 40    # градусы открытого положения
variable_servo_closed_angle: 94  # градусы закрытого положения
```

### 3. Коррекция питания сервопривода

При использовании нескольких сервоприводов возможны сбои из-за пиковой нагрузки на USB-порт хоста.

**Вариант 1 — резистор в цепи питания серво:**

Установите резистор 4–10 Ом в разрыв питания сервопривода. На платах ревизии 3 резисторы уже распаяны, однако конкретное сопротивление подбирается индивидуально.

**Вариант 2 — активный USB-хаб:**

Подключите контроллер через USB-хаб с отдельным питанием — это исключает перегрузку порта хоста.

!!! note ""
    Проблемы со стабильностью связи (обрывы, перезагрузки MCU) могут быть вызваны ЭМ-помехами от силовых проводов или вентилятора. Решения — ферритовый фильтр на USB-кабель и RC-снаббер параллельно вентилятору. См. раздел «Устранение неисправностей».

---

## Настройка delta_high

`variable_delta_high` управляет разницей между температурой нагревателя и целевой температурой воздуха.

Процедура настройки:

1. Установите начальное значение `variable_delta_high: 15`.
2. Запустите нагрев макросом `PA_U1`.
3. Дождитесь выхода на плато.
4. Проверьте температуру в камере:
   - Если в камере 90 °C — значение подходит.
   - Если ниже — увеличьте `variable_delta_high`.
5. Оставьте работать 30 минут, затем проверяйте состояние каждые 30–60 минут.

!!! warning ""
    Если нагреватель прилипает к пластику корпуса — пластик не выдерживает температуру. Снизьте `variable_delta_high`, перепечатайте корпус из ABS или ABS-CF, либо измените способ крепления нагревателя.

---

## Макросы G-кода

Для управления сушкой по типу материала используйте предустановленные макросы:

| Макрос | Температура | Время |
|---|---|---|
| `PLA_U1` | 55 °C | 180 мин |
| `PETG_U1` | 65 °C | 240 мин |
| `ABS_U1` | 80 °C | 240 мин |
| `PA_U1` | 90 °C | 240 мин |
| `TPU_U1` | 60 °C | 300 мин |
| `OFF_U1` | выкл | — |

Запуск произвольного режима:

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Открыть/закрыть заслонку вручную:

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; открыть
SET_SERVO SERVO=srv_U1 ANGLE=0   ; закрыть
```

---

## Альтернативный алгоритм управления — PyUnit

Проект от участника сообщества [@Xatang](https://github.com/xatang). Автоматическое поддержание параметров сушки и хранения с настраиваемыми коэффициентами и информативными графиками.

![PyUnit](../../imgweb/xatang.jpg)

→ [Репозиторий PyUnit на GitHub](https://github.com/xatang/PyUnit)
