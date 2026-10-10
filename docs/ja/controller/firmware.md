# Klipper: ファームウェアのインストール

このページでは、Klipper ファームウェアを iDryer Unit コントローラー (RP2040 上の MCU) にインストールする方法について説明しています。

ファームウェアのインストールは 2 つのステップで行われます:

1. ブートローダー **Katapult** のインストール — USB を介して BOOT モードに入らずに Klipper を再プログラムできます。
2. Katapult 経由で **Klipper** をインストールします。

---

## 要件

- Klipper がインストールされたホスト (Raspberry Pi または同等)。
- データ転送用 USB ケーブル。
- ホストのターミナルへの SSH アクセス。

---

## パート 1: Katapult のインストール

### 1. 環境の準備

システムが最新であることを確認し、依存関係をインストールしてください:

```bash
sudo apt update
sudo apt install git build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib cmake python3 python3-pip python3-serial \
  usbutils dfu-util
```

### 2. Katapult をダウンロード

```bash
git clone https://github.com/Arksine/katapult
```

### 3. ビルド構成

```bash
cd katapult
make menuconfig
```

スクリーンショットに従ってパラメーターを選択してください:

![Katapult menuconfig](../../img/011.png)

!!! danger "重要"
    構成が正しく選択されていることを確認してください。不正なビルドでブートローダーを上書きするとデバイスが機能しなくなります – 復旧にはプログラマーが必要です。

### 4. コンパイル

```bash
make
```

### 5. コントローラーを BOOT モードに移行

以下のいずれかの手順を実行してください:

- `BOOT` を押し続け、USB を接続し、`BOOT` を離してください (USB が切断されている状態)。
- `BOOT` を押し続け、`RESET` を短く押し、`BOOT` を離してください。

### 6. コントローラーの USB ID を決定

```bash
lsusb
```

出力には以下のような行が表示されます:

```
Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
```

### 7. Katapult をプログラム

```bash
make flash FLASH_DEVICE=2e8a:0003
```

---

## パート 2: Klipper のインストール

### 8. Klipper ビルド構成

```bash
cd ~/klipper/
make clean
make menuconfig
```

スクリーンショットに従ってパラメーターを選択してください:

![Klipper menuconfig](../../img/016.png)

### 9. Klipper をコンパイル

```bash
make
```

### 10. Python ライブラリをインストール

```bash
pip3 install pyserial
```

### 11. シリアル ID を決定

USB を再度接続するか、`RESET` を押し、デバイスが表示されるのを待ってください:

```bash
ls /dev/serial/by-id/*
```

予想される結果:

```
/dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 12. Katapult 経由で Klipper をプログラム

```bash
cd ~/katapult/scripts
python3 flashtool.py -d /dev/serial/by-id/usb-katapult_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 13. 結果を確認

```bash
ls /dev/serial/by-id/*
```

プログラミングが成功すると、デバイス ID に `Klipper` が含まれます:

```
/dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

---

## 次のステップ

iDryer 設定ファイルのインストール – 「構成」セクション。
