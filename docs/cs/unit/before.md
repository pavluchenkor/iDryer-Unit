# Před montáží

Seznamte se s touto sekcí před nákupem komponent. Ujistěte se, že jsou k dispozici všechny potřebné díly a nástroje.

!!! warning "Elektrosafety"
    Zařízení pracuje pod síťovým napětím 110–230 V. Před zahájením si přečtěte sekci [Bezpečnost](safety.md).

---

## CAD modely

Vytiskněte kryt před zahájením montáže. Modely a parametry tisku: [CAD](cad.md).

Materiál krytu: **ABS, ABS-CF, ABS-GF, PC nebo HTPLA**. Nepoužívejte PLA nebo PETG — nejsou schopné odolat pracovní teplotě.

---

## Sada komponent pro jednu jednotku

### Elektronika a komponenty

| Komponenta | Množství | Poznámka |
|---|---|---|
| iDryer Unit MCU deska | 1 | Hlavní blok; pro každý další blok — EXT deska |
| PTC topný prvek 110–230 V, 100 W | 1 | |
| Ventilátor | 1 | Pro cirkulaci vzduchu |
| NTC teplotní senzor 100 K | 1 | Nebo jakýkoli senzor podporovaný Klipperem/Standalone |
| SHT3X teplotní a vlhkostní senzor | 1 | Nebo jakýkoli I2C senzor podporovaný firmwarem |
| Teplotní ochranný prvek KSD9700 (130 °C) | 1 | Nebo jednorázová tepelná pojistka RH130 |
| Servo pro klapku | 1 | 3,7 g nebo 9 g (viz sekce CAD) |
| Patch kabel RJ45 | Počet EXT bloků | Standardní, Cat5e nebo vyšší |

### Spojovací materiály a konektory

| Pozice | Poznámka |
|---|---|
| Svorkovnice | Podle schématu desky |
| Svorkovnice USHVI | Pro lisování topných kabelů |
| Smršťovací trubice | Pro izolaci spojů |

### Software

Před montáží se rozhodněte pro režim provozu — to určuje firmware:

- **Klipper** — vyžaduje tiskárnu s nainstalovaným Klipperem.
- **Standalone** — funguje bez tiskárny, ovládání přes displej a/nebo portál.

Více informací o výběru naleznete v sekci „O projektu".

---

## Nástroje

- Lisovací nástroj (RJ45 lisovací nástroj)
- Kleště na lisování svorek USHVI
- Páječka (v případě potřeby)
- Multimetr pro kontrolu spojů
- Šroubovák a klíče požadované velikosti

---

## Doporučení

Sestavte systém **na stole bez montáže do krytu** a proveďte počáteční testy:

1. Připojte topný prvek, ventilátor, senzory a servo k desce.
2. Načtěte firmware a ověřte, zda jednotlivé komponenty fungují správně.
3. Komponenty do krytu namontujte až po úspěšném testu.

Při konečné montáži zkraťte senzorické a napájecí kabely na minimálně potřebnou délku.