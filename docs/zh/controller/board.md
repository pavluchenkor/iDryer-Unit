# 控制器

系统由两种类型的电路板组成：主控板 MCU 和扩展板 EXT。

## iDryer Unit MCU

具有微控制器的主电路板。管理整个系统：读取传感器、控制加热器、风扇和挡板伺服驱动器。与主机的连接为 USB-C。三个 RJ45 接口用于连接 EXT 板。

![MCU 电路板](../../img/MCU_PCB.png)

## iDryer Unit EXT

没有微控制器的扩展板。通过 RJ45 网线连接到 MCU 并由其直接控制。每个额外的干燥模块需要一块 EXT 板。

![EXT 电路板](../../img/EXT_PCB.png)
