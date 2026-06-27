# Montage

Diese Seite beschreibt die physische Montage des Gehäuses und der Elektronik des iDryer Unit.

!!! danger "Warnung! Arbeiten mit Hochspannungsgeräten"
    Bevor Sie beginnen, lesen Sie bitte die Sicherheitsmaßnahmen sorgfältig durch.

    Der iDryer Unit enthält Komponenten, die unter Netzspannung von 110–230 V arbeiten. Eine falsche Verbindung oder Bedienung kann zu Stromschlag, Brand oder Geräteausfällen führen.

!!! danger "Arbeiten mit Netzspannung"
    Alle Arbeiten mit der 110–230-V-Verbindung müssen bei ausgeschaltetem Gerät durchgeführt werden. Stellen Sie vor der ersten Inbetriebnahme sicher, dass alle Verbindungen ordnungsgemäß isoliert sind. Weitere Details finden Sie im Abschnitt [Sicherheit](safety.md).

!!! warning "Allgemeine Sicherheitsmaßnahmen"
    - Trennen Sie das Gerät vor allen Arbeiten vom Netz.
    - Berühren Sie keine offenen stromführenden Teile.
    - Überprüfen Sie die Integrität der Verkabelung vor dem Einschalten.
    - Betreiben Sie das Gerät nicht mit beschädigtem Gehäuse oder freigelegten Drähten.
    - Lassen Sie das eingeschaltete Gerät nicht unbeaufsichtigt.
    - Stellen Sie sicher, dass alle metallischen Gehäuseteile ordnungsgemäß geerdet sind.
    - Schalten Sie das Gerät sofort aus, wenn Sie einen Brandgeruch, Rauch oder abnormale Gehäusewärme bemerken.
    - Vermeiden Sie, dass Feuchtigkeit oder Kondenswasser auf die Gerätekomponenten gelangt.
    - Verwenden Sie einen Überstromschutzschalter oder Schutzrelais.
    - Alle Verbindungen müssen unter Beachtung der elektrischen Isolation durchgeführt werden.
    - Wenn Sie keine Erfahrung mit Elektrogeräten haben, konsultieren Sie einen qualifizierten Fachmann.

!!! tip "Bevor Sie beginnen"
    Montieren Sie das System zuerst auf dem Tisch ohne Montage in das Gehäuse und überprüfen Sie die Funktionsfähigkeit aller Komponenten. Eine Anleitung zur Vorbereitung finden Sie im Abschnitt „Vor der Montage".

---

## Was wird benötigt

- Gedrucktes Gehäuse — [CAD: Modelle und Druckparameter](cad.md)
- Alle Komponenten aus der Stückliste im Abschnitt „Vor der Montage"
- Programmierte und getestete Unit-MCU-Platine

---

## Schritt-für-Schritt-Montage

### Schritte 1–4: Hauptkammer

<div class="grid cards" markdown>
- ![1](../../img/001.jpg)
- ![2](../../img/002.jpg)
- ![3](../../img/003.jpg)
- ![4](../../img/004.jpg)
</div>

1. Installieren Sie die Rollen des Spulenhalters in der Gehäusebasis.
2. Installieren Sie das Heizelement in den vorgesehenen Positionen.
3. Sichern Sie das Heizelement mit Abstandshaltern (links + rechts).
4. Installieren Sie den thermischen Schutzschalter KSD9700 in Kontakt mit dem Heizelement.

!!! warning "Thermischer Schutzschalter KSD9700"
    Stellen Sie sicher, dass der KSD9700 in festem Kontakt mit dem Heizerkörper steht. Ein lockerer Kontakt verringert die Zuverlässigkeit des Notschutzes.

### Schritte 5–7: Belüftung und Klappe

<div class="grid cards" markdown>
- ![5](../../img/005.jpg)
- ![6](../../img/006.jpg)
- ![7](../../img/007.jpg)
</div>

5. Installieren Sie den Lüfter im Gehäuse und sichern Sie ihn mit Befestigungselementen.
6. Montieren Sie die Klappeneinheit: Verbinden Sie das Blatt und das Klappengehäuse. Der Klappentyp hängt vom verwendeten Servo ab (3,7 g oder 9 g).
7. Verbinden Sie das Servo mit der Klappe. **Befestigen Sie die Klappe in diesem Stadium noch nicht am Gehäuse** — Die Servo-Winkel werden nach der Programmierung eingestellt.

### Schritte 8–10: Elektronikschacht

<div class="grid cards" markdown>
- ![8](../../img/008.jpg)
- ![9](../../img/009.jpg)
- ![10](../../img/010.jpg)
</div>

8. Befestigen Sie die Steuerplatine im Elektronikschacht.
9. Installieren Sie und verbinden Sie den Stromstecker. Verwenden Sie USHVI-Anschlüsse für Stromkabel.
10. Verlegen Sie die Sensorkabel im Kabelkanal und sichern Sie sie. Installieren Sie die Abdeckung des Elektronikschachts.

!!! warning "Thermistor-Installation"
    Installieren Sie den Thermistor am Rand des Heizelementes, ungefähr in der Mitte der Kühlrippenhöhe des Heizers.

    Freigelegte Drahtabschnitte an der Thermistor-Basis sollten nicht den metallischen Heizerkörper berühren. Wenn nötig, isolieren Sie diese Bereiche mit Kapton-Klebeband oder platzieren Sie sie in einem Teflon-Schlauch / Wärmeschrumpfschlauch.

    Die Heizer-Temperatur kann 140 °C erreichen.

![Thermistor-Installation](../../img/thermistor.jpg)

---

## Nach der Montage

Vor der ersten Inbetriebnahme:

- [ ] Überprüfen Sie die Isolation aller Verbindungen.
- [ ] Stellen Sie sicher, dass Kabel nicht durch Abdeckungen eingeklemmt sind.
- [ ] Stellen Sie sicher, dass der Thermoschalter fest mit dem Heizelement in Kontakt ist.
- [ ] Überprüfen Sie die Integrität der Verkabelung mit einem Multimeter.

Der nächste Schritt ist die Installation der Firmware im Abschnitt "Controller".

---

!!! quote "Danksagungen"
    Riesiger Dank an Igor (@dr_perry_coke) für die hervorragende Arbeit, den ästhetischen Sinn und die bereitgestellten Bilder der iDryer-Unit-Montage.
