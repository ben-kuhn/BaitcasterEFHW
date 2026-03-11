// --- EFHW 100W "Baitcaster" V20 ---
// Optimized for 40m wire capacity with reduced filament usage
// Multi-material support with automatic tolerance compensation

// ========================================
// MATERIAL SELECTION
// ========================================
// Set material type: "PETG" or "ABS"
material = "PETG"; // <-- CHANGE THIS TO SWITCH MATERIALS

// Material-specific tolerance compensation
bearing_seat = (material == "PETG") ? 22.15 : 22.4;  // 608zz bearing fit
m8_bore = (material == "PETG") ? 8.2 : 8.8;          // M8 axle bolt
m4_nut_trap = (material == "PETG") ? 7.9 : 8.5;      // M4 captured nuts
wall = (material == "PETG") ? 5.5 : 5.0;             // Wall thickness

// Common parameters
toroid_od = 62;
hub_depth = 55;
flange_d = 120;       // Reduced from 175mm for 40m capacity
clearance = 6;
$fn = 100;

// Display material info
echo(str("=== Building for ", material, " ==="));
echo(str("Bearing seat: ", bearing_seat, "mm"));
echo(str("Wall thickness: ", wall, "mm"));

// ========================================
// 1. THE STATIONARY FRAME (Y-Shaped Base with Integrated Handle)
// ========================================
module left_frame_cage() {
    color("dodgerblue") {
        difference() {
            union() {
                // Y-shaped base (3 arms at 120° apart) - saves filament vs circular
                // Arm 1: Integrated with handle (longer and wider)
                translate([0, -18, -clearance])
                    cube([flange_d/2 + 85, 36, wall]);

                // Arms 2 and 3: Standard width
                for(a = [120, 240]) rotate([0, 0, a]) {
                    translate([0, -12, -clearance])
                        cube([flange_d/2 + 10, 24, wall]);
                }

                // Reinforced center hub for axle - THICKER for strength
                translate([0, 0, -clearance])
                    cylinder(d = 35, h = wall + 3);

                // Thin guard pillars (8mm diameter) - one on each Y arm
                for(a = [0, 120, 240]) rotate([0, 0, a])
                    translate([flange_d/2 + 4, 0, -clearance])
                        cylinder(d = 8, h = hub_depth + (clearance*2) + wall);

                // Eyelet Support on arm opposite handle (120° position) - HOLLOW TUBE
                rotate([0, 0, 120])
                    translate([flange_d/2 + 4, 0, hub_depth/2])
                        rotate([90, 0, 90])
                            difference() {
                                cylinder(d = 20, h = 12, center=true);
                                // Hollow interior (saves filament while maintaining strength)
                                cylinder(d = 13, h = 14, center=true);
                            }

                // Ergonomic Handle with fully rounded edges (no sharp corners anywhere)
                hull() {
                    // Start of handle (near drum) - rounded top and bottom
                    for(y = [-10, 10]) {
                        translate([flange_d/2 + 15, y, -clearance + 2])
                            sphere(r = 2, $fn = 20);
                        translate([flange_d/2 + 15, y, -clearance + wall - 2])
                            sphere(r = 2, $fn = 20);
                    }
                    // Grip end - rounded top and bottom
                    for(y = [-8, 8]) {
                        translate([flange_d/2 + 55, y, -clearance + 2])
                            sphere(r = 2, $fn = 20);
                        translate([flange_d/2 + 55, y, -clearance + wall - 2])
                            sphere(r = 2, $fn = 20);
                    }
                }
            }
            // M8 Nut Trap - now in reinforced center
            translate([0, 0, -clearance - 1]) {
                cylinder(d = m8_bore, h = wall + 5);
                rotate([0, 0, 30]) cylinder(d = 14.3, h = 4.5, $fn=6);
            }

            // Eyelet Bore
            rotate([0, 0, 120])
                translate([flange_d/2 + 4, 0, hub_depth/2])
                    rotate([90, 0, 90]) cylinder(d = 9, h = 30, center=true);

            // Frame Vents in Y-arms (not in handle arm)
            for(a = [120, 240]) rotate([0, 0, a])
                translate([15, -5, -clearance - 1])
                    cube([flange_d/2 - 25, 10, wall + 2]);

            // LIGHTENING SLOTS in Y-arms - elongated ovals to save filament
            for(a = [120, 240]) rotate([0, 0, a])
                hull() {
                    translate([25, -6, -clearance - 1])
                        cylinder(d = 8, h = wall + 2, $fn = 20);
                    translate([45, -6, -clearance - 1])
                        cylinder(d = 8, h = wall + 2, $fn = 20);
                }

            // LIGHTENING SLOT in handle arm
            hull() {
                translate([flange_d/2 + 25, -6, -clearance - 1])
                    cylinder(d = 8, h = wall + 2, $fn = 20);
                translate([flange_d/2 + 45, -6, -clearance - 1])
                    cylinder(d = 8, h = wall + 2, $fn = 20);
            }
        }
    }
}

