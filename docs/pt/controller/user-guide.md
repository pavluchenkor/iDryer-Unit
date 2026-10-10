# Klipper: Configuração

Esta página descreve a instalação de arquivos de configuração e a configuração do iDryer Unit no ambiente Klipper. O firmware do controlador deve ser instalado previamente – consulte a seção « Firmware ».

---

## Configuração: mcu ou second_mcu

iDryer Unit se conecta ao Klipper de duas formas:

=== "mcu (host separado)"

    iDryer Unit funciona como MCU principal em um host separado (por exemplo, Raspberry Pi apenas para o secador). Seção de configuração:

    ```ini
    [mcu]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

=== "second_mcu (compartilhado com a impressora)"

    iDryer Unit se conecta ao host da impressora como um segundo MCU em uma instância Klipper. Seção de configuração:

    ```ini
    [mcu iDryer]
    serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
    ```

    Neste caso, todos os pinos recebem o prefixo `iDryer:`, por exemplo `iDryer:H_U1`.

---

## Instalação de arquivos de configuração

### 1. Conectar-se ao host via SSH

```bash
ssh user_name@printer_address
```

### 2. Navegar para o diretório de configuração

```bash
cd ~/printer_data/config/
```

!!! note ""
    O caminho pode variar: `~/klipper_config/` ou `~/printer_data/config/` dependendo da versão da instalação. Verifique que o arquivo `printer.cfg` está no diretório.

### 3. Baixar e executar o script de instalação

=== "mcu"

    ```bash
    wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_mcu.sh
    chmod +x download_iDryer_mcu.sh
    ./download_iDryer_mcu.sh
    ```

=== "second_mcu"

    ```bash
    wget https://raw.githubusercontent.com/pavluchenkor/iDryer-Unit/main/sh/download_iDryer_second_mcu.sh
    chmod +x download_iDryer_second_mcu.sh
    ./download_iDryer_second_mcu.sh
    ```

O script cria um diretório com os arquivos de configuração necessários.

### Instalação manual de arquivos de configuração

Se a instalação via script não for possível, baixe o arquivo do projeto no GitHub e transfira os arquivos de configuração necessários através da interface Fluidd ou Mainsail.

[Baixar arquivo do projeto no GitHub](https://github.com/pavluchenkor/iDryer-Unit/archive/refs/heads/main.zip)

### 4. Incluir configuração em printer.cfg

Adicione uma linha no início do arquivo `printer.cfg`:

=== "mcu"
    ```ini
    [include iDryer_mcu/iDryer.cfg]
    ```

=== "second_mcu"
    ```ini
    [include iDryer_second_mcu/iDryer.cfg]
    ```

### 5. Especificar ID de série em iDryer.cfg

Obtenha o ID do controlador:

```bash
ls /dev/serial/by-id/*
```

No arquivo `iDryer.cfg`, na seção `[mcu iDryer]`, substitua o marcador de posição pelo ID obtido:

```ini
[mcu iDryer]
serial: /dev/serial/by-id/usb-Klipper_rp2040_XXXXXXXXXXXXXXXX-XXXX
```

### 6. Conexão de módulos adicionais (U2–U4)

Por padrão, o módulo U1 está conectado. Descomente as linhas necessárias em `iDryer.cfg`:

```ini
[include U1.cfg]
# [include U2.cfg]
# [include U3.cfg]
# [include U4.cfg]
```

---

## Configuração de hardware

### Elemento aquecedor

```ini
[heater_generic iDryer_U1_Heater]
heater_pin: H_U1
max_power: 1
sensor_type: NTC 100K MGB18-104F39050L32
sensor_pin: T_U1
control: pid
pwm_cycle_time: 0.3
min_temp: 0
max_temp: 120
pid_Kp: 32.923
pid_Ki: 5.628
pid_Kd: 48.150
```

### Ventilador

```ini
[heater_fan Fan_U1]
fan_speed: 1
pin: FAN_U1
# ao usar second_mcu: pin: iDryer:FAN_U1
heater: iDryer_U1_Heater
heater_temp: 55
```

### Sensor de temperatura e umidade

O exemplo usa SHT3X no barramento I2C:

```ini
[temperature_sensor iDryer_U1_Air]
i2c_mcu: iDryer
sensor_type: SHT3X
i2c_bus: i2c0f
i2c_address: 68  # 68 ou 69
```

!!! note ""
    Os sensores U1 e U2 estão conectados a um barramento I2C, os sensores U3 e U4 a outro. Os endereços dos sensores no mesmo barramento devem ser diferentes: um em `68`, outro em `69`. Ao usar um sensor diferente, consulte a [documentação do Klipper](https://www.klipper3d.org/Config_Reference.html#temperature-sensors).

---

## Calibração PID

Execute a calibração com a tampa do secador fechada:

1. Abra o console do Klipper.
2. Execute o comando:
   ```
   PID_CALIBRATE HEATER=iDryer_U1_Heater TARGET=100
   ```
3. Aguarde a conclusão.
4. Registre os coeficientes obtidos em `iDryer.cfg`.

---

## Configuração do servo do amortecedor

### 1. Determinação das posições extremas

O servo é controlado por um sinal PWM. Diferentes modelos de servos respondem de maneiras diferentes aos mesmos valores – a calibração é sempre individual.

**Não fixe o amortecedor na caixa** neste estágio – primeiro determine a faixa de operação.

Verifique as posições extremas com comandos no console Klipper:

```
SET_SERVO SERVO=srv_U1 ANGLE=0
SET_SERVO SERVO=srv_U1 ANGLE=90
```

Se o servo estiver preso na caixa – ajuste a faixa.

### 2. Registrar ângulos na configuração

Verifique a seção servo em `iDryer.cfg`:

```ini
[servo srv_U1]
pin: SRV_U1
maximum_servo_angle: 180
minimum_pulse_width: 0.00055
maximum_pulse_width: 0.002
```

No arquivo `iDryer.cfg`, na macro `DRY_U1`, defina os ângulos:

```ini
variable_servo_open_angle: 40    # graus da posição aberta
variable_servo_closed_angle: 94  # graus da posição fechada
```

### 3. Correção de alimentação do servo

Ao usar múltiplos servos, falhas são possíveis devido à sobrecarga da porta USB.

**Opção 1 – Resistor na alimentação do servo:**

Instale um resistor de 4–10 Ohms na alimentação do servo. Nas placas de revisão 3, os resistores já estão soldados, mas o valor de resistência exato deve ser selecionado individualmente.

**Opção 2 – Hub USB ativo:**

Conecte o controlador através de um hub USB com alimentação separada – isto evita uma sobrecarga da porta do host.

!!! note ""
    Problemas de estabilidade de comunicação (interrupções, reinicializações do MCU) podem ser causados por interferências eletromagnéticas de cabos de alimentação ou ventilador. Soluções – ferrita no cabo USB e supressor RC em paralelo com o ventilador. Consulte a seção « Solução de problemas ».

---

## Configuração de delta_high

`variable_delta_high` gerencia a diferença entre a temperatura do aquecedor e a temperatura do ar alvo.

Procedimento de calibração:

1. Defina o valor inicial `variable_delta_high: 15`.
2. Inicie o aquecimento com a macro `PA_U1`.
3. Aguarde a estabilização.
4. Verifique a temperatura na câmara:
   - Se estiver a 90 °C na câmara – o valor é adequado.
   - Se for menor – aumente `variable_delta_high`.
5. Deixe funcionar 30 minutos, depois verifique a cada 30–60 minutos.

!!! warning ""
    Se o elemento aquecedor grudar na caixa de plástico – o plástico não aguenta a temperatura. Reduza `variable_delta_high`, reimprima a caixa em ABS ou ABS-CF, ou altere o método de fixação do aquecedor.

---

## Macros de código G

Use macros pré-configuradas para controlar a secagem por tipo de material:

| Macro | Temperatura | Tempo |
|---|---|---|
| `PLA_U1` | 55 °C | 180 min |
| `PETG_U1` | 65 °C | 240 min |
| `ABS_U1` | 80 °C | 240 min |
| `PA_U1` | 90 °C | 240 min |
| `TPU_U1` | 60 °C | 300 min |
| `OFF_U1` | desligado | — |

Iniciando modo personalizado:

```gcode
DRY_U1 UNIT_TEMPERATURE=70 HUMIDITY=10 TIME=180
```

Abertura/fechamento manual do amortecedor:

```gcode
SET_SERVO SERVO=srv_U1 ANGLE=90  ; abrir
SET_SERVO SERVO=srv_U1 ANGLE=0   ; fechar
```

---

## Algoritmo de controle alternativo – PyUnit

Projeto de um membro da comunidade [@Xatang](https://github.com/xatang). Manutenção automática de parâmetros de secagem e armazenamento com coeficientes configuráveis e gráficos informativos.

![PyUnit](../../img/xatang.jpg)

→ [Repositório PyUnit no GitHub](https://github.com/xatang/PyUnit)
