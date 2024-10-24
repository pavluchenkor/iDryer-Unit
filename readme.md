
# iDryer Unit - cистема  сушки пластика для 3D-принтеров
![iDryer Unit Master](img/IMG_E2204.jpg)


Этот проект представляет собой систему управления сушкой пластика для 3D-принтеров, работающую под управлением прошивки Klipper.

## Особенности проекта

- **Режим сушки и хранения**: Возможность сушки пластика при температуре до 90°C и поддержание оптимальной температуры и влажности для хранения пластика.
- **Эффективность сушки**: За счет использования датчика влажности и системы проветривания камеры достигаются оптимальные результаты сушки пластика в кратчайшие сроки.
- **Корпус сушилки**: Корпус печатается на 3Д принтере.
- **Интеграция с Klipper**: Вся информация о процессе сушки выводится в интерфейсе Klipper для удобного мониторинга и управления.
- **Master-slave архитектура**: Одна сушилка оснащена MCU и выступает в роли мастера, остальные сушилки являются слейвами.
- **Подключение слейвов**: Слейвы подключаются к мастеру с помощью патчкордов через RJ45-8P/8C-разъёмы для надёжной связи.
- **Поддержка до четырёх сушилок**: Каждая сушилка может обслуживать одну или две катушки пластика одновременно.
- **Безопасность**: Алгоритмы безопасности Klipper и использование термостата KSD9700 на 130°C для предотвращения аварий делает систему безопасной для бытового применения.

## Преимущества использования

- **Улучшенное качество печати**: Сухой пластик обеспечивает стабильную экструзию и высокое качество печати.
- **Эффективность**: Одновременная сушка нескольких катушек экономит время и повышает производительность.
- **Гибкость**: Система может быть расширена или настроена под конкретные нужды.
- **Безопасность**: Аппаратные и программные средства обеспечивают безопасную работу системы.

## Технические детали

- **MCU**: Используется для управления мастер-сушилкой и координации работы слейвов.
- **Термопредохранитель KSD9700**: термопредохранитель на 130°C обеспечивает защиту в аварийной ситуации и отключает нагреватель.
- **Температурный режим**: Сушка проводится при температуре до 90°C, что подходит для большинства видов пластика.
- **Интерфейсы подключения**: RJ45-8P/8C-разъёмы используются для соединения между сушилками, что упрощает монтаж и обеспечивает надёжное соединение.

## Установка и настройка

1. **Сборка оборудования**: Соберите мастер-сушилку с MCU и необходимые слейвы.
2. **Подключение**: Соедините слейвы с мастером с помощью патчкордов через RJ45-8P/8C-разъёмы.
3. **Настройка Klipper**: Интегрируйте систему сушки в конфигурацию Klipper.
4. **Тестирование**: Проверьте работу системы и убедитесь в корректности отображения данных в интерфейсе Klipper.

## Требования

- 3D-принтер с установленной прошивкой Klipper.
- MCU для мастер-сушилки.
- термопредохранитель KSD9700 на 130°C для каждой сушилки.
- RJ45-8P/8C-патчкорды и разъёмы для подключения слейвов к мастеру.

---



# Конфигурация iDryer для Klipper

Этот репозиторий содержит конфигурационные файлы для сушилки пластика iDryer, основанной на прошивке Klipper и плате управления iDryer Unit с микроконтроллером RP2040. Конфигурация предназначена для автоматизации процесса сушки пластика для 3D-принтеров, включая контроль температуры и влажности.

## Оглавление