// ========================================
// 2. THE ROTATING DRUM (Hub with Back Spool Rim on Bearing Side)
// ========================================
module rotating_drum() {
    spoke_width = 3;          // Width of each spoke (minimal - just for wire retention)
    rim_width = 4;            // Width of outer rim (minimal)
    crank_spoke_angle = 0;    // Angle for reinforced crank handle spoke
    back_rim_height = 10;     // Height of back rim for wire retention

    difference() {
        union() {
            // Center hub (hollow cylinder for toroid) - 4mm wall for heat handling
            cylinder(d = toroid_od + 26, h = hub_depth - wall);

            // BEARING REINFORCEMENT - thicker base around bearing seat
            cylinder(d = bearing_seat + 12, h = wall + 3);

            // ALIGNMENT RIM at top (slots into cap's alignment ring)
            translate([0, 0, hub_depth - wall])
                cylinder(d = toroid_od + 19, h = 4);

            // REINFORCEMENT BOSSES for M4 nut traps (thicken wall at these points)
            for(i = [0:120:359]) rotate([0, 0, i])
                translate([toroid_od/2 + 10, 0, hub_depth - wall - 15])
                    cylinder(d = 12, h = 15); // Solid boss around each nut trap

            // 6 spokes on BACK/BOTTOM (bearing side, close to frame)
            for(a = [0:60:359]) {
                spoke_w = (a == crank_spoke_angle) ? spoke_width * 3 : spoke_width; // Crank spoke 3x wider for wire exit
                rotate([0, 0, a])
                    translate([0, -spoke_w/2, 0])
                        cube([flange_d/2, spoke_w, back_rim_height]);
            }

            // BACK RIM - Simple continuous ring at outer edge (bearing side)
            translate([0, 0, 0])
                difference() {
                    cylinder(d = flange_d, h = back_rim_height);
                    translate([0, 0, -1])
                        cylinder(d = flange_d - rim_width * 2, h = back_rim_height + 2);
                }
        }

        // Hollow interior for toroid
        translate([0, 0, wall])
            cylinder(d = toroid_od + 18, h = hub_depth + 10);

        // Bearing seat at bottom (material-specific)
        translate([0, 0, -1])
            cylinder(d = bearing_seat, h = wall + 2);

        // TRIANGULAR COOLING VENTS around bearing (narrow near bearing, wide at outer edge)
        for(v = [0:60:359]) rotate([0, 0, v])
            hull() {
                // Narrow end (near bearing)
                translate([bearing_seat/2 + 8, -1.5, -1])
                    cube([1, 3, wall + 4]);
                // Wide end (outer edge)
                translate([bearing_seat/2 + 18, -4, -1])
                    cube([1, 8, wall + 4]);
            }

        // Binding post pass-through (straight hole for screw with ring terminals)
        // Connects transformer output (inside) to antenna wire (outside)
        rotate([0, 0, crank_spoke_angle])
            translate([toroid_od/2 + 7, 0, hub_depth/2])
                rotate([0, 90, 0]) {
                    // Straight-through hole for M4 or #8 screw with ring terminals on both sides
                    cylinder(d = 4.5, h = 25);
                }

        // M4 nut traps for cap attachment (at TOP of hub)
        for(i = [0:120:359]) rotate([0, 0, i]) {
            translate([toroid_od/2 + 14, 0, hub_depth - wall - 12])
                cylinder(d = 4.1, h = 15);
            translate([toroid_od/2 + 14, 0, hub_depth - wall - 8.5])
                rotate([0, 0, 30]) cylinder(d = m4_nut_trap, h = 4, $fn=6);
        }

        // No cooling slots in rim - keeping it simple and consistent

        // COOLING SLOTS in hub walls (vertical slots - stop before alignment rim)
        for(v = [15:30:359]) rotate([0, 0, v])
            translate([toroid_od/2 + 7, -2.5, back_rim_height + 2])
                cube([22, 5, hub_depth - back_rim_height - wall - 8]);
    }
}

