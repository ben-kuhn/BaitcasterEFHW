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
4. **The Crossover (Fair-Rite Method):** After the 7th turn of the secondary, cross the wire over to the opposite side of the toroid before finishing the final 7 turns. This maximizes bandwidth and reduces heat.
5. **Mounting:** Place the toroid on the inside face of the **Master Cap**. Thread zip ties through the integrated tunnels and cinch the toroid firmly.



---

## 2. Electrical Preparation (Cap Side)

1. **Mount Connectors:** Install the **BNC Bulkhead** in the center hole of the Master Cap and the **M5 Ground Bolt** in the offset hole.
2. **Solder Capacitor:** Bridge the **100pF 3kV capacitor** directly across the BNC connector (Center Pin to Shield/Ground).
3. **Grounding:** Run a heavy gauge jumper wire or copper braid from the Ground Lug to the BNC Shield terminal.
4. **Internal Lead:** Solder a flexible jumper wire (approx. 10cm) to the "End" of the transformer secondary.

---

## 3. Mechanical Assembly

### Step 1: Hardware Preparation
* **Frame:** Press-fit the **M8 Nut** into the hexagonal recess in the center hub.
* **Drum:** Press the **608zz Bearing** into the center seat of the spool.
* **Drum Nut Pockets:** Drop **3x M4 Nuts** into the pockets inside the drum's rim (at 0°, 120°, 240°).
* **Binding Post:** Insert an **M4 x 20mm Stainless Screw** through the spool exit port from the inside out. Secure it on the outside with a nut or wingnut. This is your antenna wire connection point.
* **Optional Rim Nuts:** If using the pillar rim, slide **3x M4 Nuts** into the slots at the top of each pillar.

### Step 2: The "Marriage" (Axle Installation)
Because the axle bolt is inside the hub, it must be installed before the cap is closed.
1. Pass the **M8 x 65mm Bolt** through the center of the **Master Cap** (from the inside out).
2. Align the **Master Cap** against the **Rotating Drum**, matching the alignment pegs (at 90° and 270°) to their holes.
3. Pass the bolt through the drum's bearing.
4. Thread the bolt into the **Stationary Frame** center hub.
5. **Tighten:** Use a **deep-well socket** inside the open hub to tighten the M8 bolt. Ensure the assembly spins freely on the bearing with no lateral play.

### Step 3: Final Wiring & Closure
1. Solder the internal jumper wire from the transformer secondary to the head of the **Binding Post screw** inside the drum.
2. Carefully tuck the wires to avoid contact with the rotating axle bolt.
3. Align the Master Cap with the drum's M4 nut pockets (at 0°, 120°, 240°).
4. Insert the **3x M4 x 16mm screws** through the cap and tighten to seal the hub.

### Step 4: Optional Pillar Rim Installation
The pillars are integrated into the frame. For additional rigidity, install the optional rim:
1. Ensure **M4 nuts** are inserted into the slots at the top of each pillar.
2. Place the **pillar rim** over the pillars, aligning the screw holes.
3. Insert **3x M4 x 12mm screws** through the rim into the captured nuts.
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

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Main Bearing** | 1 | 608zz Skateboard Bearing |
| **Main Axle** | 1 | M8 x 65mm Stainless Bolt |
| **Axle Nut** | 1 | M8 Stainless Hex Nut |
| **Cap Closure Screws** | 3 | M4 x 16mm Stainless Machine Screws |
| **Captured Cap Nuts** | 3 | M4 Stainless Hex Nuts |
| **Rim Screws** | 3 | M4 x 12mm Stainless Machine Screws (optional) |
| **Rim Nuts** | 3 | M4 Stainless Hex Nuts (optional) |
| **Binding Post Screw** | 1 | M4 x 20mm Stainless Screw (Spool Exit) |
| **Binding Post Nut** | 1 | M4 Stainless Nut or Wingnut (External) |
| **Ground Hardware** | 1 | M5 x 15mm Bolt + Wingnut |
| **Toroid** | 1 | FT240-43 Ferrite Core |
| **Connector** | 1 | BNC Female Bulkhead (D-flat style) |

## 6. Printed Parts

| Part | Quantity | Notes |
| :--- | :--- | :--- |
| **Frame** | 1 | Includes integrated pillars and eyelet |
| **Drum** | 1 | Print bearing-side down |
| **Cap** | 1 | Print flat side down |
| **Pillar Rim** | 1 | Optional, for extra rigidity |