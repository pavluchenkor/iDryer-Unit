## Seguridad

El firmware del controlador — Klipper o Standalone — proporciona protección por software:

- monitoreo de temperatura con termistores;
- verificación de la presencia de sensores de temperatura conectados;
- protección contra valores de temperatura fuera de los límites seguros;
- uso de temporizadores en caso de bloqueo del sistema;
- apagado automático en caso de errores de sensor o controlador.

Además, se implementa protección por hardware:

Se instala un disyuntor térmico KSD9700 (130 °C) que corta físicamente la alimentación del elemento calefactor en caso de sobrecalentamiento. Esto es crítico en caso de cualquier falla de software o hardware.

El controlador está equipado con un fusible de 2 A que protege el dispositivo. En caso de fallo, se quema y apaga completamente el sistema.

Se utiliza un elemento calefactor PTC con aislamiento eléctrico completo. A diferencia de la mayoría de soluciones de calefacción, la carcasa del calefactor PTC no está bajo tensión, lo que elimina el riesgo de electrocución durante la instalación y mantenimiento de la cámara de la impresora 3D.

Un sistema de protección de múltiples niveles como este hace que iDryer Unit sea una solución segura para secar filamento, incluso durante una operación continua prolongada.

!!! warning "Instalación del termistor"
    Asegúrese de que las secciones de cable expuestas en la base del termistor no toquen la carcasa metálica del calefactor. Si es necesario, aisle estas áreas con cinta Kapton o colóquelas en un tubo Teflón / tubo termorretráctil.

    Recuerde que la temperatura del calefactor puede alcanzar 140 °C.

!!! danger "KSD9700 — no es la protección final"
    KSD9700 (disyuntor térmico) es un dispositivo autorrestablecible: en caso de sobrecalentamiento abre el circuito, pero tan pronto como la temperatura cae por debajo del umbral, se cierra automáticamente. En caso de fallo del calefactor, el dispositivo se sobrecalentará y enfriará cíclicamente sin intervención. Esto no es un apagado de emergencia — es un ciclo infinito de sobrecalentamiento.

    Para la explotación continua, reemplace KSD9700 con un fusible térmico desechable (por ejemplo **RH130**). Corta el circuito de forma permanente al activarse — el dispositivo se apaga y permanece en un estado seguro hasta su sustitución.

!!! note "Orden recomendado"
    Utilice KSD9700 durante el ensamblaje y la depuración. Después de verificar el funcionamiento, reemplácelo con un fusible térmico.
