## Safety

The iDryer Unit controller operates as a primary or secondary MCU within the Klipper firmware, thereby enabling Klipper to perform:

* temperature control using thermistors;
* verification of thermistor connections;
* protection against temperatures exceeding safe thresholds;
* utilization of timers to handle system freezes;
* automatic shutdown in case of sensor or controller errors.

Additional hardware safety measures include:

A KSD9700 thermal fuse (rated for 130°C) is installed, physically disconnecting power to the heating element in the event of overheating. This is critically important in cases of software glitches or hardware malfunctions.

The controller is equipped with a 2A fuse that safeguards the device, burning out during an emergency and completely powering off the system.

A fully electrically insulated PTC heating element is used. Unlike most heating solutions, the body of the PTC heater is not electrically charged, eliminating the risk of electric shock during installation and maintenance of the 3D printer chamber.

Such a multi-level safety system makes the iDryer Unit a safe filament drying solution, even during prolonged continuous operation.
