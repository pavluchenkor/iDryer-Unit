# iDryer Unit

iDryer Unit — sistema modular de secado y almacenamiento de filamento para impresoras 3D. Carcasa imprimible para 1 o 2 carretes, hasta cuatro cámaras de secado independientes en un solo sistema.

La temperatura de secado es de hasta 90 °C en la carcasa estándar, hasta 110 °C al usar materiales termoresistentes para la carcasa. Los modos soportados son secado (Drying), almacenamiento (Storage) y perfiles (Profile).

![iDryer Unit](../img/iDryer.png)

## Para quién es este proyecto

iDryer Unit es un proyecto DIY para quienes desean un secador confiable con control real sobre el proceso, no un dispositivo comercial completamente cerrado.

Todos los componentes son estándar y accesibles: ventilador, calentador PTC, sensor de temperatura y humedad, servomotor, Thermal Protector. Cualquiera de ellos puede ser reemplazado sin buscar piezas de repuesto exclusivas. A diferencia de la mayoría de los secadores de producción en serie, aquí no hay nada que no se pueda reparar o mejorar.

La carcasa se imprime en cualquier impresora 3D. Los esquemas, firmware y documentación están abiertos.

![iDryer Unit con carrete](../img/iDryerWithSpool.png)

---

## Dos modos de funcionamiento

Elija un escenario antes de comenzar el montaje: del mismo dependen el firmware y el método de control.

### Klipper

![Klipper](../img/klipper222252.jpg)

El controlador Unit se conecta al host de la impresora y funciona como `[mcu]` o `[second_mcu]` en Klipper. El control se realiza a través de la interfaz Fluidd / Mainsail, macros G-code, integración con la configuración principal de la impresora.

Están disponibles funciones adicionales de Klipper: notificaciones a través de bot de Telegram (estado de secado, finalización de ciclo, sobrecalentamiento), tira LED direccionable para indicación visual de modos, registro automático de eventos.

Es adecuado si:

- ya tiene Klipper funcionando;
- desea controlar el secador directamente desde la interfaz de la impresora;
- necesita integración profunda con macros y programación.

→ [Firmware Klipper](controller/firmware.md)

### Standalone

![iDryer Portal](../img/portal_screenshot.png)

El controlador funciona de forma independiente: su propio firmware, control a través del portal en la nube [portal.idryer.org](https://portal.idryer.org/) y aplicación móvil. Opcionalmente — control local a través de pantalla OLED y encoder. Se admiten básculas (control del resto de filamento por peso) y RFID (identificación automática de carrete).

Es adecuado si:

- desea un secador separado de la impresora;
- necesita control remoto a través de una aplicación móvil o portal;
- utiliza varios secadores con un único punto de control.

<!-- → [Standalone: sobre firmware](../../../iDryerRP2040/README.md) -->

---

## Características

| Parámetro | Valor |
|---|---|
| Temperatura de secado | hasta 90 °C (hasta 110 °C con carcasa termoresistente) |
| Modos | Drying, Storage, Profile (Standalone) |
| Número de cámaras | 1–4 (MCU + hasta 3 × EXT) |
| Conexión de módulos | cables de parche RJ45 |
| Thermal Protector | KSD9700 (130 °C) |
| Protección de corriente | fusible de 2 A |
| Elemento calefactor | PTC, aislamiento eléctrico completo |
| Carretes | 1 o 2 por cámara; ancho hasta 85 mm, diámetro hasta 200 mm |
| Variantes de carcasa | Para 1 carrete y para 2 carretes |
| Material de carcasa | Imprimible, ABS / ABS-CF / PC / HTPLA |
| Sensor de humedad | SHT3X o cualquiera soportado por el firmware |
| Indicación LED | salida para tira LED direccionable en la placa MCU |

---

## Modos de funcionamiento

**Drying (secado)** — establezca la temperatura y el tiempo. Al finalizar el ciclo, el sistema cambia automáticamente al modo Storage.

**Storage (almacenamiento)** — mantiene la temperatura establecida y el nivel mínimo de humedad. El calentador y ventilador se encienden cuando se exceden los parámetros establecidos.

**Profile (perfil)** — escenarios personalizados con parámetros configurables y transiciones entre modos. Disponible en firmware Standalone.

---

## Control de humedad

Cada cámara está equipada con una compuerta controlada. El servomotor abre la compuerta según un horario para evacuar el aire saturado de humedad y la cierra para retener el calor. El sensor SHT3X monitorea continuamente la temperatura y la humedad dentro de la cámara — el firmware corrige el modo de funcionamiento de la compuerta y el calentador en función de estos datos.

![Compuerta iDryer Unit](../img/IMG_2168.jpg)
![Mecanismo de compuerta](../img/IMG_2170.jpg)

---

## Arquitectura del sistema

Un bloque **iDryer Unit MCU** gestiona el sistema. Hasta tres bloques **iDryer Unit EXT** sin microcontrolador propio se conectan directamente a través de RJ45.

```
              ┌— RJ45 — [EXT U2]
[MCU] ————————┼— RJ45 — [EXT U3]
              └— RJ45 — [EXT U4]
```

Cada bloque es una cámara de secado independiente con su propio sensor, calentador, ventilador y servomotor de compuerta.

---

## Seguridad incorporada

- **KSD9700** — Thermal Protector a 130 °C: abre físicamente el circuito del calentador cuando se produce sobrecalentamiento.
- **Fusible de 2 A** — protección en caso de corrientes de emergencia.
- **Calentador PTC** — la carcasa del calentador no está bajo tensión.
- **Protección de software** — Klipper (o firmware Standalone) controla la temperatura, la presencia de sensores y desactiva el calentamiento en caso de error.

!!! danger "Trabajo con voltaje de red"
    El dispositivo contiene componentes bajo voltaje de 110–230 V. Desconecte la alimentación antes de cualquier trabajo con cableado eléctrico. Para obtener más detalles, consulte la sección [Seguridad](unit/safety.md).

---

## Cómo comenzar

1. **Imprima la carcasa** → [CAD: modelos para imprimir](unit/cad.md)
2. **Prepare los componentes** → [Antes del montaje](unit/before.md)
3. **Ensamblen el dispositivo** → [Montaje](unit/assembly.md)
4. **Instale el firmware**:
   - Klipper → [Firmware Klipper](controller/firmware.md)
   - Standalone → [Instalación de Standalone](../controller-v2/installation/firmware-install/)
5. **Configure el sistema** → [Guía del usuario](controller/user-guide.md)
