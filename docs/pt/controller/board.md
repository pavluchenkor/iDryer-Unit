# Controlador

O sistema é construído em dois tipos de placas: unidade principal MCU e blocos de extensão EXT.

## iDryer Unit MCU

Placa principal com microcontrolador. Controla todo o sistema: lê sensores, gerencia o aquecedor, ventilador e servomotor da comporta. Conexão com o host via USB-C. Três conectores RJ45 para conectar blocos EXT.

![Placa MCU](../../img/MCU_PCB.png)

## iDryer Unit EXT

Placa de expansão sem microcontrolador. Conecta-se ao MCU via cabo patch RJ45 e é controlada diretamente por ele. Um bloco EXT para cada unidade de secagem adicional.

![Placa EXT](../../img/EXT_PCB.png)
