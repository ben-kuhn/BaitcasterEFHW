# Usage & Tuning Guide: EFHW-100W "Baitcaster"

Once assembly is complete, the performance of your system depends on the "Half-Wave" wire radiator. This guide explains how to deploy, tune, and maintain your antenna for 100W operation.

---

## 1. Initial Wire Selection
For 100W use, wire gauge and insulation are critical to prevent melting and RF burns.
* **Recommended Wire:** 18 AWG or 20 AWG "Silky" Poly-Stealth or enameled stranded copper.
* **Insulation:** Avoid thin PVC if running high-duty cycles (FT8); PTFE or UV-rated PE is preferred.

---

## 2. Standard Wire Lengths (Starting Point)
Always start with a wire that is **5% longer** than the calculated half-wave to allow for pruning.

| Target Band | Total Wire Length (Approx) |
| :--- | :--- |
| **40m - 10m** | 20.3 meters (66.6 ft) |
| **20m - 10m** | 10.2 meters (33.5 ft) |
| **80m - 10m** | 40.5 meters (133 ft) |

---

## 3. Deployment Procedure

1. **The Ground/Counterpoise:** While an EFHW technically doesn't "need" a counterpoise, a **0.05λ length of wire** (approx. 2m for 40m band) attached to the M5 Ground Wingnut will significantly stabilize your SWR and reduce "RF in the shack."
2. **The Launch:** Hold the "Baitcaster" by the handle and walk away. The spool will spin freely.
3. **Locking:** Once the wire is fully deployed, insert a **5mm pin or bolt** into the frame's locking hole to prevent the spool from turning during tension.
4. **Elevation:** Hoist the far end of the wire into a tree or onto a fiberglass pole. The "Baitcaster" can sit on the ground or be suspended near the feed point.



---

## 4. Tuning for Resonance

EFHW antennas are harmonically related. Tuning for the lowest frequency (e.g., 40m) will generally bring the higher bands (20m, 15m, 10m) into alignment.

### Step-by-Step Tuning
1. **Analyze:** Use an antenna analyzer or your radio's internal SWR meter at low power (5W).
2. **Find the Dip:** Identify where the SWR is lowest. 
    * If the dip is **below** the band (e.g., 6.8 MHz), your wire is **too long**.
    * If the dip is **above** the band (e.g., 7.4 MHz), your wire is **too short**.
3. **Prune:** Cut (or fold back) 5–10 cm of wire at a time from the **far end** (away from the Baitcaster).
4. **Verify High Bands:** Check the SWR on 20m and 10m. 
    * *Note:* If 40m is perfect but 10m is too high in frequency, the 100pF compensation capacitor in the hub may need slight value adjustment, or the wire may need a "compensation coil."

---

## 5. 100W Safety & Maintenance

* **High Voltage:** The end of a half-wave wire carries extreme voltage. Ensure the far end is insulated and out of reach of people or pets.
* **Thermal Check:** After a long transmission, feel the Master Cap vents. If the air is hot, reduce your duty cycle. ABS handles 100°C, but the enameled wire insulation on the toroid can fail if pushed beyond its rating.
* **Storage:** Use the **parking notches** on the spool flange to secure the end of the wire. This prevents the wire from unraveling in your pack.



---

## 6. Troubleshooting
* **High SWR on all bands:** Check the BNC center pin continuity. Ensure the secondary of the transformer is actually connected to the antenna wire.
* **SWR changes when you touch the radio:** Your coax is acting as the counterpoise. Attach a dedicated counterpoise wire to the M5 ground bolt on the hub.
* **Spool is hard to turn:** Loosen the M8 axle bolt slightly. The 608zz bearing should allow for effortless rotation.