# Kontrolér

Systém je postaven na dvou typech desek: hlavní jednotka MCU a rozšiřující jednotky EXT.

## iDryer Unit MCU

Hlavní deska s mikrokontrolérem. Řídí celý systém: čte senzory, řídí topný prvek, ventilátor a servopohon klapky. Připojení k hostiteli — USB-C. Tři konektory RJ45 pro připojení jednotek EXT.

![Deska MCU](../../img/MCU_PCB.png)

## iDryer Unit EXT

Rozšiřující deska bez mikrokontroléru. Připojuje se k MCU přes RJ45 patch kabel a je přímo jím řízena. Na každý další sušící blok — jedna deska EXT.

![Deska EXT](../../img/EXT_PCB.png)
