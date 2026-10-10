## Bezpečnost

Firmware řadiče — Klipper nebo Standalone — poskytuje softwarovou ochranu:

- sledování teploty pomocí termistorů;
- ověření připojení teplotních senzorů;
- ochrana před teplotami mimo bezpečné limity;
- použití časovačů v případě zhroucení systému;
- automatické vypnutí při chybách senzoru nebo řadiče.

Kromě toho je implementován hardwarový chránič:

Je instalován teplotní ochranný prvek KSD9700 (130 °C), který fyzicky odpojí napájení topného prvku v případě přehřátí. To je kriticky důležité v případě jakýchkoli softwarových nebo hardwarových selhání.

Řadič je vybaven jističem 2 A, který chrání zařízení. V případě poruchy se přepálí a zcela vypne systém.

Používá se topný prvek PTC s úplnou elektrickou izolací. Na rozdíl od většiny řešení vytápění není těleso PTC topného prvku pod napětím, což eliminuje riziko úrazu elektrickým proudem při instalaci a údržbě komory 3D tiskárny.

Takový víceúrovňový systém ochrany činí iDryer Unit bezpečným řešením pro sušení filamentu, a to i během dlouhodobého nepřetržitého provozu.

!!! warning "Instalace termistoru"
    Ujistěte se, že obnažené části drátů na základně termistoru nedotýkají kovového tělesa topného prvku. V případě potřeby izolujte tyto oblasti kapton páskou nebo je umístěte do teflonové trubky / termokompresivní trubky.

    Pamatujte, že teplota topného prvku může dosáhnout 140 °C.

!!! danger "KSD9700 — není konečná ochrana"
    KSD9700 (teplotní ochranný prvek) je samoobnovující se zařízení: při přehřátí otevře obvod, ale jakmile teplota klesne pod práh, automaticky se opět zavře. V případě poruchy topného prvku se zařízení bude cyklicky přehřívat a chladit bez zásahu. Toto není nouzové vypnutí — je to nekonečná smyčka přehřívání.

    Pro nepřetržitý provoz nahraďte KSD9700 jednorázovým teplotním pojistkou (např. **RH130**). Při spuštění trvale přerušuje obvod — zařízení se vypne a zůstane v bezpečném stavu až do výměny.

!!! note "Doporučený postup"
    Používejte KSD9700 během montáže a ladění. Po ověření funkčnosti jej nahraďte teplotním pojistkou.
