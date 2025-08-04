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

### Installing the Thermistor and thermal fuse

!!! warning "Installing the thermistor"
    Make sure that the thermistor wires do not come into contact with the metal body of the heater. If you're unsure, insulate the thermistor - for example, by wrapping it with Kapton tape or placing it in any heat-resistant insulating material, such as a Teflon sleeve or heat-shrink tubing.
    
    Keep in mind that the heater temperature can reach up to 140°C.

!!! warning "Thermal Fuse Installation"
    You can install either a resettable thermal switch (such as the KSD9700) or a thermal fuse.

    Keep in mind that a thermal fuse is a one-time protection device: when the rated temperature is exceeded, it permanently breaks the circuit and must be replaced with an identical fuse.

    In contrast, the KSD9700 is a bimetallic thermal switch. It cuts off power when a set temperature is reached and automatically reconnects the circuit once the temperature drops below the threshold. This allows the system to recover without needing to replace the component.

    From a safety perspective, a thermal fuse offers more reliable protection, as it completely shuts down the system in case of overheating and prevents it from turning back on automatically.

    Since this is a DIY project, and working with heating elements requires a clear understanding of electrical safety, it’s recommended to first test your setup using a KSD9700, and once everything is working correctly, replace it with an appropriate thermal fuse(one suitable option is the RH130 model) for maximum safety.
