# Design Document: EFHW-100W "Baitcaster" Deployment System

## 1. Project Overview
The **EFHW-100W "Baitcaster"** is a specialized 3D-printed enclosure and wire management system designed for End-Fed Half-Wave (EFHW) antennas. It bridges the gap between portable QRP winders and heavy-duty stationary baluns by integrating a high-power transformer (Unun) directly into a "baitcasting-style" reel.

### Core Specifications
* **Transformer Support:** Optimized for FT240-43 ferrite toroid (ID: 36.35mm, OD: 60.25mm).
* **Power Rating:** 100W PEP (SSB); 30W-50W Continuous (Digital/FT8).
* **Architecture:** Stationary Handle with Rotating Modular Drum.
* **Material:** Single parametric design supports PETG or ABS/ASA with automatic tolerance compensation.

---

## 2. Design Philosophy
The system utilizes a **Fixed-Cage Architecture**. Unlike traditional reels where the frame is a simple handle, this design employs a wrap-around cage that serves three purposes:
1. **Mechanical Protection:** Protects the spool flanges from side-impacts.
2. **Backlash Prevention:** The cage pillars prevent wire from jumping the spool (bird-nesting) during rapid deployment.
3. **Safety:** Keeps the operator's hands away from the rotating antenna wire.

---

## 3. Mechanical Components

### A. Handle (The Chassis)
The handle is the interface between the user and the antenna.
* **Y-Shaped Tubular Design:** Three 3/4-round tubular arms at 120° spacing.
* **Ergonomic Profile:** Short arms (8mm diameter) and long arm with handle (10mm diameter).
* **Central Hub:** 3/4-sphere design with M8 axle bore and nut trap on bottom.
* **Flat Printing Surface:** Top surface is flat for printing against bed.
* **Pillar Mounting:** M3 screw holes at each arm end for attaching separate guard pillars.

### B. Guard Pillars (Separate Parts)
The pillars are printed separately and attached to the handle with M3 hardware.
* **3/4-Round Profile:** Flat on one side for printing, rounded for comfort.
* **Flared Ends:** Tapered sections at top and bottom for rigidity.
* **Wire Eyelet:** One pillar includes a hollow tube (8mm bore) for wire guidance.
* **M3 Hardware:** Nut pockets at both ends for handle and optional rim attachment.
* **Left/Right Handed:** Eyelet pillar can be installed at 120° or 240° position for left or right-handed operation.

### C. Rotating Drum (The Spool)
The drum is a hollow "cup" design that houses the RF transformer.
* **Bearing Core:** 22.15mm (PETG) / 22.4mm (ABS) press-fit seat for 608zz bearing.
* **Bearing Retention:** 2mm retention ring prevents bearing from sliding out.
* **Support Collar:** 4mm wall collar around bearing for secure grip.
* **Alignment Pegs:** Two 5mm pegs at 90° and 270° for cap registration.
* **Captured Nut System:** Three M3 hexagonal pockets at 41mm radius for cap attachment.
* **Internal Reinforcement:** Ring around each nut pocket with insertion slot.
* **Spoke Design:** Six spokes with one widened for wire exit.
* **Cooling Slots:** Vertical slots in hub walls for ventilation.

### D. Master Cap (Electronics & Drive)
The cap houses all RF connections and mounts the transformer.
* **Flat Disc Design:** 4mm thick, 120mm diameter.
* **Alignment Peg Holes:** Match drum pegs for precise registration.
* **BNC Connector:** D-shaped hole (9.5mm dia, 8.4mm flat-to-edge) with counterbore.
* **Ground Bolt:** 5.3mm hole at 14mm radius (inside toroid center opening). Uses pigtail with quick-connect for counterpoise.
* **Zip-Tie Slots:** Six slots for toroid mounting (10-16mm and 33-39mm radii).
* **Crank Handle:** Tapered cylinder at 85° for retrieval.
* **Cooling Vents:** Triangular vents for heat dissipation.

### E. Optional Pillar Rim
A circular ring that screws to the pillar tops for additional rigidity.
* **Circular Design:** 148mm outer diameter, 12mm wide ring.
* **M3 Mounting:** Three screw holes align with pillar nut pockets.
* **Crank Clearance:** Circular shape allows unobstructed handle rotation.

### F. Bearing Spacer
A small printed ring that replaces metal washers for drum-to-handle spacing.
* **Dimensions:** 13.5mm OD × 4mm tall with M8 bore.
* **Function:** Fits in retention ring hole, contacts bearing, spaces drum from handle.
* **Recommendation:** Print spares as these are small and easy to lose.

---

## 4. Engineering Specifications

### Material Tolerances (Shrinkage Compensation)
| Feature | Nominal | ABS/ASA | PETG |
| :--- | :--- | :--- | :--- |
| **Bearing Seat** | 22.0mm | 22.4mm | 22.15mm |
| **M3 Nut Trap** | 5.5mm | 6.5mm | 6.2mm |
| **Axle Bore** | 8.0mm | 8.8mm | 8.2mm |
| **Wall Thickness** | - | 4.0mm | 4.0mm |

### Print Bed Compatibility
All parts fit on a standard 220×220mm print bed:
* **Handle:** ~150mm diameter (Y-shaped tubular)
* **Drum:** 120mm diameter
* **Cap:** 120mm diameter
* **Pillar Rim:** 148mm diameter
* **Bearing Spacer:** 13.5mm diameter
* **Guard Pillars:** ~55mm × 16mm each

### Thermal Management
The design employs **Triple-Zone Ventilation**:
1. **Intake:** Triangular vents on Master Cap.
2. **Convection:** Internal air gap between toroid and walls.
3. **Exhaust:** Vertical slots in drum hub.

---

## 5. Hardware Interface (BOM)

| Component | Specification | Function |
| :--- | :--- | :--- |
| **Central Axle** | M8 x 65mm Stainless Bolt | Main Rotation Axis |
| **Axle Nut** | M8 Hex Nut | Captured in Handle |
| **Main Bearing** | 608zz (8x22x7mm) | Friction Reduction |
| **Cap Screws** | 3x M3 x 12mm Machine Screws | Cap-to-Drum Closure |
| **Cap Nuts** | 3x M3 Hex Nuts | Captured in Drum |
| **Pillar Screws** | 6x M3 x 10mm Machine Screws | Pillar-to-Handle (and rim) |
| **Pillar Nuts** | 6x M3 Hex Nuts | Captured in Pillars |
| **Ground Bolt** | M5 x 10mm Bolt + Nut | Counterpoise Pigtail Attachment |
| **RF Input** | BNC Bulkhead (Female, D-flat) | Coaxial Interface |

---

## 6. Safety & RF Considerations
* **High Voltage:** The antenna wire can develop high RF voltages at 100W. The eyelet provides a smooth guide surface to prevent wire abrasion during deployment.
* **Center of Gravity:** The toroid is mounted close to the bearing axis to minimize wobble during winding.
* **UV Stability:** ABS/ASA recommended for long-term outdoor exposure.

---

## 7. Ergonomics & Handedness
The design accommodates both left and right-handed operators:
* **Grip Position:** Fixed at 0° position on the handle.
* **Eyelet Pillar:** Can be installed at either 120° (right-handed) or 240° (left-handed) position.
* **Plain Pillars:** Fill the remaining two positions.

This flexibility allows the wire to deploy on the operator's preferred side while maintaining comfortable grip and crank handle access.

---
