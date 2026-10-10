## Sicherheit

Die Firmware des Controllers — Klipper oder Standalone — bietet Softwareschutz:

- Temperaturüberwachung mit Thermistoren;
- Überprüfung auf den Anschluss von Temperatursensoren;
- Schutz vor Temperaturwerten außerhalb sicherer Grenzen;
- Verwendung von Timern bei Systemabsturz;
- automatisches Abschalten bei Sensor- oder Controller-Fehlern.

Zusätzlich ist ein Hardwareschutz implementiert:

Es ist ein thermischer Schutzschalter KSD9700 (130 °C) installiert, der bei Überhitzung die Stromversorgung des Heizelementes physisch unterbricht. Dies ist kritisch wichtig bei allen Softwarefehlern oder Hardwareausfällen.

Der Controller ist mit einer 2-A-Sicherung ausgestattet, die das Gerät schützt. Im Fehlerfall brennt sie durch und schaltet das gesamte System ab.

Es wird ein PTC-Heizelement mit vollständiger elektrischer Isolation verwendet. Im Gegensatz zu den meisten Heizlösungen steht das PTC-Heizer-Gehäuse nicht unter Spannung, was das Risiko eines Stromschlags bei Installation und Wartung der 3D-Drucker-Kammer ausschließt.

Ein solch mehrstufiges Schutzsystem macht den iDryer Unit zur sicheren Lösung zum Trocknen von Filament, auch bei längerer kontinuierlicher Betriebsdauer.

!!! warning "Thermistor-Installation"
    Stellen Sie sicher, dass die freigelegten Drahtabschnitte an der Thermistor-Basis das metallische Heizer-Gehäuse nicht berühren. Wenn erforderlich, isolieren Sie diese Bereiche mit Kapton-Klebeband oder platzieren Sie sie in einem Teflon-Schlauch/Wärmeschrumpfschlauch.

    Denken Sie daran, dass die Heizer-Temperatur 140 °C erreichen kann.

!!! danger "KSD9700 — nicht der endgültige Schutz"
    KSD9700 (Thermal Protector) ist ein selbstwiederherstellendes Gerät: Bei Überhitzung öffnet es den Stromkreis, aber sobald die Temperatur unter den Schwellenwert fällt, schließt es sich automatisch wieder. Bei Heizer-Fehler wird das Gerät zyklisch überhitzt und abgekühlt ohne Eingriff. Dies ist keine Notabschaltung — dies ist ein Endlosschleife Überhitzung.

    Ersetzen Sie für den ständigen Betrieb KSD9700 durch eine Einweg-Thermosicherung (z.B. **RH130**). Sie trennt den Stromkreis dauerhaft bei Auslösung — das Gerät wird abgeschaltet und bleibt bis zum Austausch in einem sicheren Zustand.

!!! note "Empfohlene Reihenfolge"
    Verwenden Sie KSD9700 während der Montage und des Debuggings. Nach der Überprüfung der Funktionsfähigkeit ersetzen Sie es durch eine Thermosicherung.
