# Assembly

## Hardware Assembly

In the base part of the enclosure:

* Connect the heating element and the fan to the iDryer Unit board.
* Install the thermistor and the SHT3X sensor (or any other supported temperature/humidity sensor) inside the dryer and connect them to the corresponding pins on the board.

In the electronics compartment:

* Secure the controller board.
* Install and wire the power connector.

Assemble the remaining components according to the instruction.

## Instruction

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

<div class="grid cards" markdown>
- ![1](imgweb/001.jpg)
- ![2](imgweb/002.jpg)
- ![3](imgweb/003.jpg)
- ![4](imgweb/004.jpg)
- ![5](imgweb/005.jpg)
- ![6](imgweb/006.jpg)
- ![7](imgweb/007.jpg)
- ![8](imgweb/008.jpg)
- ![9](imgweb/009.jpg)
- ![10](imgweb/010.jpg)
</div>

!!! Tip  "Acknowledgements"

```
Huge thanks to Igor (@dr_perry_coke) for the incredible work, aesthetic sense, and the provided iDryer Unit assembly images.
```
