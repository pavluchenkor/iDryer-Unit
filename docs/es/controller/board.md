# Controlador

El sistema se basa en dos tipos de placas: la unidad MCU principal y los módulos de expansión EXT.

## iDryer Unit MCU

Placa principal con microcontrolador. Controla todo el sistema: lee los sensores, gestiona el calentador, el ventilador y el servo de la compuerta. La conexión al host es mediante USB-C. Tres conectores RJ45 para conectar los módulos EXT.

![Placa MCU](../../img/MCU_PCB.png)

## iDryer Unit EXT

Placa de expansión sin microcontrolador. Se conecta a la MCU mediante un cable de conexión RJ45 y es controlada directamente por ella. Cada bloque de secado adicional requiere una placa EXT.

![Placa EXT](../../img/EXT_PCB.png)
