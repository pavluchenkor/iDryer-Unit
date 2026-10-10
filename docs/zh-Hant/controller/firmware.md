# Klipper: 韌體安裝

本頁描述了在 iDryer Unit 控制器（RP2040 上的 MCU）上安裝 Klipper 韌體。

韌體安裝分為兩個步驟:

1. 安裝引導加載程式 **Katapult** — 允許通過 USB 重新編程 Klipper，無需進入 BOOT 模式。
2. 通過 Katapult 安裝 **Klipper**。

---

## 要求

- 已安裝 Klipper 的主機（Raspberry Pi 或類似設備）。
- USB 資料傳輸線。
- 對主機終端的 SSH 訪問。

---

## 第 1 部分: Katapult 安裝

### 1. 準備環境

確保系統已更新，並安裝依賴項:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. 下載 Katapult

```bash
git clone https://github.com/Arksine/katapult
```

### 3. 構建配置

```bash
cd katapult
make menuconfig
```

根據螢幕截圖選擇參數:

![Katapult menuconfig](../../img/011.png)

!!! danger "重要"
    確保正確選擇了配置。用錯誤的構建覆蓋引導加載程式將導致設備無法工作 – 需要程式員恢復。

### 4. 編譯

```bash
make
```

### 5. 將控制器置於 BOOT 模式

執行以下兩個步驟之一:

- 按住 `BOOT`，連接 USB，釋放 `BOOT`（USB 已斷開）。
- 按住 `BOOT`，短按 `RESET`，釋放 `BOOT`。

### 6. 確定控制器的 USB ID

```bash
lsusb
```

輸出將顯示一行，如:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. 編程 Katapult

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## 第 2 部分: Klipper 安裝

### 8. Klipper 構建配置

```bash
cd ~/klipper/
make clean
make menuconfig
```

根據螢幕截圖選擇參數:

![Klipper menuconfig](../../img/016.png)

### 9. 編譯 Klipper

```bash
make
```

### 10. 安裝 Python 庫

```bash
pip3 install pyserial
```

### 11. 確定序列 ID

重新連接 USB 或按 `RESET`，等待設備出現:

```bash
ls /dev/serial/by-id/*
```

預期結果:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. 通過 Katapult 編程 Klipper

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. 驗證結果

```bash
ls /dev/serial/by-id/*
```

如果編程成功，設備 ID 將包含 `Klipper`:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## 下一步

安裝 iDryer 配置文件 – 「配置」部分。
