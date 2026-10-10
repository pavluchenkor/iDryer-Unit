# iDryer Unit FAQ

---

### **Is iDryer Unit compatible with my printer?**
iDryer Unit works with any 3D printer running the **current version of Klipper**.
A standalone firmware will be available once it leaves **pre-beta**.

---

### **How many spools does iDryer Unit support?**
Available versions:

- **Single spool**,
- **Dual spool (Unit Duo)**.
- iDryer is an **open-source project**, and you can modify the enclosure for any number of spools. Keep in mind that larger enclosures also increase heat loss.

---

### **Which controller is used in iDryer Unit?**
It uses **RP2040**.

---

### **Can I use BTT, MKS, or other boards?**
iDryer Unit is an **open-source project**. All enclosure and part models are available on GitHub in **STEP** and **STL** formats.
You can adapt the design for any hardware.
Many user-made modifications are already available on GitHub.

---

### **Do I need a special sealant or gasket?**
The kit includes a **silicone tube** (Ø 2 mm, wall 1 mm).
You can also use a gasket made of **TPU (Shore 65-75A)**.

---

### **What typical issues may occur?**
If the heater goes into **uncontrolled heating**, check the **thermistor installation**.
The controller only acts based on thermistor readings. An incorrectly installed thermistor leads to no proper feedback and may cause overheating and enclosure damage. Damaged enclosures require reprinting, so thermistor installation must strictly follow the instructions.

---

### **What to do if Klipper reports I2C NACK error?**
If Klipper reports **I2C NACK**, it means the sensor did not respond to a query. Possible reasons:

- **Incorrect sensor wiring.** Check soldering and pinout connections.
- **Excessive line length.** I2C is intended for short PCB-level connections; lines longer than 20-30 cm may be unstable.
- **Wrong address in config.** Configuration (`cfg`) may include multiple possible addresses (usually two). If everything else looks correct, try switching to the alternate address.

---

### **Will the enclosure melt at 130 °C?**
The configured temperature (e.g., **130 °C**) is measured by the thermistor placed closest to the heating element.

- At the edges of the aluminum tube, the temperature is much lower due to airflow.
- The design includes **spacers** (screws or plastic elements) that reduce thermal load.

⚠️ On first startup, determine safe operating limits:

1. Increase temperature stepwise (**5-10°C** per step).
2. Once the heater stabilizes, carefully probe the enclosure with a thin rigid tool.
3. If plastic softens or the heater sticks to the enclosure, reduce the set temperature.

---

### **How is safety handled?**
Safety is ensured at multiple levels:

- **Software control**: the heater is controlled via thermistor readings. Overheating triggers automatic shutdown.

- **Watchdog timer**: built into the MCU, prevents firmware hangs.

- **Hardware protection**: thermal fuse is used. For testing, **KSD-9700** may be used (auto-resets after cooling). For permanent use, replace with **RH-135** (trips at 135 °C and permanently opens).

- The controller board also has a **fuse** to protect against short circuits.

---

### **How well do printed rollers work?**
Printed rollers are a practical solution and perform reliably in operation, especially when made from heat-resistant materials.
However, if issues arise, you can fabricate **aluminum tubes of the required size**.

---

### **Where can I find documentation?**
Documentation is available here:

- [Project GitHub](https://github.com/idryer)
- [docs.idryer.org](https://docs.idryer.org)
