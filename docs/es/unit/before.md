# Antes del ensamblaje

Familiarícese con esta sección antes de comprar los componentes. Asegúrese de que todas las piezas y herramientas necesarias estén disponibles.

!!! warning "Seguridad eléctrica"
    El dispositivo funciona a tensión de red de 110–230 V. Antes de comenzar, lea la sección [Seguridad](safety.md).

---

## Modelos CAD

Imprima la carcasa antes de comenzar el ensamblaje. Modelos y parámetros de impresión: [CAD](cad.md).

Material de la carcasa: **ABS, ABS-CF, ABS-GF, PC o HTPLA**. No utilice PLA o PETG — no resisten la temperatura de funcionamiento.

---

## Conjunto de componentes para una unidad

### Electrónica y componentes

| Componente | Cantidad | Nota |
|---|---|---|
| Placa iDryer Unit MCU | 1 | Bloque principal; para cada bloque adicional — placa EXT |
| Elemento calefactor PTC 110–230 V, 100 W | 1 | |
| Ventilador | 1 | Para la circulación del aire |
| Sensor de temperatura NTC 100 K | 1 | O cualquier sensor compatible con Klipper/Standalone |
| Sensor de temperatura y humedad SHT3X | 1 | O cualquier sensor I2C compatible con el firmware |
| Protector térmico KSD9700 (130 °C) | 1 | O fusible térmico desechable RH130 |
| Servo para la compuerta | 1 | 3,7 g o 9 g (ver sección CAD) |
| Cable de parcheo RJ45 | Número de bloques EXT | Estándar, Cat5e o superior |

### Sujetadores y conectores

| Posición | Nota |
|---|---|
| Conectores de terminal | Según esquema de placa |
| Terminales USHVI | Para crimpar cables calefactores |
| Tubo termorretráctil | Para aislamiento de conexiones |

### Software

Antes del ensamblaje, decida el modo de funcionamiento — esto determina el firmware:

- **Klipper** — requiere una impresora con Klipper instalado.
- **Standalone** — funciona sin impresora, control por pantalla y/o portal.

Para más información sobre la selección, consulte la sección «Acerca del proyecto».

---

## Herramientas

- Herramienta de crimpa (herramienta de crimpa RJ45)
- Pinza para crimpar terminales USHVI
- Soldador (si es necesario)
- Multímetro para verificar conexiones
- Destornillador y llaves de tamaño requerido

---

## Recomendación

Ensamble el sistema **sobre una mesa sin montarlo en la carcasa** y realice pruebas iniciales:

1. Conecte el elemento calefactor, ventilador, sensores y servo a la placa.
2. Cargue el firmware y verifique que cada componente funcione correctamente.
3. Solo después de una prueba exitosa debe montar los componentes en la carcasa.

Durante el montaje final, acorte los cables del sensor y alimentación a la longitud mínima necesaria.