# Before Assembly

Review this section before purchasing components. Make sure all required parts and tools are available.

!!! warning "Electrical safety"
    The device operates at 110–230 V. Read the [Safety](safety.md) section before starting work.

---

## CAD models

Print the enclosure before starting assembly. Models and print parameters: [CAD](cad.md).

Enclosure material: **ABS, ABS-CF, ABS-GF, PC, or HTPLA**. Do not use PLA or PETG — they will not withstand operating temperatures.

---

## Bill of materials for one unit

### Electronics and components

| Component | Qty | Notes |
|---|---|---|
| iDryer Unit MCU board | 1 | Main unit; each additional unit requires an EXT board |
| PTC heater 110–230 V, 100 W | 1 | |
| Fan | 1 | For air circulation |
| NTC 100K temperature sensor | 1 | Or any sensor supported by Klipper / Standalone |
| SHT3X temperature and humidity sensor | 1 | Or any I2C sensor supported by firmware |
| Thermal Protector KSD9700 (130 °C) | 1 | Or single-use Thermal Fuse RH130 |
| Servo for damper | 1 | 3.7 g or 9 g (see CAD section) |
| RJ45 patch cable | one per EXT unit | Standard Cat5e or higher |

### Hardware and connectors

| Item | Notes |
|---|---|
| Terminal connectors | Per board schematic |
| Ferrule terminals | For crimping heater wires |
| Heat shrink tubing | For insulating connections |

### Software

Decide on the operating mode before assembly — it determines the firmware:

- **Klipper** — requires a printer with Klipper installed.
- **Standalone** — operates without a printer, control via display and/or portal.

See [About the project](../README.md#two-modes-of-operation) for details.

---

## Tools

- RJ45 crimping tool
- Ferrule crimping pliers
- Soldering iron (if needed)
- Multimeter for connection testing
- Screwdriver and wrenches matching fastener sizes

---

## Recommendation

Assemble the system **on a bench without mounting in the enclosure** and run initial tests:

1. Connect the heater, fan, sensors, and servo to the board.
2. Load the firmware and verify correct operation of each component.
3. Only after a successful test, mount the components in the enclosure.

Shorten sensor and power wires to the minimum required length during final assembly.
