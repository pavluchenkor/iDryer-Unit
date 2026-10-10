# Controlador DIY

Uma seção para quem deseja construir o controlador por conta própria – sem uma placa MCU pronta.

---

## Pinagem RP2040

![Pinagem RP2040](../../img/rp2040_pinout.png)

---

## Pinagem dos conectores RJ45

Três conectores RJ45 (U6/U7/U8) para conectar blocos EXT. Cada conector transmite: SRV (servo), T (sensor de temperatura), FAN (ventilador), H (aquecedor), SDA/SCL (I²C), +5 V, GND.

![Pinagem RJ45](../../img/rj45_pinout.png)

---

## Placa de Prototipagem (EasyEDA)

Orçamento mínimo, montado manualmente em placa de ensaio. Protótipo funcional – não foi projetado para operação permanente.

→ [Projeto EasyEDA](https://oshwlab.com/pavluchenko.r/2channel-dimmer-bread-board)

---

## Placa de Impressora + SSR

Placa de impressora antiga como MCU e relés de estado sólido para controlar carga de 110–230 V. Requer saídas GPIO disponíveis e firmware Klipper compatível.
