# Antes da montagem

Familiarize-se com esta seção antes de comprar os componentes. Certifique-se de que todas as peças e ferramentas necessárias estão disponíveis.

!!! warning "Segurança elétrica"
    O dispositivo funciona sob tensão de rede de 110–230 V. Antes de começar, leia a seção [Segurança](safety.md).

---

## Modelos CAD

Imprima o gabinete antes de começar a montagem. Modelos e parâmetros de impressão: [CAD](cad.md).

Material do gabinete: **ABS, ABS-CF, ABS-GF, PC ou HTPLA**. Não use PLA ou PETG — não suportam a temperatura de funcionamento.

---

## Conjunto de componentes para uma unidade

### Eletrônica e componentes

| Componente | Quantidade | Observação |
|---|---|---|
| Placa iDryer Unit MCU | 1 | Bloco principal; para cada bloco adicional — placa EXT |
| Elemento aquecedor PTC 110–230 V, 100 W | 1 | |
| Ventilador | 1 | Para circulação de ar |
| Sensor de temperatura NTC 100 K | 1 | Ou qualquer sensor suportado por Klipper/Standalone |
| Sensor de temperatura e umidade SHT3X | 1 | Ou qualquer sensor I2C suportado pelo firmware |
| Protetor térmico KSD9700 (130 °C) | 1 | Ou fusível térmico descartável RH130 |
| Servo para damper | 1 | 3,7 g ou 9 g (ver seção CAD) |
| Cabo de patch RJ45 | Número de blocos EXT | Padrão, Cat5e ou superior |

### Fixadores e conectores

| Posição | Observação |
|---|---|
| Conectores de terminal | De acordo com o esquema da placa |
| Terminais USHVI | Para crimpar cabos aquecedores |
| Tubo de encolhimento térmico | Para isolamento de conexões |

### Software

Antes da montagem, decida o modo de operação — isso determina o firmware:

- **Klipper** — requer uma impressora com Klipper instalado.
- **Standalone** — funciona sem impressora, controle via tela e/ou portal.

Para mais informações sobre a seleção, consulte a seção «Sobre o projeto».

---

## Ferramentas

- Ferramenta de crimpa (ferramenta de crimpa RJ45)
- Alicate para crimpar terminais USHVI
- Ferro de solda (se necessário)
- Multímetro para verificar conexões
- Chave de fenda e chaves do tamanho necessário

---

## Recomendação

Monta o sistema **sobre uma mesa sem montá-lo no gabinete** e realizar testes iniciais:

1. Conecte o elemento aquecedor, ventilador, sensores e servo à placa.
2. Carregue o firmware e verifique se cada componente funciona corretamente.
3. Apenas após um teste bem-sucedido, monte os componentes no gabinete.

Durante a montagem final, encurte os cabos do sensor e da alimentação para o comprimento mínimo necessário.