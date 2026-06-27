# Controlador DIY

Una sección para quienes desean construir el controlador por sí mismos – sin una placa MCU prefabricada.

---

## Asignación de pines RP2040

![Asignación de pines RP2040](../../img/rp2040_pinout.png)

---

## Asignación de pines de conectores RJ45

Tres conectores RJ45 (U6/U7/U8) para conectar bloques EXT. Cada conector transmite: SRV (servomotor), T (sensor de temperatura), FAN (ventilador), H (elemento calefactor), SDA/SCL (I²C), +5 V, GND.

![Asignación de pines RJ45](../../img/rj45_pinout.png)

---

## Placa de prototipo (EasyEDA)

Presupuesto mínimo, montado manualmente en una placa de pruebas. Prototipo funcional – no está diseñado para operación permanente.

→ [Proyecto EasyEDA](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Placa de impresora + SSR

Placa de impresora antigua como MCU y relés de estado sólido para controlar la carga 110–230 V. Requiere salidas GPIO disponibles y firmware Klipper compatible.
