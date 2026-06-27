# DIY控制器

为想要自己组建控制器的人士准备的部分 – 无需预制MCU板。

---

## RP2040引脚分布

![RP2040引脚分布](../../img/rp2040_pinout.png)

---

## RJ45连接器引脚分布

三个RJ45连接器（U6/U7/U8）用于连接EXT块。每个连接器传输：SRV（舵机）、T（温度传感器）、FAN（风扇）、H（加热器）、SDA/SCL（I²C）、+5 V、GND。

![RJ45引脚分布](../../img/rj45_pinout.png)

---

## 原型板（EasyEDA）

最低预算，手工组装在面包板上。功能性原型 – 不适用于永久运行。

→ [EasyEDA项目](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## 打印机板 + SSR

用作MCU的旧打印机板和用于控制110–230 V负载的固态继电器。需要可用的GPIO输出和兼容的Klipper固件。
