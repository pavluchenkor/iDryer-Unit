# Klipper: 固件安装

本页描述了在 iDryer Unit 控制器（RP2040 上的 MCU）上安装 Klipper 固件。

固件安装分为两个步骤:

1. 安装引导加载程序 **Katapult** — 允许通过 USB 重新编程 Klipper，无需进入 BOOT 模式。
2. 通过 Katapult 安装 **Klipper**。

---

## 要求

- 已安装 Klipper 的主机（Raspberry Pi 或类似设备）。
- USB 数据传输线。
- 对主机终端的 SSH 访问。

---

## 第 1 部分: Katapult 安装

### 1. 准备环境

确保系统已更新，并安装依赖项:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. 下载 Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. 构建配置

```bash
cd katapult
make menuconfig
```

根据屏幕截图选择参数:

![Katapult menuconfig](../../img/011.png)

!!! danger "重要"
    确保正确选择了配置。用错误的构建覆盖引导加载程序将导致设备无法工作 – 需要程序员恢复。

### 4. 编译

```bash
make
```

### 5. 将控制器置于 BOOT 模式

执行以下两个步骤之一:

- 按住 `BOOT`，连接 USB，释放 `BOOT`（USB 已断开）。
- 按住 `BOOT`，短按 `RESET`，释放 `BOOT`。

### 6. 确定控制器的 USB ID

```bash
lsusb
```

输出将显示一行，如:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. 编程 Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## 第 2 部分: Klipper 安装

### 8. Klipper 构建配置

```bash
cd ~/klipper/
make clean
make menuconfig
```

根据屏幕截图选择参数:

![Klipper menuconfig](../../img/016.png)

### 9. 编译 Klipper

```bash
make
```

### 10. 安装 Python 库

```bash
pip3 install pyserial
```

### 11. 确定串行 ID

重新连接 USB 或按 `RESET`，等待设备出现:

```bash
ls /dev/serial/by-id/*
```

预期结果:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. 通过 Katapult 编程 Klipper

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. 验证结果

```bash
ls /dev/serial/by-id/*
```

如果编程成功，设备 ID 将包含 `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## 下一步

安装 iDryer 配置文件 – 「配置」部分。
