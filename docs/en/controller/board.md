# Controller

The system is built on two board types: the main MCU unit and EXT expansion boards.

## iDryer Unit MCU

Main board with microcontroller. Controls the entire system: reads sensors, manages the heater, fan, and damper servo. Host connection via USB-C. Three RJ45 connectors for connecting EXT boards.

![MCU board](../../img/MCU_PCB.png)

## iDryer Unit EXT

Expansion board without a microcontroller. Connects to the MCU via RJ45 patch cable and is controlled directly by it. One EXT board per additional drying unit.

![EXT board](../../img/EXT_PCB.png)
