# Klipper：設定

本頁介紹在 Klipper 環境中安裝設定檔案和設定 iDryer Unit。控制器韌體必須預先安裝 – 請參閱「韌體」部分。

---

## 設定：mcu 或 second_mcu

iDryer Unit 透過兩種方式連接到 Klipper：

=== "mcu（獨立主機）"

    iDryer Unit 作為獨立主機上的主要 MCU 工作（例如僅用於乾燥機的 Raspberry Pi）。設定部分：

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu（與印表機共享）"

    iDryer Unit 作為單一 Klipper 實例中的第二個 MCU 連接到印表機主機。設定部分：

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    在這種情況下，所有引腳都獲得 `iDryer:` 首碼，例如 `iDryer:H_U1`。

---

## 安裝設定檔案

### 1. 透過 SSH 連接到主機

```bash
ssh user_name@printer_address
```

### 2. 導航到設定目錄

```bash
cd ~/printer_data/config/
```

!!! note ""
    路徑可能不同：`~/klipper_config/` 或 `~/printer_data/config/` 取決於安裝版本。檢查目錄中是否存在 `printer.cfg` 檔案。

### 3. 下載並執行安裝指令碼

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

指令碼將建立包含必要設定檔案的目錄。

### 手動安裝設定檔案

如果無法透過指令碼安裝，請從 GitHub 下載專案存檔，並透過 Fluidd 或 Mainsail 介面傳輸所需的設定檔案。

[從 GitHub 下載專案存檔](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. 在 printer.cfg 中包含設定

在 `printer.cfg` 檔案的開頭新增一行：

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. 在 iDryer.cfg 中指定序列號

獲取控制器 ID：

```bash
ls /dev/serial/by-id/*
```

在 `iDryer.cfg` 檔案中的 `[mcu iDryer]` 部分，將預留位置替換為取得的 ID：

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. 連接附加模組（U2–U4）

預設情況下，模組 U1 已連接。在 `iDryer.cfg` 中取消註解所需的行：

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## 硬體設定

### 加熱器

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

### 風扇

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# 使用 second_mcu 時：pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### 溫度和濕度感應器

範例使用 I2C 匯流排上的 SHT3X：

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 或 69
```

!!! note ""
    感應器 U1 和 U2 連接到一條 I2C 匯流排，感應器 U3 和 U4 連接到另一條。同一匯流排上的感應器位址必須不同：一個為 `68`，另一個為 `69`。使用不同感應器時，請參考 [Klipper 文件](https://www.klipper3d.org/Config_Reference.html#temperature-sensors)。

---

## PID 校準

在乾燥機蓋子關閉的情況下執行校準：

1. 開啟 Klipper 主控台。
2. 執行命令：
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. 等待完成。
4. 將取得的係數記錄在 `iDryer.cfg` 中。

---

## 擋板伺服設定

### 1. 確定極限位置

伺服由 PWM 訊號控制。不同的伺服型號對相同的值有不同的反應 – 校準總是個別的。

**在這個階段不要將擋板固定到外殼上** – 首先確定工作範圍。

使用 Klipper 主控台中的命令檢查極限位置：

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

如果伺服卡在外殼上 – 調整範圍。

### 2. 在設定中記錄角度

檢查 `iDryer.cfg` 中的伺服部分：

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

在 `iDryer.cfg` 檔案中的 `DRY_U1` 巨集中設定角度：

```ini
variable_servo_open_angle: 40    # 開啟位置的度數
variable_servo_closed_angle: 94  # 關閉位置的度數
```

### 3. 伺服電源修正

使用多個伺服時，由於 USB 連接埠過載，可能會出現故障。

**選項 1 – 伺服電源中的電阻：**

在伺服電源中安裝 4–10 歐的電阻。在修訂版 3 的電路板上，電阻已經焊接，但具體的電阻值需要單獨選擇。

**選項 2 – 主動 USB 集線器：**

透過具有獨立電源的 USB 集線器連接控制器 – 這可以防止主機連接埠過載。

!!! note ""
    通訊穩定性問題（中斷、MCU 重新啟動）可能是由電源線或風扇的電磁干擾引起的。解決方案 – USB 電纜上的鐵氧體濾波器和與風扇並聯的 RC 浪涌保護器。請參閱「故障排除」部分。

---

## delta_high 設定

`variable_delta_high` 管理加熱器溫度和目標空氣溫度之間的差值。

校準程序：

1. 設定初始值 `variable_delta_high: 15`。
2. 使用巨集 `PA_U1` 啟動加熱。
3. 等待穩定。
4. 檢查室內溫度：
   - 如果室內為 90 °C – 該值合適。
   - 如果較低 – 增加 `variable_delta_high`。
5. 執行 30 分鐘，然後每 30–60 分鐘檢查一次。

!!! warning ""
    如果加熱器粘在塑膠外殼上 – 塑膠無法承受溫度。降低 `variable_delta_high`，用 ABS 或 ABS-CF 重新列印外殼，或更改加熱器的固定方法。

---

## G 代碼巨集

使用預先設定的巨集根據材料類型控制乾燥：

| 巨集 | 溫度 | 時間 |
|---|---|---|
| `PLA_U1` | 55 °C | 180 分鐘 |
| `PETG_U1` | 65 °C | 240 分鐘 |
| `ABS_U1` | 80 °C | 240 分鐘 |
| `PA_U1` | 90 °C | 240 分鐘 |
| `TPU_U1` | 60 °C | 300 分鐘 |
| `OFF_U1` | 關閉 | — |

啟動自訂模式：

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

手動開啟/關閉擋板：

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; 開啟
SET_SERVO SERVO=srv_U1 ANGLE=0   ; 關閉
```

---

## 替代控制演算法 – PyUnit

社群成員 [@Xatang](https://github.com/xatang) 的專案。具有可設定係數和資訊豐富圖表的乾燥和儲存參數的自動維護。

![PyUnit](../../img/xatang.jpg)

→ [GitHub 上的 PyUnit 儲存庫](https://github.com/xatang/PyUnit)
