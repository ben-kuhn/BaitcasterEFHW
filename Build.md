# Build & Assembly Guide: EFHW-100W "Baitcaster"

This guide provides step-by-step instructions for the mechanical assembly and electrical winding of the 100W End-Fed Half-Wave (EFHW) antenna deployment system.

---

## 1. Transformer Winding (49:1 Unun)

The heart of the system is the broadband transformer. For 100W operation, we utilize an **FT240-43** ferrite toroid to handle the power and heat.

### Required Materials
* **Core:** FT240-43 Ferrite Toroid.
* **Wire:** ~1 meter of 18 AWG Enameled Copper Wire.
* **Capacitor:** 100pF 3kV (High Voltage) Ceramic Disc.
* **Security:** 3x Small UV-resistant Zip Ties.

### Winding Instructions
1. **The Primary:** Wind the first **2 turns** around the toroid.
2. **The Common Tap:** After the 2nd turn, create a small loop or twist in the wire. This is your Common (Ground) connection.
3. **The Secondary:** Continue winding the same wire for another **12 turns** (14 turns total).
4. **The Crossover (Optional):** After the 7th turn of the secondary, cross the wire over to the opposite side of the toroid before finishing the final 7 turns. This can improve bandwidth but does increase losses slightly. Skip this step for maximum efficiency.
5. **Mounting:** Place the toroid on the inside face of the **Master Cap**. Thread zip ties through the integrated slots and cinch the toroid firmly.



---

## 2. Electrical Preparation (Cap Side)

1. **Mount BNC:** Install the **BNC Bulkhead** in the center hole of the Master Cap.
2. **Solder Capacitor:** Bridge the **100pF 3kV capacitor** directly across the BNC connector (Center Pin to Shield/Ground).
3. **Ground Pigtail:** Install the **M5 Ground Bolt** in the offset hole with a ring terminal and nut. Attach a short wire pigtail (15-20cm) with a quick-connect terminal (spade, Anderson PowerPole, or similar) on the free end. This allows easy attachment of counterpoise wires without rotating hardware near the BNC connector.
4. **Internal Grounding:** Run a heavy gauge jumper wire or copper braid from the Ground Bolt ring terminal to the BNC Shield terminal.
5. **Internal Lead:** Solder a flexible jumper wire (approx. 10cm) to the "End" of the transformer secondary.

---

## 3. Mechanical Assembly

### Step 1: Hardware Preparation
* **Frame:** Press-fit the **M8 Nut** into the hexagonal recess on the bottom of the center hub.
* **Drum:** Press the **608zz Bearing** into the center seat of the spool. The retention ring and support collar hold the bearing securely.
* **Drum Nut Pockets:** Slide **3x M3 Nuts** into the pockets inside the drum (at 0°, 120°, 240°) through the insertion slots.
* **Binding Post:** Insert an **M4 x 20mm Stainless Screw** through the spool exit port from the inside out. Secure it on the outside with a nut or wingnut. This is your antenna wire connection point.
* **Pillars:** Attach the three guard pillars to the frame using **M3 screws and nuts**. One pillar includes the wire eyelet.
* **Optional Rim:** If using the pillar rim, install **M3 nuts** in the slots at the top of each pillar.

### Step 2: The "Marriage" (Axle Installation)
Because the axle bolt passes through the entire assembly, washers are used to ensure smooth rotation and proper spacing.
1. Place the **large fender washer** inside the drum, over the bearing.
2. Pass the **M8 x 65mm Bolt** through the center of the **Master Cap** (from the inside out).
3. Align the **Master Cap** against the **Rotating Drum**, matching the alignment pegs (at 90° and 270°) to their holes.
4. Pass the bolt through the fender washer and the drum's bearing.
5. Place a **small spacing washer** on the bolt between the drum and the frame.
6. Thread the bolt into the **Stationary Frame** center hub (nut is on the bottom).
7. **Tighten:** Ensure the assembly spins freely on the bearing with no lateral play. The spacing washer prevents the drum from rubbing against the frame.

