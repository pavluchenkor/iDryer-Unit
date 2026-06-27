# Vor der Montage

Machen Sie sich mit diesem Abschnitt vertraut, bevor Sie Komponenten kaufen. Stellen Sie sicher, dass alle erforderlichen Teile und Werkzeuge verfügbar sind.

!!! warning "Elektrosicherheit"
    Das Gerät arbeitet mit 110–230 V Netzspannung. Lesen Sie vor Arbeitsbeginn den Abschnitt [Sicherheit](safety.md).

---

## CAD-Modelle

Drucken Sie das Gehäuse vor Beginn der Montage. Modelle und Druckparameter: [CAD](cad.md).

Gehäusematerial: **ABS, ABS-CF, ABS-GF, PC oder HTPLA**. Verwenden Sie nicht PLA oder PETG — diese halten der Betriebstemperatur nicht stand.

---

## Komponentensatz für eine Einheit

### Elektronik und Komponenten

| Komponente | Menge | Hinweis |
|---|---|---|
| iDryer Unit MCU-Platine | 1 | Hauptblock; für jeden weiteren Block — EXT-Platine |
| PTC-Heizelement 110–230 V, 100 W | 1 | |
| Lüfter | 1 | Zur Luftzirkulation |
| NTC-Temperatursensor 100 K | 1 | Oder ein beliebiger von Klipper/Standalone unterstützter Sensor |
| SHT3X-Temperatur- und Feuchtigkeitssensor | 1 | Oder ein beliebiger I2C-Sensor, der von der Firmware unterstützt wird |
| Thermischer Schutzschalter KSD9700 (130 °C) | 1 | Oder Einwegthermal Fuse RH130 |
| Servo für die Klappe | 1 | 3,7 g oder 9 g (siehe CAD-Abschnitt) |
| RJ45-Patchkabel | Anzahl EXT-Blöcke | Standard, Cat5e oder höher |

### Befestigungsmittel und Stecker

| Position | Hinweis |
|---|---|
| Klemmverbinder | Nach Platinenplan |
| USHVI-Anschlüsse | Zum Crimpen von Heizkabeln |
| Wärmeschrumpfschlauch | Zur Isolierung von Verbindungen |

### Software

Entscheiden Sie sich vor der Montage für den Betriebsmodus — dies bestimmt die Firmware:

- **Klipper** — erfordert einen Drucker mit installiertem Klipper.
- **Standalone** — funktioniert ohne Drucker, Steuerung über Display und/oder Portal.

Weitere Informationen zur Auswahl finden Sie im Abschnitt „Über das Projekt".

---

## Werkzeuge

- Crimpwerkzeug (Werkzeug zum Crimpen von RJ45)
- Zange zum Crimpen von USHVI-Anschlüssen
- Lötkolben (falls erforderlich)
- Multimeter zur Verbindungsprüfung
- Schraubenzieher und Schlüssel in den erforderlichen Größen

---

## Empfehlung

Montieren Sie das System **auf dem Tisch ohne Montage in das Gehäuse** und führen Sie erste Tests durch:

1. Verbinden Sie das Heizelement, den Lüfter, die Sensoren und das Servo mit der Platine.
2. Laden Sie die Firmware hoch und überprüfen Sie, ob jede Komponente ordnungsgemäß funktioniert.
3. Nur nach erfolgreichem Test die Komponenten in das Gehäuse montieren.

Kürzen Sie bei der endgültigen Montage die Sensor- und Stromkabel auf die minimal erforderliche Länge.