# Design Document: EFHW-100W "Baitcaster" Deployment System

## 1. Project Overview
The **EFHW-100W "Baitcaster"** is a specialized 3D-printed enclosure and wire management system designed for End-Fed Half-Wave (EFHW) antennas. It bridges the gap between portable QRP winders and heavy-duty stationary baluns by integrating a high-power transformer (Unun) directly into a "baitcasting-style" reel.

### Core Specifications
* **Transformer Support:** Optimized for FT240-43 ferrite toroid (ID: 36.35mm, OD: 60.25mm).
* **Power Rating:** 100W PEP (SSB); 30W-50W Continuous (Digital/FT8).
* **Architecture:** Stationary Frame with Rotating Modular Drum.
* **Material:** Single parametric design supports PETG or ABS/ASA with automatic tolerance compensation.

---

## 2. Design Philosophy
The system utilizes a **Fixed-Cage Architecture**. Unlike traditional reels where the frame is a simple handle, this design employs a wrap-around cage that serves three purposes:
1. **Mechanical Protection:** Protects the spool flanges from side-impacts.
2. **Backlash Prevention:** The cage pillars prevent wire from jumping the spool (bird-nesting) during rapid deployment.
3. **Safety:** Keeps the operator's hands away from the rotating antenna wire.

---

## 3. Mechanical Components

### A. Stationary Frame (The Chassis)
The frame is the interface between the user and the antenna.
* **Y-Shaped Base:** Three arms at 120° spacing, optimized for minimal filament usage.
* **Integrated Guard Pillars:** Three 8mm diameter pillars with tapered buttress bases for rigidity.
* **Triangular Gussets:** Reinforce the connection between hub and pillars.
* **Hand Grip:** Ergonomically offset to balance the weight of the toroid.
* **Axle Nut Trap:** Recessed hexagonal pocket for M8 nut capture.
* **Wire Eyelet:** Hollow tube at 120° position (13mm bore) for wire guidance.
* **Optional Rim Mounting:** M4 nut pockets in pillar tops for optional support rim.
* **Cooling Vents:** Passthrough slots in Y-arms for air intake.

### B. Rotating Drum (The Spool)
The drum is a hollow "cup" design that houses the RF transformer.
* **Bearing Core:** 22.15mm (PETG) / 22.4mm (ABS) press-fit seat for 608zz bearing.
* **Alignment Pegs:** Two 5mm pegs at 90° and 270° for cap registration.
* **Captured Nut System:** Three M4 hexagonal pockets at 41mm radius for cap attachment.
* **Reinforcement Bosses:** Thickened wall sections around M4 nut traps.
* **Spoke Design:** Six spokes with one widened for wire exit.
* **Cooling Slots:** Vertical slots in hub walls for ventilation.

### C. Master Cap (Electronics & Drive)
The cap houses all RF connections and mounts the transformer.
* **Flat Disc Design:** 4mm thick, 120mm diameter.
* **Alignment Peg Holes:** Match drum pegs for precise registration.
* **BNC Connector:** D-shaped hole (9.5mm dia, 8.4mm flat-to-edge) with counterbore.
* **Ground Lug:** 5.3mm hole at 14mm radius (inside toroid center opening).
* **Zip-Tie Slots:** Six slots for toroid mounting (10-16mm and 33-39mm radii).
* **Crank Handle:** Tapered cylinder at 85° for retrieval.
* **Cooling Vents:** Triangular vents for heat dissipation.

### D. Optional Pillar Rim
A circular ring that screws to the pillar tops for additional rigidity.
* **Circular Design:** 148mm outer diameter, 12mm wide ring.
* **M4 Mounting:** Three screw holes align with pillar nut pockets.
* **Crank Clearance:** Circular shape allows unobstructed handle rotation.

---

## 4. Engineering Specifications

### Material Tolerances (Shrinkage Compensation)
| Feature | Nominal | ABS/ASA | PETG |
| :--- | :--- | :--- | :--- |
| **Bearing Seat** | 22.0mm | 22.4mm | 22.15mm |
| **M4 Nut Trap** | 7.0mm | 8.5mm | 7.9mm |
| **Axle Bore** | 8.0mm | 8.8mm | 8.2mm |
| **Wall Thickness** | - | 4.0mm | 4.0mm |

### Print Bed Compatibility
All parts fit on a standard 220×220mm print bed:
* **Frame:** ~183mm × 132mm (print diagonally if needed)
* **Drum:** 120mm diameter
* **Cap:** 120mm diameter
* **Pillar Rim:** 148mm diameter

### Thermal Management
The design employs **Triple-Zone Ventilation**:
1. **Intake:** Triangular vents on Master Cap.
2. **Convection:** Internal air gap between toroid and walls.
3. **Exhaust:** Vertical slots in drum hub and frame vents.

---

## 5. Hardware Interface (BOM)

| Component | Specification | Function |
| :--- | :--- | :--- |
| **Central Axle** | M8 x 65mm Stainless Bolt | Main Rotation Axis |
| **Axle Nut** | M8 Hex Nut | Captured in Frame |
| **Main Bearing** | 608zz (8x22x7mm) | Friction Reduction |
| **Cap Screws** | 3x M4 x 16mm Machine Screws | Cap-to-Drum Closure |
| **Cap Nuts** | 3x M4 Hex Nuts | Captured in Drum |
| **Rim Screws** | 3x M4 x 12mm Machine Screws | Optional Rim Mounting |
| **Rim Nuts** | 3x M4 Hex Nuts | Captured in Pillar Tops |
| **Ground Lug** | M5 x 15mm Bolt + Wingnut | Counterpoise Connection |
| **RF Input** | BNC Bulkhead (Female, D-flat) | Coaxial Interface |

---

## 6. Safety & RF Considerations
* **High Voltage:** The antenna wire can develop high RF voltages at 100W. The eyelet provides a smooth guide surface to prevent wire abrasion during deployment.
* **Center of Gravity:** The toroid is mounted close to the bearing axis to minimize wobble during winding.
* **UV Stability:** ABS/ASA recommended for long-term outdoor exposure.

---