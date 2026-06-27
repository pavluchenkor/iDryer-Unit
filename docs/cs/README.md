# iDryer Unit

iDryer Unit — modulární systém sušení a skladování filamentu pro 3D tiskárny. Tisknutelné pouzdro na 1 nebo 2 cívky, až čtyři nezávislé sušicí komory v jednom systému.

Teplota sušení — až 90 °C v standardním pouzdře, až 110 °C při použití tepelně odolných materiálů pouzdra. Podporované režimy — sušení (Drying), skladování (Storage) a profily (Profile).

![iDryer Unit](../img/iDryer.png)

## Pro koho je tento projekt

iDryer Unit — DIY projekt pro ty, kteří chtějí spolehlivou sušičku se skutečnou kontrolou procesu, nikoliv komerční zařízení se zavřeným vnitřkem.

Všechny komponenty — standardní a dostupné: ventilátor, PTC topidlo, senzor teploty a vlhkosti, servopohon, Thermal Protector. Kterýkoliv z nich lze vyměnit bez hledání originálních náhradních dílů. Na rozdíl od většiny sériových sušiček zde nic není, co by se nedalo opravit nebo zlepšit.

Pouzdro se tiskne na jakékoliv 3D tiskárně. Schémata, firmware a dokumentace jsou otevřeny.

![iDryer Unit s cívkou](../img/iDryerWithSpool.png)

---

## Dva režimy provozu

Vyberte si scénář před začátkem montáže — na něm závisí firmware a způsob řízení.

### Klipper

![Klipper](../img/klipper222252.jpg)

Řadič Unit se připojuje k hostiteli tiskárny a funguje jako `[mcu]` nebo `[second_mcu]` v Klipperu. Řízení — přes rozhraní Fluidd / Mainsail, G-kódové makra, integrace se základní konfigurací tiskárny.

K dispozici jsou další funkce Klipperu: upozornění přes Telegram bota (stav sušení, dokončení cyklu, přehřátí), adresovatelný LED pás pro vizuální indikaci režimů, automatické protokolování akcí.

Vhodné, pokud:

- máte již funkční Klipper;
- chcete sušičku ovládat přímo z rozhraní tiskárny;
- potřebujete hlubokou integraci s makry a plánováním.

→ [Firmware Klipperu](controller/firmware.md)

### Standalone

![iDryer Portal](../img/portal_screenshot.png)

Řadič funguje samostatně: vlastní firmware, řízení přes cloudový portál [portal.idryer.org](https://portal.idryer.org/) a mobilní aplikaci. Volitelně — místní řízení přes OLED displej a enkodér. Podporují se váhy (kontrola zbytku filamentu podle váhy) a RFID (automatické rozpoznání cívky).

Vhodné, pokud:

- chcete sušičku oddělenu od tiskárny;
- potřebujete vzdálené řízení přes mobilní aplikaci nebo portál;
- používáte několik sušiček s jedním bodem řízení.

→ [Standalone: o firmware](../../../iDryerRP2040/README.md)

---

## Specifikace

| Parametr | Hodnota |
|---|---|
| Teplota sušení | až 90 °C (až 110 °C s tepelně odolným pouzdrem) |
| Režimy | Drying, Storage, Profile (Standalone) |
| Počet komor | 1–4 (MCU + až 3 × EXT) |
| Připojení modulů | RJ45 patch kabel |
| Thermal Protector | KSD9700 (130 °C) |
| Ochranu proud | pojistka 2 A |
| Topný prvek | PTC, úplná elektrická izolace |
| Cívky | 1 nebo 2 na komoru; šířka až 85 mm, průměr až 200 mm |
| Varianty pouzdra | Na 1 cívku a na 2 cívky |
| Materiál pouzdra | Tisknutelný, ABS / ABS-CF / PC / HTPLA |
| Senzor vlhkosti | SHT3X nebo libovolný, podporovaný firmwarem |
| Indikace LED | výstup pro adresovatelný LED pás na desce MCU |

---

## Režimy práce

**Drying (sušení)** — nastavte teplotu a čas. Po skončení cyklu se systém automaticky přepne do režimu Storage.

**Storage (skladování)** — udržuje nastavenou teplotu a minimální úroveň vlhkosti. Topidlo a ventilátor se zapnou při překročení nastavených parametrů.

**Profile (profil)** — uživatelské scénáře s přizpůsobitelnými parametry a přechody mezi režimy. Dostupné v Standalone firmware.

---

## Řízení vlhkosti

Každá komora je vybavena řiditelným lopatkovým ventilem. Servopohon otevírá lopatku podle rozpisu pro vypouštění vzduch nasycený vlhkostí a zavírá jej pro udržení tepla. Senzor SHT3X nepřetržitě sleduje teplotu a vlhkost uvnitř komory — firmware upravuje režim chodu lopatky a topidla na základě těchto údajů.

![Lopatek iDryer Unit](../img/IMG_2168.jpg)
![Mechanismus lopatky](../img/IMG_2170.jpg)

---

## Architektura systému

Jeden blok **iDryer Unit MCU** řídí systém. K němu se přímo přes RJ45 připojují až tři bloky **iDryer Unit EXT** bez vlastního mikrokontroléru.

```
              ┌— RJ45 — [EXT U2]
[MCU] ————————┼— RJ45 — [EXT U3]
              └— RJ45 — [EXT U4]
```

Každý blok — nezávislá sušicí komora s vlastním senzorem, topidlem, ventilátorem a servopohon lopatky.

---

## Vestavěná bezpečnost

- **KSD9700** — Thermal Protector na 130 °C: fyzicky přeruší obvod topidla při přehřátí.
- **Pojistka 2 A** — ochrana při nouzových proudech.
- **PTC topidlo** — pouzdro topidla není pod napětím.
- **Softwarová ochrana** — Klipper (nebo Standalone firmware) sleduje teplotu, přítomnost senzorů a vypíná topidlo při chybě.

!!! danger "Práce se síťovým napětím"
    Zařízení obsahuje součásti pod napětím 110–230 V. Před jakýmikoliv pracemi s elektrickými obvody vypněte napájení. Více — v sekci [Bezpečnost](unit/safety.md).

---

## S čím začít

1. **Vytiskněte pouzdro** → [CAD: modely k tisku](unit/cad.md)
2. **Připravte komponenty** → [Před montáží](unit/before.md)
3. **Sestavte zařízení** → [Montáž](unit/assembly.md)
4. **Nainstalujte firmware**:
   - Klipper → [Firmware Klipperu](controller/firmware.md)
   - Standalone → [Instalace Standalone](../../../iDryerRP2040/docs/manual/firmware_install.md)
5. **Nakonfigurujte systém** → [Uživatelská příručka](controller/user-guide.md)
