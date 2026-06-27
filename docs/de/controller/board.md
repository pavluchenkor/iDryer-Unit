# Steuerung

Das System ist auf zwei Arten von Platten aufgebaut: die Hauptplatine MCU und die Erweiterungsplatten EXT.

## iDryer Unit MCU

Die Hauptplatine mit Mikrocontroller. Sie steuert das gesamte System: liest Sensoren aus, steuert den Heizer, Lüfter und Servo der Klappenvorrichtung. Die Verbindung zum Host erfolgt über USB-C. Drei RJ45-Stecker für die Verbindung von EXT-Platten.

![MCU-Platine](../../img/MCU_PCB.png)

## iDryer Unit EXT

Erweiterungsplatine ohne Mikrocontroller. Sie wird über RJ45-Patchkabel mit der MCU verbunden und wird von ihr direkt gesteuert. Für jeden zusätzlichen Trocknerblock wird eine EXT-Platine benötigt.

![EXT-Platine](../../img/EXT_PCB.png)
