# Klipper：配置

本页描述在 Klipper 环境中安装配置文件和配置 iDryer Unit。控制器固件必须提前安装 – 请参阅「固件」部分。

---

## 配置：mcu 或 second_mcu

iDryer Unit 通过两种方式连接到 Klipper：

=== "mcu（独立主机）"

    iDryer Unit 作为独立主机上的主要 MCU 工作（例如仅用于干燥机的 Raspberry Pi）。配置部分：

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu（与打印机共享）"

    iDryer Unit 作为单个 Klipper 实例中的第二个 MCU 连接到打印机主机。配置部分：

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    在这种情况下，所有引脚都获得 `iDryer:` 前缀，例如 `iDryer:H_U1`。

---

## 安装配置文件

### 1. 通过 SSH 连接到主机

```bash
ssh user_name@printer_address
```

### 2. 导航到配置目录

```bash
cd ~/printer_data/config/
```

!!! note ""
    路径可能不同：`~/klipper_config/` 或 `~/printer_data/config/` 取决于安装版本。检查目录中是否存在 `printer.cfg` 文件。

### 3. 下载并运行安装脚本

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

脚本将创建一个包含必要配置文件的目录。

### 手动安装配置文件

如果无法通过脚本安装，请从 GitHub 下载项目存档，并通过 Fluidd 或 Mainsail 界面传输所需的配置文件。

[从 GitHub 下载项目存档](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. 在 printer.cfg 中包含配置

在 `printer.cfg` 文件的开头添加一行：

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. 在 iDryer.cfg 中指定串行 ID

获取控制器 ID：

```bash
ls /dev/serial/by-id/*
```

在 `iDryer.cfg` 文件中的 `[mcu iDryer]` 部分，将占位符替换为获得的 ID：

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. 连接附加模块（U2–U4）

默认情况下，模块 U1 已连接。在 `iDryer.cfg` 中取消注释所需行：

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## 硬件配置

### 加热器

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

### 风扇

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# 使用 second_mcu 时：pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### 温度和湿度传感器

示例使用 I2C 总线上的 SHT3X：

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 或 69
```

!!! note ""
    传感器 U1 和 U2 连接到一条 I2C 总线，传感器 U3 和 U4 连接到另一条。同一总线上的传感器地址必须不同：一个为 `68`，另一个为 `69`。使用不同传感器时，请参考 [Klipper 文档](https://www.klipper3d.org/Config_Reference.html#temperature-sensors)。

---

## PID 校准

在干燥机盖子关闭的情况下执行校准：

1. 打开 Klipper 控制台。
2. 执行命令：
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. 等待完成。
4. 将获得的系数记录在 `iDryer.cfg` 中。

---

## 挡板伺服配置

### 1. 确定极限位置

伺服由 PWM 信号控制。不同的伺服型号对相同的值有不同的反应 – 校准总是个别的。

**在这个阶段不要将挡板固定到外壳上** – 首先确定工作范围。

使用 Klipper 控制台中的命令检查极限位置：

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

如果伺服卡在外壳上 – 调整范围。

### 2. 在配置中记录角度

检查 `iDryer.cfg` 中的伺服部分：

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

在 `iDryer.cfg` 文件中的 `DRY_U1` 宏中设置角度：

```ini
variable_servo_open_angle: 40    # 开启位置的度数
variable_servo_closed_angle: 94  # 关闭位置的度数
```

### 3. 伺服电源修正

使用多个伺服时，由于 USB 端口过载，可能会出现故障。

**选项 1 – 伺服电源中的电阻：**

在伺服电源中安装 4–10 欧的电阻。在修订版 3 的电路板上，电阻已经焊接，但具体的电阻值需要单独选择。

**选项 2 – 有源 USB 集线器：**

通过具有独立电源的 USB 集线器连接控制器 – 这可以防止主机端口过载。

!!! note ""
    通信稳定性问题（中断、MCU 重启）可能是由电源线或风扇的电磁干扰引起的。解决方案 – USB 电缆上的铁氧体滤波器和与风扇并联的 RC 浪涌保护器。请参阅「故障排除」部分。

---

## delta_high 配置

`variable_delta_high` 管理加热器温度和目标空气温度之间的差值。

校准程序：

1. 设置初始值 `variable_delta_high: 15`。
2. 使用宏 `PA_U1` 启动加热。
3. 等待稳定。
4. 检查室内温度：
   - 如果室内为 90 °C – 该值合适。
   - 如果较低 – 增加 `variable_delta_high`。
5. 运行 30 分钟，然后每 30–60 分钟检查一次。

!!! warning ""
    如果加热器粘在塑料外壳上 – 塑料无法承受温度。降低 `variable_delta_high`，用 ABS 或 ABS-CF 重新打印外壳，或更改加热器的固定方法。

---

## G 代码宏

使用预配置的宏根据材料类型控制干燥：

| 宏 | 温度 | 时间 |
|---|---|---|
| `PLA_U1` | 55 °C | 180 分钟 |
| `PETG_U1` | 65 °C | 240 分钟 |
| `ABS_U1` | 80 °C | 240 分钟 |
| `PA_U1` | 90 °C | 240 分钟 |
| `TPU_U1` | 60 °C | 300 分钟 |
| `OFF_U1` | 关闭 | — |

启动自定义模式：

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

手动打开/关闭挡板：

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; 打开
SET_SERVO SERVO=srv_U1 ANGLE=0   ; 关闭
```

---

## 替代控制算法 – PyUnit

社区成员 [@Xatang](https://github.com/xatang) 的项目。具有可配置系数和信息丰富图表的干燥和存储参数的自动维护。

![PyUnit](../../img/xatang.jpg)

→ [GitHub 上的 PyUnit 存储库](https://github.com/xatang/PyUnit)
