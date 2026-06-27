# iDryer Unit Troubleshooting

When using **iDryer Unit**, connection stability issues may occur in some cases (dropouts, MCU "disappearing", unstable operation). In most cases, this is caused not by the device itself but by external factors: vibration, electromagnetic interference, or load characteristics.

The main causes and solutions are described below.

---

## 1. USB cable vibration

!!! warning "Symptoms"
    - Intermittent connection dropouts
    - Device "disappears" from the system
    - Connection restores when touching the cable

!!! info "Cause"
    Vibrations from the printer or the dryer itself can cause micro-movements of the USB connector, leading to brief loss of contact.

!!! success "Solution"
    - Firmly secure the USB cable in the connector
    - Eliminate cable tension
    - If necessary:
        - use a cable with a tighter fit
        - secure the cable with hot glue / cable tie / holder

---

## 2. Power line interference

!!! warning "Symptoms"
    - Connection loss when heating or fan turns on
    - Random device reboots
    - Unstable operation without obvious cause

!!! info "Cause"
    AC power wires generate electromagnetic interference that induces noise on the USB cable.

!!! success "Solution"
    - Separate the USB cable and power wires as much as possible
    - Do not route them through the same cable channel
    - Avoid parallel routing over long distances
    - Install a ferrite filter (ferrite ring) on the USB cable near the controller and/or printer board

---

## 3. Fan interference

!!! warning "Symptoms"
    - Connection loss when the fan switches on/off
    - Glitches coinciding with dryer fan operation
    - Instability under PWM control

!!! info "Cause"
    A 110–230 V fan with a switching power supply can generate interference affecting signal lines.

!!! success "Solution"
    Install an **RC snubber** in parallel with the fan. Alternatively, use a ferrite filter on the USB cable.

---

## 4. USB 3.0 port — operational issues

!!! warning "Symptoms"
    - Intermittent connection dropouts during operation
    - Device "disappears" from the system without apparent reason
    - Problem disappears when switching to a different port

!!! info "Cause"
    This is a common issue with USB Full Speed (USB 2.0) devices connected to USB 3.0 ports. Modern computers use eUSB2 repeaters in USB 3.0 ports, which are not fully compatible with the USB 2.0 specification — this leads to synchronization failures and device enumeration errors. The issue is officially confirmed by STMicroelectronics: [ST FAQ](https://community.st.com/t5/stm32-mcus/faq-possible-communication-failure-between-stlink-v3-and-some/ta-p/736578).

!!! success "Solution"
    - Connect iDryer Unit **only to USB 2.0 ports** (usually black connectors)
    - If all ports are USB 3.0 — use an **active USB hub with USB 2.0 ports**

---

## 5. USB 3.0 port — flashing issues

!!! warning "Symptoms"
    - Controller not detected in bootloader mode (BOOTSEL)
    - Flashing fails or freezes
    - Device is detected but image write fails

!!! info "Cause"
    Same USB 3.0 / xHCI compatibility issue. Particularly relevant when flashing via USB Type-C ports on modern laptops — these more often use problematic eUSB2 repeaters.

!!! success "Solution"
    - When flashing, connect the controller **only to a USB 2.0 port**
    - Prefer USB Type-A ports on the rear panel of a desktop PC
    - If the problem persists — use an **active USB hub with USB 2.0 ports**