- [Требования](#требования)
- [Подготовка](#подготовка)
- [Установка прошивки на iDryer Unit](#установка-прошивки-на-idryer-unit)
- [Конфигурация Klipper](#конфигурация-klipper)
  - [Подключение MCU iDryer](#подключение-mcu-idryer)
  - [Настройка нагревателя](#настройка-нагревателя)
  - [Настройка вентилятора](#настройка-вентилятора)
  - [Настройка датчиков температуры и влажности](#настройка-датчиков-температуры-и-влажности)
  - [Макросы G-кода](#макросы-г-кода)
- [Использование](#использование)
- [Примечания](#примечания)

## Требования

- **Аппаратное обеспечение:**

  - Плата управления iDryer Unit с микроконтроллером RP2040
  - Терморезистор NTC 100K для контроля температуры (или любой другой датчик, поддерживаемый прошивкой Klipper)
  - Нагревательный элемент (оптимально 220В, 100Вт)
  - Вентилятор для циркуляции воздуха в сушилке
  - Датчик температуры и влажности (например, SHT3X, но может быть любой другой, поддерживаемый Klipper)
  ![iDryer Unit Master](img/IMG_2683.jpg)
  ![iDryer Unit Master](img/IMG_2692.jpg)

- **Программное обеспечение:**

  - Klipper (последняя версия)
  - Настроенный 3D-принтер с прошивкой Klipper

## Подготовка

1. **Сборка аппаратной части:**

   - Подключите нагревательный элемент и вентилятор к плате iDryer Unit.
   - Установите терморезистор и датчик SHT3X (или любой другой поддерживаемый датчик температуры/влажности) в сушилке и подключите их к соответствующим пинам на плате.

2. **Установка необходимых файлов:**

   - Скопируйте файлы `rp2040_pin_aliases.cfg`, `iDryer.cfg`, и другие конфигурационные файлы в директорию конфигурации Klipper.

## Установка прошивки на iDryer Unit

### 1. Подготовка прошивки:

Если прошивка для RP2040 ещё не установлена:

- В меню конфигурации прошивки Klipper:
  - Выберите архитектуру **RP2040**.
  - Остальные параметры оставьте по умолчанию.

### 2. Сборка прошивки:

Выполните сборку прошивки:

```bash
make
```

### 3. Установка прошивки на iDryer Unit:

- Подключите плату iDryer Unit к компьютеру в режиме программирования (удерживая кнопку BOOT при подключении).
- Смонтируйте устройство и загрузите прошивку:

```bash
sudo mount /dev/sda1 /mnt
sudo cp out/klipper.uf2 /mnt
sudo umount /mnt
```

## Конфигурация Klipper

### 1. Включение конфигурации iDryer:

В файл `printer.cfg` необходимо добавить строку для включения конфигурационного файла `iDryer.cfg`:

```ini
[include iDryer.cfg]
```

### Подключение MCU iDryer

[Найдите серийный порт вашего микроконтроллера и укажите его в конфигурационном файле:](#https://www.klipper3d.org/Installation.html#building-and-flashing-the-micro-controller)

```
ls /dev/serial/by-id/*
```
В файле iDryer.cfg замените id MCU найденным выше 

```ini
[mcu]
serial: /dev/serial/by-id/usb-Klipper_rp2040_DE63581213745233-if00
```

### Настройка нагревателя

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

### Настройка вентилятора

```ini
[heater_fan Master_Fan]
fan_speed: 1
pin: FAN0
heater: iDryer_M_Heater
heater_temp: 55
```

### Настройка датчиков температуры и влажности

Вы можете использовать любой датчик температуры и влажности, поддерживаемый Klipper. В примере используется датчик **SHT3X**, подключённый через интерфейс I2C:

```ini
[temperature_sensor iDryer_M_Air]
sensor_type: SHT3X
i2c_address: 68
i2c_software_sda_pin: gpio18
i2c_software_scl_pin: gpio19
```

**Примечание:** Если вы используете другой датчик температуры или влажности, проверьте документацию Klipper для соответствующей конфигурации.

### Макросы G-кода

Для управления процессом сушки с возможностью установки температуры для разных материалов, используйте следующие макросы:

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

### Макрос для обновления данных:

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

### Макросы для установки температуры:

- Для ABS-пластика:

```gcode
ABS_U1
```

- Для PLA-пластика:

```gcode
PLA_U1
```

- Для PETG-пластика:

```gcode
PETG_U1
```

## Использование

- Установка температуры для сушки:

```gcode
DRY_UNIT1 UNIT_TEMPERATURE=60
```

- Остановка нагрева:

```gcode
iDryer_OFF  ; Отключить нагрев сушилки
```

## Обратная связь

Если у вас есть вопросы или предложения по улучшению системы, пожалуйста, создайте issue в этом репозитории или свяжитесь с напрямую.

## Примечания

- Убедитесь в правильности подключения датчиков температуры и влажности (например, SHT3X или другого).
- Для оптимального контроля температуры может потребоваться калибровка PID.
- Следите за показаниями температуры и влажности с помощью макросов для более точной настройки условий сушки.
- Проект находится в стадии разработки

***Внимание: Использование нагревательных элементов и управление температурой связано с риском возгорания и повреждения оборудования. Всегда следуйте рекомендациям производителя и соблюдайте меры предосторожности и электробезопасности. Не оставляйте включенные электрические устройства без присмотра.***