// ========================================
// 3. THE MASTER CAP (Simple Flat Disc with Outer Rim)
// ========================================
module master_cap() {
    rim_width = 4;            // Width of outer rim (minimal - matches drum)
    front_rim_height = 10;    // Height of front rim for wire retention (matches drum)

    translate([flange_d + 20, 0, 0]) {
        difference() {
            union() {
                // FLAT BASE DISC (solid, electronics mounting surface)
                cylinder(d = flange_d, h = wall);

                // SIMPLE OUTER RIM - just a ring at the edge (extends UP from flat disc)
                difference() {
                    cylinder(d = flange_d, h = front_rim_height);
                    translate([0, 0, -1])
                        cylinder(d = flange_d - rim_width * 2, h = front_rim_height + 2);
                }

                // Crank handle extending UP from outer edge (positioned to clear all mounting features)
                rotate([0, 0, 85]) // Position at 85° - good clearance from M4 holes (0°,120°,240°) and zip-ties (60°,180°,300°)
                    translate([flange_d/2 - 20, 0, 0])
                        cylinder(d1 = 24, d2 = 18, h = 38);
            }

            // Alignment ring (mates with drum hub)
            translate([0, 0, -1])
                difference() {
                    cylinder(d = toroid_od + 19.5, h = 4.5);
                    translate([0, 0, -1]) cylinder(d = toroid_od + 18.5, h = 6.5);
                }

            // BNC connector hole (CENTER of flat disc)
            translate([0, 0, -1])
                cylinder(d = 13.5, h = wall + 2);

            // Ground lug hole (offset)
            translate([22, 0, -1])
                cylinder(d = 5.3, h = wall + 2);

            // M4 screw holes for attachment to drum (3 holes at 120°)
            for(i = [0:120:359]) rotate([0, 0, i])
                translate([toroid_od/2 + 10, 0, -1])
                    cylinder(d = 4.5, h = wall + 2);

            // Zip-tie slots for toroid mounting (in flat base)
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([toroid_od/2 - 10, -3, -1]) cube([6, 6, wall + 2]);
                translate([toroid_od/2 + 4, -3, -1]) cube([6, 6, wall + 2]);
            }

            // LARGE TRIANGULAR COOLING VENTS - fewer but bigger, concentrated at toroid
            // Positioned between mounting features (avoid BNC, M4 holes, zip-ties)
            for(v = [30, 150, 270]) rotate([0, 0, v])
                hull() {
                    // Narrow end (just outside BNC/center area)
                    translate([16, -3, -1])
                        cube([1, 6, wall + 2]);
                    // Wide end (around toroid perimeter for maximum exhaust)
                    translate([toroid_od/2 + 8, -8, -1])
                        cube([1, 16, wall + 2]);
                }

            // LIGHTENING HOLES - reduce filament in non-structural areas
            // Ring of holes at mid-radius between toroid and rim (skip 75° - under crank handle)
            for(v = [15, 45, 105, 135, 165, 195, 225, 255, 285, 315, 345]) rotate([0, 0, v])
                translate([flange_d/2 - 15, 0, -1])
                    cylinder(d = 8, h = wall + 2, $fn = 20);
        }
    }
}

// ========================================
// LAYOUT FOR SLICER
// ========================================
left_frame_cage();
rotating_drum();
master_cap();
