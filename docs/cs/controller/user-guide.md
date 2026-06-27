# Klipper: Konfigurace

Tato stránka popisuje instalaci konfiguračních souborů a nastavení iDryer Unit v prostředí Klipper. Firmware řadiče musí být nainstalován předem – viz oddíl « Firmware ».

---

## Konfigurace: mcu nebo second_mcu

iDryer Unit se připojuje k Klipperu dvěma způsoby:

=== "mcu (oddělený hostitel)"

    iDryer Unit funguje jako primární MCU na oddělujícím hostiteli (např. Raspberry Pi pouze pro sušilnu). Konfigurační oddíl:

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (sdíleno s tiskárnou)"

    iDryer Unit se připojuje k hostiteli tiskárny jako druhý MCU v jedné instanci Klipper. Konfigurační oddíl:

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    V tomto případě všechny piny dostanou předponu `iDryer:`, například `iDryer:H_U1`.

---

## Instalace konfiguračních souborů

### 1. Připojení k hostiteli přes SSH

```bash
ssh user_name@printer_address
```

### 2. Navigace do adresáře konfigurace

```bash
cd ~/printer_data/config/
```

!!! note ""
    Cesta se může lišit: `~/klipper_config/` nebo `~/printer_data/config/` podle verze instalace. Ověřte, že se soubor `printer.cfg` nachází v adresáři.

### 3. Stažení a spuštění instalačního skriptu

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

Skript vytvoří adresář s potřebnými konfiguračními soubory.

### Ruční instalace konfiguračních souborů

Pokud není možná instalace přes skript, stáhněte archiv projektu z GitHubu a přeneste požadované konfigurační soubory prostřednictvím rozhraní Fluidd nebo Mainsail.

[Stáhněte archiv projektu z GitHubu](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Zahrnutí konfigurace v printer.cfg

Přidejte řádek na začátek souboru `printer.cfg`:

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Zadání sériového ID v iDryer.cfg

Získejte ID řadiče:

```bash
ls /dev/serial/by-id/*
```

V souboru `iDryer.cfg` v oddílu `[mcu iDryer]` nahraďte zástupný symbol získaným ID:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Připojení dalších modulů (U2–U4)

Ve výchozím nastavení je připojen modul U1. Odkomentujte potřebné řádky v `iDryer.cfg`:

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Konfigurace hardwaru

### Topná součástka

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

### Ventilátor

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# při použití second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Snímač teploty a vlhkosti

Příklad používá SHT3X na sběrnici I2C:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 nebo 69
```

!!! note ""
    Snímače U1 a U2 jsou připojeny na jednu sběrnici I2C, snímače U3 a U4 na druhou. Adresy snímačů na jedné sběrnici se musí lišit: jedna na `68`, druhá na `69`. Při použití jiného snímače si prostudujte [dokumentaci Klipper](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## Kalibrování PID

Proveďte kalibrování se zavřeným krytem sušilny:

1. Otevřete konzolu Klipper.
2. Spusťte příkaz:
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Čekejte na dokončení.
4. Zaznamenejte získané koeficienty v `iDryer.cfg`.

---

## Konfigurace servopohonu clonek

### 1. Určení extrémních poloh

Servopohon je řízen PWM signálem. Různé modely serv se na stejné hodnoty odlišně chují – kalibrování je vždy individuální.

**Nepřipevňujte clonek na skřín** v tomto stádiu – nejdříve určete pracovní rozsah.

Ověřte extrémní polohy příkazy v konzole Klipper:

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Pokud se servopohon zasekl o skřín – upravte rozsah.

### 2. Záznam úhlů v konfiguraci

Ověřte sekci serva v `iDryer.cfg`:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

V souboru `iDryer.cfg` v makru `DRY_U1` nastavte úhly:

```ini
variable_servo_open_angle: 40    # stupně otevřené polohy
variable_servo_closed_angle: 94  # stupně zavřené polohy
```

### 3. Korekce napájení servopohonu

Při použití více servopohonů jsou možné poruchy z důvodu přetížení portu USB.

**Možnost 1 – Rezistor v napájecím obvodu serva:**

Instalujte rezistor 4–10 Ohmů do napájecího obvodu servopohonu. Na deskách revize 3 jsou rezistory již zapájeny, ale konkrétní hodnota odporu se volí individuálně.

**Možnost 2 – Aktivní USB hub:**

Připojte řadič přes USB hub se samostatným napájením – to zabrání přetížení hostitele.

!!! note ""
    Problémy se stabilitou komunikace (výpadky, restartování MCU) mohou být způsobeny elektromagnetickými poruchami od napájecích kabelů nebo ventilátoru. Řešení – feritový filtr na USB kabel a RC tlumič paralelně s ventilátorem. Viz oddíl « Odstraňování problémů ».

---

## Konfigurace delta_high

`variable_delta_high` řídí rozdíl mezi teplotou topného tělesa a cílovou teplotou vzduchu.

Postup kalibrování:

1. Nastavte počáteční hodnotu `variable_delta_high: 15`.
2. Spusťte topení makrem `PA_U1`.
3. Čekejte na stabilizaci.
4. Ověřte teplotu v komoře:
   - Pokud je v komoře 90 °C – hodnota je vhodná.
   - Pokud je nižší – zvyšte `variable_delta_high`.
5. Nechte běžet 30 minut, poté kontrolujte každých 30–60 minut.

!!! warning ""
    Pokud se topné těleso lepí na plastový kryt – plast nezvládá teplotu. Snižte `variable_delta_high`, znovu vytiskněte kryt z ABS nebo ABS-CF, nebo změňte způsob uchycení topné součástky.

---

## Makra G-kódu

Používejte přednastavená makra k řízení sušení podle typu materiálu:

| Makro | Teplota | Čas |
|---|---|---|
| `PLA_U1` | 55 °C | 180 min |
| `PETG_U1` | 65 °C | 240 min |
| `ABS_U1` | 80 °C | 240 min |
| `PA_U1` | 90 °C | 240 min |
| `TPU_U1` | 60 °C | 300 min |
| `OFF_U1` | vypnuto | — |

Spuštění vlastního režimu:

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Ruční otevření/zavření clonek:

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; otevřít
SET_SERVO SERVO=srv_U1 ANGLE=0   ; zavřít
```

---

## Alternativní algoritmus řízení – PyUnit

Projekt od člena komunity [@Xatang](https://github.com/xatang). Automatická údržba parametrů sušení a skladování s konfigurovatelnou koeficienty a informativními grafy.

![PyUnit](../../img/xatang.jpg)

→ [PyUnit repozitář na GitHubu](https://github.com/xatang/PyUnit)
