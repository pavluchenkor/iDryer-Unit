# NAMING_RULES - file and assembly naming system for projects

This document defines a unified standard for naming **parts, assemblies, and components** for all device families (e.g., **UNIT**, **IHEATER**, **IDRYER**, etc.). Following these rules ensures clarity, consistency, and scalability of names in CAD/PLM, on the website, in BOMs, and when sharing files.

---

## General principles
- The first element in the name is always the **device name** (DEVICE): `UNIT`, `IHEATER`, `IDRYER`, …
- All names in the project must follow the same naming convention.
- The structure should work uniformly across different devices.

---

## Name format

```
<DEVICE>_[<VARIANT>_] <MODULE> _ <PART> [ _ <SUFFIX1> [ _ <SUFFIX2> ... ] ]
```

**Where:**
- `<DEVICE>` - the device or product family name:
  - `UNIT` - Unit device
  - `IHEATER` - iHeater device
  - `IDRYER` - iDryer device
- `<VARIANT>` - **device variant** (optional):
  - `MCU` - specific to Unit MCU version
  - `EXT` - specific to Unit EXT version
  - `DUO`, `PRO`, etc. - for future variants
  - absence of `<VARIANT>` = part is **shared** across all variants
- `<MODULE>` - **major assembly/block** of the device:
  - `BASE`, `COVER`, `ELEC`, `SCREEN`, `SPOOL`, `ROLLER`, `DAMPER`, `LABEL`, `FLOOR`, `INLET`, `OUTLET`, …
- `<PART>` - specific part/function: `plate`, `frame`, `mount`, `holder`, `diffuser`, …
- `<SUFFIX*>` - optional clarifiers: side, size, version, revision (`left`, `right`, `v2`, `revA`, …).

---

## Examples

**Shared parts (for all device variants):**
```
UNIT_COVER_MAIN
UNIT_ROLLER_SMALL
IHEATER_BASE_PLATE
```

**MCU-specific parts:**
```
UNIT_MCU_SCREEN_FRAME
UNIT_MCU_ELEC_MOUNT
```

**EXT-specific parts:**
```
UNIT_EXT_ELEC_BOX
UNIT_EXT_SCREEN_DIFFUSER
```

**For other projects:**
```
IDRYER_BASE_FLOOR
IDRYER_DUO_COVER_TOP
```

---

## 3) Usage recommendations
- **Shared parts** must always be named without variant (`UNIT_`, `IHEATER_`, …).
- **Variant-specific parts** must be named with the variant (`UNIT_MCU_`, `UNIT_EXT_`).
- When new devices appear (e.g., iDryer Duo), apply the same format (`IDRYER_DUO_…`).
- Document all new names in `NAMING_RULES.md` so the team and users understand the system.

