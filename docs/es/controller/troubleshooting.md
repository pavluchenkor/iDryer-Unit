# Resolución de problemas de conexión de iDryer Unit

Durante el uso de **iDryer Unit**, pueden ocurrir problemas de estabilidad de conexión (interrupciones, pérdida de MCU, funcionamiento inestable).  
En la mayoría de los casos, esto no se debe al dispositivo en sí, sino a factores externos: vibraciones, interferencias electromagnéticas o características de carga.

A continuación se enumeran las causas principales y cómo solucionarlas.

---

## 1. Vibración del cable USB

!!! warning "Síntomas"
    - Interrupciones periódicas de la conexión  
    - El dispositivo desaparece del sistema  
    - La conexión se restaura al tocar el cable  

!!! info "Causa"
    Las vibraciones de la impresora o secadora pueden causar micro movimientos del conector USB, lo que resulta en una pérdida temporal de contacto.

!!! success "Solución"
    - Fije firmemente el cable USB en el conector  
    - Evite la tensión del cable  
    - Si es necesario:
        - use un cable con un ajuste más apretado  
        - fije el cable con pegamento termofundible / bridas / soporte  

---

## 2. Interferencia de cables de alimentación

!!! warning "Síntomas"
    - Pérdida de conexión al activar la calefacción o el ventilador  
    - Reinicios aleatorios del dispositivo  
    - Funcionamiento inestable sin razón obvia  

!!! info "Causa"
    Los cables de alimentación de CA crean interferencias electromagnéticas que se acoplan al cable USB.

!!! success "Solución"
    - Separe el cable USB y los cables de alimentación lo máximo posible  
    - No los instale en el mismo conducto de cables  
    - Evite el enrutamiento paralelo en tramos largos  
    - Instale un filtro de ferrita (cilindro de ferrita) en el cable USB más cerca del controlador y/o de la placa de la impresora

---

## 3. Interferencia del ventilador

!!! warning "Síntomas"
    - Pérdida de conexión al activar/desactivar el ventilador  
    - Fallos que coinciden con el funcionamiento del ventilador de la secadora  
    - Inestabilidad en el control PWM  

!!! info "Causa"
    Un ventilador de 110–230 V está equipado con una fuente conmutada y puede generar interferencias que afecten las líneas de señal.

!!! success "Solución"
    Se recomienda instalar un **RC-snubber (snubber)** en paralelo con el ventilador. O use un filtro de ferrita en el cable USB.

---

## 4. Puerto USB 3.0 – problemas durante el funcionamiento

!!! warning "Síntomas"
    - Interrupciones periódicas de la conexión durante el funcionamiento  
    - El dispositivo desaparece del sistema sin razón aparente  
    - El problema desaparece al cambiar a otro puerto  

!!! info "Causa"
    Este es un problema común con dispositivos USB que funcionan en modo Full Speed (USB 2.0) conectados a puertos USB 3.0. Las computadoras modernas utilizan repetidores eUSB2 en puertos USB 3.0, que no son completamente compatibles con la especificación USB 2.0 – esto causa errores de sincronización y enumeración de dispositivos. El problema ha sido confirmado oficialmente por STMicroelectronics: [FAQ en el sitio ST](https://community.st.com/t5/stm32-mcus/faq-possible-communication-failure-between-stlink-v3-and-some/ta-p/736578).

!!! success "Solución"
    - Conecte iDryer Unit **solo a puertos USB 2.0** (normalmente conectores negros)  
    - Si todos los puertos son USB 3.0 – use un **concentrador USB activo con puertos USB 2.0**

---

## 5. Puerto USB 3.0 – problemas durante el flasheo

!!! warning "Síntomas"
    - El controlador no se reconoce en modo bootloader (BOOTSEL)  
    - El flasheo del firmware falla o se congela  
    - El dispositivo se reconoce, pero la escritura de imagen falla  

!!! info "Causa"
    El mismo problema de compatibilidad USB 3.0 / xHCI. Particularmente relevante al flashear a través de puertos USB Type-C en computadoras portátiles modernas – estos usan más frecuentemente repetidores eUSB2 problemáticos.

!!! success "Solución"
    - Al flashear, conecte el controlador **solo a un puerto USB 2.0**  
    - Prefiera los puertos USB Type-A en la parte posterior de la PC  
    - Si el problema persiste – use un **concentrador USB activo con puertos USB 2.0**
