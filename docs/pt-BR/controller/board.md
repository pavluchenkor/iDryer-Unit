# Controlador

O sistema é construído sobre dois tipos de placas: uma unidade MCU principal e blocos de expansão EXT.

## iDryer Unit MCU

A placa principal com microcontrolador. Gerencia todo o sistema: lê sensores, controla o aquecedor, ventilador e servo da válvula de controle. A conexão com o host é via USB-C. Três conectores RJ45 para conectar blocos EXT.

![Placa MCU](../../img/MCU_PCB.png)

## iDryer Unit EXT

Placa de expansão sem microcontrolador. Conecta-se ao MCU via cabo patch RJ45 e é controlada diretamente por ele. Cada bloco de secagem adicional requer uma placa EXT.

![Placa EXT](../../img/EXT_PCB.png)