### Step 3: Final Wiring & Closure
1. Solder the internal jumper wire from the transformer secondary to the head of the **Binding Post screw** inside the drum.
2. Carefully tuck the wires to avoid contact with the rotating axle bolt.
3. Align the Master Cap with the drum's M3 nut pockets (at 0°, 120°, 240°).
4. Insert the **3x M3 x 12mm screws** through the cap and tighten to seal the hub.

### Step 4: Optional Pillar Rim Installation
For additional rigidity, install the optional rim:
1. Ensure **M3 nuts** are inserted into the slots at the top of each pillar.
2. Place the **pillar rim** over the pillars, aligning the screw holes.
3. Insert **3x M3 x 8mm screws** through the rim into the captured nuts.
4. Tighten evenly.

---

## 4. Post-Build Testing

Before deploying wire, perform a continuity check with a multimeter:

| Test Path | Expected Result |
| :--- | :--- |
| BNC Center to External Binding Post | Continuity (Low Resistance) |
| BNC Shield to Ground Lug (M5) | Continuity (Zero Resistance) |
| BNC Center to BNC Shield | Continuity (DC Short - Normal for Autotransformers) |

---

## 5. Bill of Materials (BOM)

### Fasteners

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Main Axle** | 1 | M8 x 65mm Stainless Bolt |
| **Axle Nut** | 1 | M8 Stainless Hex Nut |
| **Cap Closure Screws** | 3 | M3 x 12mm Stainless Machine Screws |
| **Captured Cap Nuts** | 3 | M3 Stainless Hex Nuts |
| **Pillar Screws (Frame)** | 3 | M3 x 10mm Stainless Machine Screws |
| **Pillar Nuts (Frame)** | 3 | M3 Stainless Hex Nuts |
| **Rim Screws** | 3 | M3 x 8mm Stainless Machine Screws (optional) |
| **Rim Nuts** | 3 | M3 Stainless Hex Nuts (optional) |
| **Binding Post Screw** | 1 | M4 x 20mm Stainless Screw (Spool Exit) |
| **Binding Post Nut** | 1 | M4 Stainless Nut or Wingnut (External) |
| **Ground Bolt** | 1 | M5 x 10mm Bolt + Nut + Ring Terminal |
| **Ground Pigtail** | 1 | 15-20cm wire with quick-connect (spade/PowerPole) |

### Bearings & Washers

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Main Bearing** | 1 | 608zz Skateboard Bearing (8x22x7mm) |
| **Fender Washer** | 1 | M8 x 24mm OD Fender Washer (inside drum) |
| **Spacing Washer** | 1 | M8 Flat Washer (between drum and frame) |

### Electronics

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Toroid** | 1 | FT240-43 Ferrite Core |
| **Connector** | 1 | BNC Female Bulkhead (D-flat style) |
| **Capacitor** | 1 | 100pF 3kV Ceramic Disc |
| **Magnet Wire** | ~1m | 18 AWG Enameled Copper |

### Miscellaneous

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Toroid Zip Ties** | 3 | Small UV-resistant (for securing toroid) |
| **Wire Zip Ties** | 2-3 | Small (for internal wire management) |

---

## 6. Printed Parts

| Part | Quantity | Notes |
| :--- | :--- | :--- |
| **Frame** | 1 | Print flat side (drum contact) down |
| **Drum** | 1 | Print bearing-side down |
| **Cap** | 1 | Print flat side down |
| **Guard Pillar (plain)** | 2 | For two of the three pillar positions |
| **Guard Pillar (eyelet)** | 1 | Has wire guide for antenna deployment |
| **Pillar Rim** | 1 | Optional, for extra rigidity |

### Left-Handed Configuration
The eyelet pillar (wire guide) can be installed at either the 120° or 240° position depending on user preference. For left-handed operation, install the eyelet pillar on the opposite side from the default configuration. The two plain pillars fill the remaining positions.
