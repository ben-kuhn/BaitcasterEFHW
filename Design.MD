# Design Document: EFHW-100W "Baitcaster" Deployment System

## 1. Project Overview
The **EFHW-100W "Baitcaster"** is a specialized 3D-printed enclosure and wire management system designed for End-Fed Half-Wave (EFHW) antennas. It bridges the gap between portable QRP winders and heavy-duty stationary baluns by integrating a high-power transformer (Unun) directly into a "baitcasting-style" reel.

### Core Specifications
* **Transformer Support:** Optimized for FT240-43 (2.4" OD) Ferrite Toroids.
* **Power Rating:** 100W PEP (SSB); 30W-50W Continuous (Digital/FT8).
* **Architecture:** Stationary Frame with a Rotating Modular Drum.
* **Material Optimization:** Specific variants for ABS/ASA (High Heat) and PETG (High Impact).

---

## 2. Design Philosophy
The system utilizes a **Fixed-Cage Architecture**. Unlike traditional reels where the frame is a simple handle, this design employs a wrap-around cage that serves three purposes:
1. **Mechanical Protection:** Protects the spool flanges from side-impacts.
2. **Backlash Prevention:** The cage pillars prevent wire from jumping the spool (bird-nesting) during rapid deployment.
3. **Safety:** Keeps the operator's hands away from the rotating high-voltage antenna wire.

---

## 3. Mechanical Components

### A. Stationary Frame (The Chassis)
The frame is the interface between the user and the antenna.
* **Hand Grip:** Ergonomically offset to balance the weight of the 100W toroid.
* **Axle Nut Trap:** A recessed hexagonal pocket designed to lock an M8 nut. This allows the central axle bolt to be tightened from the hub interior without external tools.
* **Integrated Eyelet:** A reinforced 10mm bore tube that acts as a level-wind guide.
* **Cooling Vents:** Passthrough slots that align with the spool to allow air intake.

### B. Rotating Drum (The Spool)
The drum is a hollow "cup" design that serves as the RF transformer's Faraday-shield-equivalent housing.
* **Bearing Core:** A 22.1mm–22.4mm (material dependent) press-fit seat for a standard 608zz skateboard bearing.
* **Captured Nut System:** Three hexagonal pockets on the rim to hold M4 nuts. This provides metal-to-metal threading for the removable cap, preventing stripped plastic threads.
* **Wire Exit Port:** A smoothed 8mm lateral hole for the high-voltage antenna lead.

### C. Master Cap (Electronics & Drive)
The cap is the "brain" of the system, housing all RF connections.
* **Modular Interface:** Removable to allow for transformer maintenance or ratio changes (e.g., swapping a 49:1 for a 9:1).
* **Zip-Tie Channels:** Integrated "tunnels" designed to secure the FT240 toroid directly to the cap face.
* **Crank Handle:** Permanently mounted to the cap to provide high-torque retrieval.
* **Connection Plane:** Precision holes for a BNC Bulkhead and an M5 Stainless Ground Bolt.

---

## 4. Engineering Specifications

### Material Tolerances (Shrinkage Compensation)
| Feature | Dimension | ABS/ASA (1.0%) | PETG (0.2%) |
| :--- | :--- | :--- | :--- |
| **Bearing Seat** | 22.0mm | 22.4mm | 22.15mm |
| **M4 Nut Trap** | 7.0mm (Flats) | 8.5mm (Points) | 7.8mm (Points) |
| **Axle Bore** | 8.0mm | 8.8mm | 8.2mm |
| **Wall Thickness**| N/A | 5.5mm | 5.0mm |

### Thermal Management
At 100W, the transformer undergoes hysteresis heating. The "Baitcaster" employs **Triple-Zone Ventilation**:
1. **Intake:** Face-slots on the Master Cap.
2. **Convection:** Internal air gap between the toroid and the ABS/PETG walls.
3. **Exhaust:** Radial slots on the drum back-plate and frame chassis.



---

## 5. Hardware Interface (BOM)

| Component | Specification | Function |
| :--- | :--- | :--- |
| **Central Axle** | M8 x 65mm Stainless Bolt | Main Rotation Axis |
| **Main Bearing** | 608zz (8x22x7mm) | Friction Reduction |
| **Cap Screws** | 3x M4 x 16mm Machine Screws | Structural Closure |
| **Ground Lug** | M5 x 15mm Stainless Bolt/Wingnut | Counterpoise Connection |
| **RF Input** | BNC Bulkhead (Female) | Coaxial Interface |
| **Fasteners** | 3x M4 Hex Nuts / 1x M8 Hex Nut | Captured Threading |

---

## 6. Safety & RF Considerations
* **High Voltage:** The antenna wire exit point can see >2000V at 100W. The design uses a 10mm clearance in the eyelet to prevent arcing to the frame.
* **Center of Gravity:** The toroid is mounted as close to the bearing axis as possible to minimize wobble during high-speed winding.
* **UV Stability:** Recommended for ABS/ASA for long-term field exposure.

---