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
* **Frame:** Press-fit the **M8 Nut** into the hexagonal recess on the back of the handle.
* **Drum:** Press the **608zz Bearing** into the center seat of the spool.
* **Nut Pockets:** Drop **3x M4 Nuts** into the pockets inside the drum's rim.
* **Binding Post:** Insert an **M4 x 20mm Stainless Screw** through the spool exit port from the inside out. Secure it on the outside with a nut or wingnut. This is your antenna wire connection point.
* **Pillars:** Insert **M3 nuts** into the nut pockets on each pillar (accessible from the flat side). Each pillar has two nut pockets (top and bottom ends).

### Step 2: The "Marriage" (Axle Installation)
Because the axle bolt is inside the hub, it must be installed before the cap is closed.
1. Pass the **M8 x 65mm Bolt** through the center of the **Master Cap** (from the inside out).
2. Align the **Master Cap** against the **Rotating Drum**, passing the bolt through the drum's bearing.
3. Thread the bolt into the **Stationary Frame** handle.
4. **Tighten:** Use a **deep-well socket** inside the open hub to tighten the M8 bolt. Ensure the assembly spins freely on the bearing with no lateral play.



### Step 3: Final Wiring & Closure
1. Solder the internal jumper wire from the transformer secondary to the head of the **Binding Post screw** inside the drum.
2. Carefully tuck the wires to avoid contact with the rotating axle bolt.
3. Align the Master Cap with the drum's M4 nut pockets.
4. Insert the **3x M4 x 16mm screws** through the cap and tighten to seal the hub.

### Step 4: Pillar Installation
1. Position the **eyelet pillar** at the 120° position (opposite the handle). The eyelet should face outward.
2. Position the **plain pillars** at the 0° and 240° positions.
3. Insert **M3 x 12mm screws** through the frame mounting bosses from below.
4. Tighten into the captured M3 nuts in each pillar's bottom flare.
5. **(Optional)** Install the **pillar rim** using M3 screws through the rim into the pillar top nuts.

---

## 4. Post-Build Testing

Before deploying wire, perform a continuity check with a multimeter:

| Test Path | Expected Result |
| :--- | :--- |
| BNC Center to External Binding Post | Continuity (Low Resistance) |
| BNC Shield to Ground Lug (M5) | Continuity (Zero Resistance) |
| BNC Center to BNC Shield | Continuity (DC Short - Normal for Autotransformers) |

---

## 5. Updated Bill of Materials (BOM)

| Item | Quantity | Specification |
| :--- | :--- | :--- |
| **Main Bearing** | 1 | 608zz Skateboard Bearing |
| **Main Axle** | 1 | M8 x 65mm Stainless Bolt |
| **Axle Nut** | 1 | M8 Stainless Hex Nut |
| **Cap Closure Screws** | 3 | M4 x 16mm Stainless Machine Screws |
| **Captured Cap Nuts** | 3 | M4 Stainless Hex Nuts |
| **Pillar Screws** | 6 | M3 x 12mm Stainless Machine Screws |
| **Pillar Nuts** | 6 | M3 Stainless Hex Nuts |
| **Binding Post Screw** | 1 | M4 x 20mm Stainless Screw (Spool Exit) |
| **Binding Post Nut** | 1 | M4 Stainless Nut or Wingnut (External) |
| **Ground Hardware** | 1 | M5 x 15mm Bolt + Wingnut |
| **Toroid** | 1 | FT240-43 Ferrite Core |
| **Connector** | 1 | BNC Female Bulkhead (Single Hole) |

## 6. Printed Parts

| Part | Quantity | Notes |
| :--- | :--- | :--- |
| **Frame** | 1 | Print with supports if needed |
| **Drum** | 1 | Print bearing-side down |
| **Cap** | 1 | Print flat side down |
| **Plain Pillar** | 2 | Print flat side down |
| **Eyelet Pillar** | 1 | Print flat side down (has wire guide) |
| **Pillar Rim** | 1 | Optional, for extra rigidity |