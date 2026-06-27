# iDryer Unit

iDryer Unit ist ein modulares Trocknungs- und Lagersystem für Filament 3D-Druck. Gedrucktes Gehäuse für 1 oder 2 Spulen, bis zu vier unabhängige Trocknungskammern in einem System.

Trocknungstemperatur – bis 90 °C im Standardgehäuse, bis 110 °C bei Verwendung wärmefester Gehäusematerialien. Unterstützte Modi – Trocknung (Drying), Lagerung (Storage) und Profile (Profile).

![iDryer Unit](../img/iDryer.png)

## Für wen dieses Projekt

iDryer Unit ist ein DIY-Projekt für diejenigen, die einen zuverlässigen Trockner mit echtem Kontrolle über den Prozess möchten, anstelle eines vorgefertigten kommerziellen Geräts mit proprietärer Elektronik.

Alle Komponenten sind Standard und verfügbar: Lüfter, PTC-Heizer, Temperatur- und Feuchtigkeitssensor, Servo, Thermal Protector. Jeder von ihnen kann ohne Suche nach Herstellerersatzteilen ersetzt werden. Im Gegensatz zu den meisten Seriendryern gibt es hier nichts, was man nicht reparieren oder verbessern könnte.

Das Gehäuse wird auf jedem 3D-Drucker gedruckt. Schaltpläne, Firmware und Dokumentation sind offen.

![iDryer Unit mit Spule](../img/iDryerWithSpool.png)

---

## Zwei Betriebsvarianten

Wählen Sie ein Szenario vor der Montage – davon hängen Firmware und Steuerungsart ab.

### Klipper

![Klipper](../img/klipper222252.jpg)

Der Unit-Controller wird mit dem Druckhost verbunden und funktioniert als `[mcu]` oder `[second_mcu]` in Klipper. Steuerung – über die Fluidd/Mainsail-Oberfläche, G-Code-Makros, Integration mit der Druckerkonfiguration.

Zusätzliche Klipper-Funktionen verfügbar: Benachrichtigungen über Telegram-Bot (Trocknungsstatus, Zyklus abgeschlossen, Übertemperatur), adressierbare LED-Streifen für visuelle Modusanzeige, automatische Ereignisprotokolle.

Geeignet wenn:

- Sie bereits Klipper verwenden;
- Sie den Trockner direkt über die Druckerbenutzeroberfläche steuern möchten;
- Sie tiefe Integration mit Makros und Zeitplänen benötigen.

→ [Klipper Firmware](controller/firmware.md)

### Standalone

![iDryer Portal](../img/portal_screenshot.png)

Der Controller funktioniert eigenständig: eigene Firmware, Steuerung über das Cloud-Portal [portal.idryer.org](https://portal.idryer.org/) und Mobile-App. Optional – lokale Steuerung über OLED-Display und Encoder. Waagen werden unterstützt (Kontrolle des verbleibenden Filaments nach Gewicht) und RFID (automatische Spulenerkennung).

Geeignet wenn:

- Sie einen Trockner unabhängig vom Drucker möchten;
- Sie ferngesteuert über Mobile-App oder Portal steuern müssen;
- Sie mehrere Trockner mit einem zentralen Steuerungspunkt verwenden.

→ [Standalone: über Firmware](../../../iDryerRP2040/README.md)

---

## Spezifikationen

| Parameter | Wert |
|---|---|
| Trocknungstemperatur | bis 90 °C (bis 110 °C mit wärmefestem Gehäuse) |
| Modi | Drying, Storage, Profile (Standalone) |
| Kammernanzahl | 1–4 (MCU + bis 3 × EXT) |
| Modulverbindung | RJ45 Patchkabel |
| Thermal Protector | KSD9700 (130 °C) |
| Stromschutz | 2 A Sicherung |
| Heizelement | PTC, vollständige elektrische Isolierung |
| Spulen | 1 oder 2 pro Kammer; Breite bis 85 mm, Durchmesser bis 200 mm |
| Gehäusevarianten | 1-Spulen- und 2-Spulen-Version |
| Gehäusematerial | Druckbar, ABS / ABS-CF / PC / HTPLA |
| Feuchtigkeitssensor | SHT3X oder beliebig von der Firmware unterstützt |
| LED-Anzeige | Ausgang für adressierbarer LED-Streifen auf der MCU-Platine |

---

## Betriebsmodi

**Drying (Trocknung)** – legen Sie die Temperatur und Zeit fest. Nach Ablauf des Zyklus schaltet das System automatisch in den Storage-Modus um.

**Storage (Lagerung)** – behält die eingestellte Temperatur und minimale Feuchtigkeitsstufe bei. Heizer und Lüfter schalten sich ein, wenn die eingestellten Parameter überschritten werden.

**Profile (Profil)** – benutzerdefinierte Szenarien mit konfigurierbaren Parametern und Modusübergängen. Verfügbar in der Standalone-Firmware.

---

## Feuchtigkeitskontrolle

Jede Kammer ist mit einer gesteuerten Klappe ausgestattet. Das Servo öffnet die Klappe nach einem Zeitplan, um feuchte Luft abzuführen, und schließt sie, um Wärme zu halten. Der SHT3X-Sensor überwacht kontinuierlich Temperatur und Feuchte in der Kammer – die Firmware passt den Betriebsmodus der Klappe und des Heizers basierend auf diesen Daten an.

![iDryer Unit Klappe](../img/IMG_2168.jpg)
![Klappenmechanismus](../img/IMG_2170.jpg)

---

## Systemarchitektur

Ein **iDryer Unit MCU**-Block verwaltet das System. Bis zu drei **iDryer Unit EXT**-Blöcke ohne eigenen Mikrocontroller sind direkt über RJ45 daran angeschlossen.

```
              ┌— RJ45 — [EXT U2]
[MCU] ————————┼— RJ45 — [EXT U3]
              └— RJ45 — [EXT U4]
```

Jeder Block ist eine unabhängige Trocknungskammer mit eigenem Sensor, Heizer, Lüfter und Servo-Verschlussklappe.

---

## Integrierte Sicherheit

- **KSD9700** – Thermal Protector bei 130 °C: unterbricht die Heizerstromversorgung physikalisch bei Übertemperatur.
- **2 A Sicherung** – Schutz bei Fehlersströmen.
- **PTC-Heizer** – das Heizgehäuse ist nicht unter Spannung.
- **Softwareschutz** – Klipper (oder Standalone-Firmware) überwacht die Temperatur, Sensorverfügbarkeit und schaltet das Heizelement bei Fehler ab.

!!! danger "Arbeit mit Netzspannung"
    Das Gerät enthält Komponenten unter 110–230 V Spannung. Vor allen Elektroarbeiten Stromversorgung abschalten. Weitere Details – im Abschnitt [Sicherheit](unit/safety.md).

---

## Erste Schritte

1. **Gehäuse drucken** → [CAD: Druckmodelle](unit/cad.md)
2. **Komponenten vorbereiten** → [Vor der Montage](unit/before.md)
3. **Gerät montieren** → [Montage](unit/assembly.md)
4. **Firmware installieren**:
   - Klipper → [Klipper Firmware](controller/firmware.md)
   - Standalone → [Standalone Installation](../../../iDryerRP2040/docs/manual/firmware_install.md)
5. **System konfigurieren** → [Benutzerhandbuch](controller/user-guide.md)
