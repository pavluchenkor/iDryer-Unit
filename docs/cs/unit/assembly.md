# Montáž

Tato stránka popisuje fyzickou montáž krytu a elektroniky iDryer Unit.

!!! danger "Upozornění! Práce s elektrickým zařízením vysokého napětí"
    Předtím, než začnete, pečlivě si přečtěte bezpečnostní opatření.

    iDryer Unit obsahuje součástky pracující pod síťovým napětím 110–230 V. Nesprávné připojení nebo provoz může vést k úrazu elektrickým proudem, požáru nebo selhání zařízení.

!!! danger "Práce se síťovým napětím"
    Všechny práce s připojením k napětí 110–230 V musí být prováděny s vypnutým zařízením. Před prvním spuštěním se ujistěte, že jsou všechna připojení správně izolována. Více podrobností naleznete v sekci [Bezpečnost](safety.md).

!!! warning "Obecná bezpečnostní opatření"
    - Odpojte zařízení před jakýmikoli pracemi.
    - Nedotýkejte se otevřených živých částí.
    - Zkontrolujte integritu kabeláže před zapnutím.
    - Neprovozujte zařízení s poškozeným krytem nebo obnažených drátů.
    - Nikdy nenechávejte zapnuté zařízení bez dozoru.
    - Ujistěte se, že všechny kovové části krytu jsou správně uzemněny.
    - Okamžitě vypněte zařízení, pokud zjistíte pach kouře, kouř nebo abnormální teplotu krytu.
    - Zabraňte kontaktu vlhkosti nebo kondenzátu se součástkami zařízení.
    - Použijte jistič nebo relé přetížení.
    - Všechna spojení musí být provedena s ohledem na elektrickou izolaci.
    - Pokud nemáte zkušenost s elektrickými zařízeními, konzultujte kvalifikovaného technika.

!!! tip "Před zahájením"
    Nejprve sestavte systém na stole bez montáže do krytu a ověřte funkčnost všech součástí. Pokyny k přípravě naleznete v sekci "Před montáží".

---

## Co budete potřebovat

- Vytištěný kryt — [CAD: modely a parametry tisku](cad.md)
- Všechny součástky ze seznamu dílů v sekci "Před montáží"
- Programovaná a testovaná deska Unit MCU

---

## Montáž krok za krokem

### Kroky 1–4: Hlavní komora

<div class="grid cards" markdown>
- ![1](../../img/001.jpg)
- ![2](../../img/002.jpg)
- ![3](../../img/003.jpg)
- ![4](../../img/004.jpg)
</div>

1. Nainstalujte válečky držáku cívky do základny krytu.
2. Nainstalujte topný prvek na určená místa.
3. Zajistěte topný prvek distančními podložkami (levá + pravá).
4. Nainstalujte teplotní ochranný prvek KSD9700 do kontaktu s topným prvkem.

!!! warning "Teplotní ochranný prvek KSD9700"
    Ujistěte se, že je KSD9700 v pevném kontaktu s tělem ohřívače. Slabý kontakt snižuje spolehlivost nouzové ochrany.

### Kroky 5–7: Větrání a klapka

<div class="grid cards" markdown>
- ![5](../../img/005.jpg)
- ![6](../../img/006.jpg)
- ![7](../../img/007.jpg)
</div>

5. Nainstalujte ventilátor do krytu a zajistěte jej upevňovacími prvky.
6. Sestavte jednotku klapky: spojte čepel a kryt klapky. Typ klapky závisí na použitém servoru (3,7 g nebo 9 g).
7. Připojte servo ke klapce. **Nemonťte klapku na kryt v této fázi** — Servovací úhly se nastavují po programování.

### Kroky 8–10: Elektronický oddíl

<div class="grid cards" markdown>
- ![8](../../img/008.jpg)
- ![9](../../img/009.jpg)
- ![10](../../img/010.jpg)
</div>

8. Zajistěte řídící desku v elektronickém oddíle.
9. Nainstalujte a připojte napájecí konektor. Použijte svorkovnice USHVI pro napájecí kabely.
10. Položte a zajistěte senzorické kabely v kabelovém kanálu. Nainstalujte víko elektronického oddílu.

!!! warning "Instalace termistoru"
    Nainstalujte termistor u okraje topného prvku, přibližně v polovině výšky žeber chladiče.

    Obnažené části drátů u základny termistoru se nesmí dotýkat kovového tělesa ohřívače. V případě potřeby izolujte tyto oblasti kapton páskou nebo je umístěte do teflonové trubky / termokompresivní trubky.

    Teplota ohřívače může dosáhnout 140 °C.

![Instalace termistoru](../../img/thermistor.jpg)

---

## Po montáži

Před prvním spuštěním:

- [ ] Zkontrolujte izolaci všech připojení.
- [ ] Ujistěte se, že kabely nejsou stlačeny víky.
- [ ] Ujistěte se, že je teplotní jistič v dobrém kontaktu s topným prvkem.
- [ ] Zkontrolujte integritu kabeláže multimetrem.

Dalším krokem je instalace firmware v sekci "Řadič".

---

!!! quote "Poděkování"
    Obrovské poděkování Igorovi (@dr_perry_coke) za jeho vynikající práci, estetický smysl a poskytnuté obrázky montáže iDryer Unit.
