# Řešení problémů s připojením iDryer Unit

Při použití **iDryer Unit** se mohou vyskytovat problémy se stabilitou připojení (přerušení připojení, ztráta MCU, nestabilní chování).  
Ve většině případů je to způsobeno spíše vnějšími faktory: vibracemi, elektromagnetickými poruchami nebo charakteristikami zátěže.

Níže jsou uvedeny hlavní příčiny a způsoby jejich odstranění.

---

## 1. Vibrace USB kabelu

!!! warning "Příznaky"
    - Periodické přerušení připojení  
    - Zařízení zmizí ze systému  
    - Připojení se obnoví při dotyku kabelu  

!!! info "Příčina"
    Vibrace z tiskárny nebo sušičky mohou způsobit mikroposun USB konektoru, což vede ke ztrátě kontaktu.

!!! success "Řešení"
    - Pevně zajistěte USB kabel v konektoru  
    - Vyhnite se tahem na kabel  
    - V případě potřeby:
        - použijte kabel s těsnějším přizpůsobením  
        - zajistěte kabel termolependem / stahovacím páskem / držákem  

---

## 2. Rušení od napájecích kabelů

!!! warning "Příznaky"
    - Ztráta připojení při zapnutí topení nebo ventilátoru  
    - Náhodné restartování zařízení  
    - Nestabilní provoz bez zjevné příčiny  

!!! info "Příčina"
    Napájecí kabely AC vytvářejí elektromagnetické rušení, které se vazí na USB kabel.

!!! success "Řešení"
    - Oddělte USB kabel a napájecí kabely co nejdále od sebe  
    - Nepokládejte je ve stejné kabelové trase  
    - Vyhnite se paralelnímu vedení na dlouhých úsecích  
    - Nainstalujte feritový filtr (feritový válec) na USB kabel blíže ke kontroléru a/nebo k desce tiskárny

---

## 3. Rušení od ventilátoru

!!! warning "Příznaky"
    - Ztráta připojení při zapnutí/vypnutí ventilátoru  
    - Chyby, které se shodují s provozem ventilátoru sušičky  
    - Nestabilita při řízení PWM  

!!! info "Příčina"
    Ventilátor 110–230 V je vybaven spínaným zdrojem a může generovat rušení, které ovlivňuje signálové linky.

!!! success "Řešení"
    Doporučuje se nainstalovat **RC-snubber (snubber)** paralelně s ventilátorem. Nebo používat feritový filtr na USB kabelu.

---

## 4. USB 3.0 port – problémy během provozu

!!! warning "Příznaky"
    - Periodické přerušení připojení během provozu  
    - Zařízení zmizí ze systému bez viditelné příčiny  
    - Problém zmizí při přepnutí na jiný port  

!!! info "Příčina"
    Jedná se o známý problém s USB zařízeními pracujícími v režimu Full Speed (USB 2.0) připojenými na porty USB 3.0. Moderní počítače používají v portech USB 3.0 opakovače eUSB2, které nejsou plně kompatibilní se specifikací USB 2.0 – to vede k chybám synchronizace a výčtu zařízení. Problém byl oficiálně potvrzen společností STMicroelectronics: [FAQ na webu ST](https://community.st.com/t5/stm32-mcus/faq-possible-communication-failure-between-stlink-v3-and-some/ta-p/736578).

!!! success "Řešení"
    - Připojujte iDryer Unit **pouze na porty USB 2.0** (obvykle černé konektory)  
    - Pokud jsou pouze porty USB 3.0 – použijte **aktivní USB rozbočovač s porty USB 2.0**

---

## 5. USB 3.0 port – problémy během flashování

!!! warning "Příznaky"
    - Kontrolér se nepozná v režimu bootloader (BOOTSEL)  
    - Flashování firmware selže nebo se zablokuje  
    - Zařízení je rozpoznáno, ale zápis obrazu selže  

!!! info "Příčina"
    Stejný problém kompatibility USB 3.0 / xHCI. Zejména relevantní při flashování přes porty USB Type-C na moderních laptopech – ty používají problematické opakovače eUSB2 častěji.

!!! success "Řešení"
    - Při flashování připojujte kontrolér **pouze na port USB 2.0**  
    - Preferujte porty USB Type-A na zadní straně PC  
    - Pokud problém přetrvává – použijte **aktivní USB rozbočovač s porty USB 2.0**
