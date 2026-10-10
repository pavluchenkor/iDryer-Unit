# Ensamblaje

Esta página describe el ensamblaje físico de la carcasa y la electrónica de iDryer Unit.

!!! danger "Advertencia! Trabajos con equipos eléctricos de alta tensión"
    Antes de comenzar, lea detenidamente las medidas de seguridad.

    iDryer Unit contiene componentes que funcionan bajo tensión de red de 110–230 V. Una conexión o funcionamiento incorrecto puede causar electrocución, incendio o falla del dispositivo.

!!! danger "Trabajo con tensión de red"
    Todo trabajo de conexión a 110–230 V debe realizarse con el dispositivo apagado. Antes del primer encendido, asegúrese de que todas las conexiones estén aisladas correctamente. Para obtener más detalles, consulte la sección [Seguridad](safety.md).

!!! warning "Medidas de seguridad generales"
    - Desconecte el dispositivo antes de cualquier trabajo.
    - No toque piezas conductoras expuestas.
    - Verifique la integridad del cableado antes de encender.
    - No opere el dispositivo con carcasa dañada o cables desnudos.
    - Nunca deje el dispositivo encendido sin supervisión.
    - Asegúrese de que todas las partes metálicas de la carcasa estén correctamente conectadas a tierra.
    - Apague inmediatamente si detecta olor a quemado, humo o sobrecalentamiento de la carcasa.
    - Evite que la humedad o el condensado entren en contacto con los componentes del dispositivo.
    - Utilice un disyuntor o relé de sobrecarga.
    - Todas las conexiones deben realizarse respetando el aislamiento eléctrico.
    - Si no tiene experiencia con equipos eléctricos, consulte a un técnico cualificado.

!!! tip "Antes de comenzar"
    Primero ensamble el sistema sobre una mesa sin montarlo en la carcasa y verifique el funcionamiento de todos los componentes. Las instrucciones de preparación se encuentran en la sección «Antes del ensamblaje».

---

## Qué necesita

- Carcasa impresa — [CAD: modelos y parámetros de impresión](cad.md)
- Todos los componentes de la lista de piezas en la sección «Antes del ensamblaje»
- Placa Unit MCU programada y probada

---

## Ensamblaje paso a paso

### Pasos 1–4: Cámara principal

<div class="grid cards" markdown>
- ![1](../../img/001.jpg)
- ![2](../../img/002.jpg)
- ![3](../../img/003.jpg)
- ![4](../../img/004.jpg)
</div>

1. Instale los rodillos del portabobinas en la base de la carcasa.
2. Instale el elemento calefactor en las posiciones designadas.
3. Asegure el elemento calefactor con espaciadores (izquierda + derecha).
4. Instale el protector térmico KSD9700 en contacto con el elemento calefactor.

!!! warning "Protector térmico KSD9700"
    Asegúrese de que el KSD9700 esté en contacto firme con el cuerpo del calefactor. Un contacto flojo reduce la fiabilidad de la protección de emergencia.

### Pasos 5–7: Ventilación y compuerta

<div class="grid cards" markdown>
- ![5](../../img/005.jpg)
- ![6](../../img/006.jpg)
- ![7](../../img/007.jpg)
</div>

5. Instale el ventilador en la carcasa y aségurel con elementos de fijación.
6. Ensamble la unidad de compuerta: conecte la hoja y la carcasa de la compuerta. El tipo de compuerta depende del servo utilizado (3,7 g o 9 g).
7. Conecte el servo a la compuerta. **No fije la compuerta a la carcasa en esta etapa** — Los ángulos del servo se ajustan después de la programación.

### Pasos 8–10: Compartimiento de electrónica

<div class="grid cards" markdown>
- ![8](../../img/008.jpg)
- ![9](../../img/009.jpg)
- ![10](../../img/010.jpg)
</div>

8. Fije la placa de control en el compartimiento de electrónica.
9. Instale y conecte el conector de alimentación. Utilice terminales USHVI para cables de alimentación.
10. Enrute y asegure los cables de sensor en el conducto de cables. Instale la tapa del compartimiento de electrónica.

!!! warning "Instalación del termistor"
    Instale el termistor cerca del borde del elemento calefactor, aproximadamente en la mitad de la altura de las aletas del radiador.

    Las secciones de cable expuestas en la base del termistor no deben tocar el cuerpo metálico del calefactor. Si es necesario, aisle estas áreas con cinta Kapton o colóquelas en un tubo Teflón / tubo termorretráctil.

    La temperatura del calefactor puede alcanzar 140 °C.

![Instalación del termistor](../../img/thermistor.jpg)

---

## Después del ensamblaje

Antes del primer encendido:

- [ ] Verifique el aislamiento de todas las conexiones.
- [ ] Asegúrese de que los cables no estén pinzados por las tapas.
- [ ] Asegúrese de que el disyuntor térmico esté en buen contacto con el elemento calefactor.
- [ ] Verifique la integridad del cableado con un multímetro.

El siguiente paso es instalar el firmware en la sección «Controlador».

---

!!! quote "Agradecimientos"
    Un enorme agradecimiento a Igor (@dr_perry_coke) por su excelente trabajo, su sentido estético y las imágenes de ensamblaje de iDryer Unit que proporcionó.
