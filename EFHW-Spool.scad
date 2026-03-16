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
wall = (material == "PETG") ? 4.0 : 4.0;             // Wall thickness

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

                // Arms 2 and 3: Standard width (extended to support pillars)
                for(a = [120, 240]) rotate([0, 0, a]) {
                    translate([0, -12, -clearance])
                        cube([flange_d/2 + 16, 24, wall]);
                }

                // Reinforced center hub for axle - THICKER for strength
                translate([0, 0, -clearance])
                    cylinder(d = 35, h = wall + 3);

                // Triangular gussets for frame rigidity (offset to avoid vents/slots)
                for(a = [0, 120, 240]) rotate([0, 0, a])
                    hull() {
                        // Tall end at hub (overlaps hub cylinder for full contact)
                        translate([12, 5, -clearance])
                            cube([2, 6, wall + 3]);
                        // Tapers to base plate near pillar
                        translate([flange_d/2 - 5, 5, -clearance])
                            cube([2, 6, wall + 0.1]);
                    }

                // Thin guard pillars (8mm diameter) - one on each Y arm
                for(a = [0, 120, 240]) rotate([0, 0, a])
                    translate([flange_d/2 + 8, 0, -clearance])
                        cylinder(d = 8, h = hub_depth + (clearance*2) + wall);

                // Smooth tapered buttress at pillar bases for added support
                for(a = [0, 120, 240]) rotate([0, 0, a])
                    hull() {
                        // Wide base on arm (elliptical footprint)
                        translate([flange_d/2 + 4, 0, -clearance])
                            cylinder(d = 2, h = wall, $fn = 20);
                        translate([flange_d/2 + 14, 0, -clearance])
                            cylinder(d = 2, h = wall, $fn = 20);
                        translate([flange_d/2 + 8, 8, -clearance])
                            cylinder(d = 2, h = wall, $fn = 20);
                        translate([flange_d/2 + 8, -8, -clearance])
                            cylinder(d = 2, h = wall, $fn = 20);
                        // Tapers up to pillar
                        translate([flange_d/2 + 8, 0, -clearance])
                            cylinder(d = 8, h = 10, $fn = 40);
                    }

                // Eyelet Support on arm opposite handle (120° position) - HOLLOW TUBE
                rotate([0, 0, 120])
                    translate([flange_d/2 + 8, 0, hub_depth/2])
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

            // Eyelet Bore (matches 13mm interior diameter)
            rotate([0, 0, 120])
                translate([flange_d/2 + 8, 0, hub_depth/2])
                    rotate([90, 0, 90]) cylinder(d = 13, h = 30, center=true);

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

            // M4 screw holes and nut pockets in pillar tops (for optional rim)
            pillar_top = hub_depth + clearance + wall;  // Top of pillars in frame coords
            for(a = [0, 120, 240]) rotate([0, 0, a]) {
                // Screw hole through pillar top
                translate([flange_d/2 + 8, 0, pillar_top - 12])
                    cylinder(d = 4.5, h = 13);
                // Nut pocket
                translate([flange_d/2 + 8, 0, pillar_top - 12])
                    rotate([0, 0, 30]) cylinder(d = m4_nut_trap, h = 4, $fn = 6);
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
    back_rim_height = wall;   // Height of back rim (matches base thickness)

    difference() {
        union() {
            // Center hub (hollow cylinder for toroid) - 4mm wall for heat handling
            cylinder(d = toroid_od + 26, h = hub_depth - wall);

            // BEARING REINFORCEMENT - thicker base around bearing seat
            cylinder(d = bearing_seat + 12, h = wall + 3);

            // ALIGNMENT PEGS (2 pegs at 90° and 270° to avoid M4 holes and zip-tie slots)
            for(a = [90, 270]) rotate([0, 0, a])
                translate([toroid_od/2 + 10, 0, hub_depth - wall])
                    cylinder(d = 5, h = 6);

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

        // M4 nut traps for cap attachment (at TOP of hub, aligned with bosses)
        for(i = [0:120:359]) rotate([0, 0, i]) {
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 12])
                cylinder(d = 4.1, h = 15);
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 8.5])
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
    translate([flange_d + 20, 0, 0]) {
        difference() {
            union() {
                // FLAT BASE DISC (solid, electronics mounting surface)
                cylinder(d = flange_d, h = wall);

                // Crank handle extending UP from outer edge (positioned to clear all mounting features)
                rotate([0, 0, 85]) // Position at 85° - good clearance from M4 holes (0°,120°,240°) and zip-ties (60°,180°,300°)
                    translate([flange_d/2 - 20, 0, 0])
                        cylinder(d1 = 24, d2 = 18, h = 38);
            }

            // Alignment peg holes (match pegs on drum at 90° and 270°)
            for(a = [90, 270]) rotate([0, 0, a])
                translate([toroid_od/2 + 10, 0, -1])
                    cylinder(d = 5.5, h = wall + 2);  // Slightly larger than 5mm pegs

            // BNC connector hole (D-shaped for anti-rotation flat)
            translate([0, 0, -1])
                difference() {
                    cylinder(d = 9.5, h = wall + 2);
                    // Flat side for anti-rotation (8.4mm from flat to opposite edge)
                    translate([-5, 3.65, -1])
                        cube([10, 5, wall + 4]);
                }

            // BNC counterbore (reduces thickness for washer/nut engagement)
            // 6.75mm threads - 0.7mm washers - 2.3mm nut = 3.75mm max material
            translate([0, 0, wall - 0.25])
                cylinder(d = 14, h = 1);

            // Ground lug hole (inside toroid center hole, 16.875mm inner radius with wire)
            translate([14, 0, -1])
                cylinder(d = 5.3, h = wall + 2);

            // M4 screw holes for attachment to drum (3 holes at 120°)
            for(i = [0:120:359]) rotate([0, 0, i])
                translate([toroid_od/2 + 10, 0, -1])
                    cylinder(d = 4.5, h = wall + 2);

            // Zip-tie slots for toroid mounting (in flat base)
            // Toroid: ID=36.35mm, OD=60.25mm, wire=1.3mm
            // Inner opening with wire: 16.875mm radius, outer edge: 31.425mm radius
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([10, -3, -1]) cube([6, 6, wall + 2]);   // Inner slot (10-16mm, inside hole)
                translate([33, -3, -1]) cube([6, 6, wall + 2]);   // Outer slot (33-39mm, outside toroid)
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
// 4. OPTIONAL PILLAR RIM (Printed Separately)
// ========================================
module pillar_rim() {
    rim_thickness = 4;
    rim_width = 12;
    pillar_radius = flange_d/2 + 8;

    translate([-(flange_d + 40), 0, 0]) {
        difference() {
            union() {
                // Triangular rim connecting pillar positions
                for(a = [0, 120, 240]) rotate([0, 0, a])
                    hull() {
                        // Boss at this pillar
                        translate([pillar_radius, 0, 0])
                            cylinder(d = rim_width, h = rim_thickness);
                        // Connect to next pillar
                        rotate([0, 0, 120])
                            translate([pillar_radius, 0, 0])
                                cylinder(d = rim_width, h = rim_thickness);
                    }
            }

            // M4 screw holes at each pillar position
            for(a = [0, 120, 240]) rotate([0, 0, a])
                translate([pillar_radius, 0, -1])
                    cylinder(d = 4.5, h = rim_thickness + 2);
        }
    }
}

// ========================================
// LAYOUT FOR SLICER
// ========================================
left_frame_cage();
rotating_drum();
master_cap();
pillar_rim();  // Optional - print separately if desired
