# [Unit-X mod]

## Краткое содержание

Этот мод позволяет подключить сушилку iDryer X в качестве второго микроконтроллера к iDryer Unit для совместного использования.

![img1](https://github.com/user-attachments/assets/64693cec-fa60-4c0a-a4d9-ead2b9fab13b)

## Руководство

### 1. Замена оптопары

Обязательно замените оптопару MOC3023 на MOC3063.

![Замена оптопары](https://github.com/user-attachments/assets/89123318-d57d-4415-9af9-94d5fb4ae864)

### 2. Загрузчик Arduino

> ВАЖНО: Если ваша Arduino ранее прошивалась прошивкой iDryer X, необходимо повторно записать загрузчик. Если нет, перейдите сразу к пункту 3.

Запись загрузчика:

- В Arduino IDE выберите:
  - Плата: Arduino Nano
  - Программатор: USBasp
  - Нажмите Записать загрузчик

![Настройка Arduino IDE](https://github.com/user-attachments/assets/e9c90d9f-bf44-4221-aa0f-b61343050e36)

### 3. Сборка и прошивка для Arduino Nano

- Подключитесь к Raspberry Pi по SSH.
- Установите пакеты компиляции AVR:

sudo apt update
sudo apt install gcc-avr avr-libc avrdude binutils-avr
- Проще всего собрать прошивку через KIAUH:

Если KIAUH не установлен:

cd ~
sudo apt update && sudo apt install git -y
git clone https://github.com/dw-0/kiauh.git

Запуск KIAUH:

./kiauh/kiauh.sh
- Выберите раздел Advanced.

![Advanced](https://github.com/user-attachments/assets/e8245b6b-e84f-442b-bf40-f4d4e15e1ff3)

- Затем выберите Build + Flash.

![Build + Flash](https://github.com/user-attachments/assets/ae9dd135-2f53-4a5c-817b-507552eb1263)

- Настройте параметры так же, как на скриншоте, затем нажмите клавишу Q:

![Настройка параметров](https://github.com/user-attachments/assets/903672db-571f-43fc-835d-39e836446643)  
![Дополнительные параметры](https://github.com/user-attachments/assets/9e98375c-f021-486a-a3c2-d0a5947e7512)

- Выберите Regular flashing method:

![Regular flashing](https://github.com/user-attachments/assets/baec0df1-4717-4c33-b021-5ca211f4b3cd)

- Затем make flash (default):

![make flash](https://github.com/user-attachments/assets/c82b8f80-8f4a-41b6-a653-78cb296627f9)

- Далее USB:

![USB](https://github.com/user-attachments/assets/3a827992-caa3-4213-a041-945f31fa3cdf)

- Выберите порт, к которому подключена Arduino (в примере порт 0):

![Выбор порта](https://github.com/user-attachments/assets/8ee0638d-4aae-47b7-b25e-2ef95f2a456a)

Если возникли проблемы с самостоятельной сборкой, вы можете использовать прилагаемый HEX-файл и прошить его программатором. Однако рекомендуем разобраться в причинах ошибки самостоятельно.

### 4. Конфигурация

- Добавьте в конфигурацию файл Unit_X.cfg.
- В файле iDryer.cfg добавьте строку:
[include Unit-X.cfg]

![include](https://github.com/user-attachments/assets/6f42c62f-f609-4229-89ec-55c0de3e982c)

- В файле Unit_X.cfg измените путь к устройству на свой:

![serial](https://github.com/user-attachments/assets/9f0be9d8-0076-4924-86c9-9a59576b2bd7)

- Перезагрузите систему. После перезагрузки должен появиться второй MCU:

![mcu unit x](https://github.com/user-attachments/assets/bba52491-418b-401c-9821-fc4e5bd4c68e)

- При необходимости измените углы серво-привода в файле Unit-X.cfg:

![servo](https://github.com/user-attachments/assets/1e48cc00-becc-4687-a405-741d95cfb234)
