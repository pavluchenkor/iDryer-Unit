# iDryer Unit FAQ

---

### Ist iDryer Unit mit meinem Drucker kompatibel?
iDryer Unit funktioniert mit jedem 3D-Drucker unter der **aktuellen Klipper-Version**.
Die Standalone-Firmware wird verfügbar sein, sobald sie die **Pre-Beta-Phase** verlässt.

---

### **Wie viele Spulen unterstützt iDryer Unit?**
Es sind folgende Versionen verfügbar:

- für **eine Spule**,
- für **zwei Spulen (Unit Duo)**.
- iDryer ist ein **Open-Source-Projekt**, und Sie können das Gehäuse für eine beliebige Anzahl von Spulen anpassen. Es ist wichtig zu verstehen, dass mit zunehmender Gehäusegröße auch die Wärmeverluste steigen.

---

### **Welcher Regler wird in iDryer Unit verwendet?**
Es wird **RP2040** verwendet.

---

### **Kann ich BTT-, MKS- und andere Platinen verwenden?**
iDryer Unit ist ein **Open-Source-Projekt**. Alle Gehäusemodelle und Teile sind auf GitHub in den Formaten **STEP** und **STL** verfügbar.
Sie können die Konstruktion selbstständig an jede Ausrüstung anpassen.
Auf GitHub finden Sie bereits viele benutzerdefinierte Modifikationen, mit denen Sie sich auch vertraut machen können.

---

### **Wird ein spezieller Dichtungsstoff oder eine Dichtung benötigt?**
Das Set enthält **Silikonschlauch** (Ø 2 mm, Wandstärke 1 mm).
Alternativ können Sie einen Dichtungsstoff aus **TPU (Shore 65-75A)** verwenden.

---

### **Welche typischen Probleme können auftreten?**
Wenn sich die Heizung in **unkontrolliertes Aufheizen** begibt, überprüfen Sie **die korrekte Installation des Thermistors**.
Der Regler trifft Entscheidungen nur auf der Grundlage von Thermistor-Messwerten. Ein falsch installierter Thermistor führt zu fehlender Rückmeldung und folglich zu Überhitzung und Beschädigung des Gehäuses. Eine Gehäusebeschädigung bedeutet Zeitverschwendung beim Neudruck, daher muss die Thermistor-Installation genau nach Anleitung erfolgen.

---

### **Was ist zu tun bei I2C NACK-Fehler in Klipper?**
Wenn Klipper einen **I2C NACK**-Fehler meldet, bedeutet dies, dass der Sensor auf eine Abfrage nicht reagiert hat. Mögliche Ursachen:

- **Falsche Sensorverbindung.** Überprüfen Sie die Lötung und die Verbindung der Leitungen, um sicherzustellen, dass sie dem Pinout der Platine entsprechen.
- **Zu lange Leitung.** I2C ist eine Schnittstelleninterface auf der Platine, und Leitungen länger als 20–30 cm können instabil funktionieren. Für lange Verbindungen gibt es spezielle Lösungen, aber diese Konfiguration sieht sie nicht vor.
- **Falsche Adresse in der Konfiguration.** In der Konfigurationsdatei (`cfg`) werden mögliche Sensoradressen angegeben (normalerweise zwei Varianten, die in den Kommentaren gekennzeichnet sind). Wenn alles andere funktioniert, versuchen Sie, die Adresse auf die alternative zu ändern.

---

### **Schmilzt das Gehäuse nicht bei 130 °C?**
Die im Config angegebene Temperatur (z. B. **130 °C**) wird vom Thermistor gemessen, der so nah wie möglich am Heizelement angebracht ist.

- An den Rändern des Aluminiumrohrs ist die Temperatur aufgrund der Belüftung deutlich niedriger.
- Die Konstruktion sieht **Abstandshalter** (Schrauben oder Kunststoffelemente) vor, die die Wärmbelastung zusätzlich verringern.

⚠️ Beim ersten Start wird empfohlen, die maximale Betriebstemperatur zu bestimmen:

1. Erhöhen Sie die Temperatur in Schritten von **5-10 °C**.
2. Wenn der Heizer die eingestellte Temperatur erreicht, prüfen Sie das Gehäuse vorsichtig mit einem harten, dünnen Werkzeug.
3. Wenn der Kunststoff erweicht oder der Heizer am Gehäuse klebt, ist die Temperatur zu hoch und muss gesenkt werden.

---

### **Wie sieht es mit der Sicherheit aus?**
Die Sicherheit wird durch mehrere Kontrollebenen gewährleistet:

- **Softwarekontrolle**: Der Heizer wird nach Thermistor-Messwerten gesteuert. Bei Überhitzung schaltet das Programm die Heizung aus.

- **Watchdog-Timer**: Eingebaut in den Mikrocontroller, überwacht die Firmware und verhindert Hänger.

- **Hardwareschutz**: Ein Thermosicherung wird verwendet. Zum Zeitpunkt der Tests kann **KSD-9700** verwendet werden, das den Stromkreis bei Überhitzung unterbricht und ihn bei Abkühlung um etwa 20 °C wieder schließt. Für den Dauerbetrieb wird empfohlen, ihn durch **RH-135** zu ersetzen (arbeitet bei 135 °C und unterbricht den Stromkreis dauerhaft).

- Auf der Steuerplatine ist auch eine **Sicherung** installiert, die das Gerät bei Kurzschluss schützt.

---

### **Wie gut funktionieren gedruckte Rollen?**
Gedruckte Rollen sind eine technische Lösung und haben sich im Betrieb bewährt, besonders wenn sie aus wärmefesten Materialien gedruckt werden.
Wenn jedoch während des Betriebs Probleme auftreten, können Sie **Aluminiumrohre in der erforderlichen Größe** selbst herstellen.

---

### **Wo finde ich die Dokumentation?**
Die Dokumentation ist hier verfügbar:

- [GitHub-Projekt](https://github.com/idryer)
- [docs.idryer.org](https://docs.idryer.org)
