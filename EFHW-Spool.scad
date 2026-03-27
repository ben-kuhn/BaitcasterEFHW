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
m3_nut_trap = (material == "PETG") ? 6.2 : 6.5;      // M3 captured nuts
wall = (material == "PETG") ? 4.0 : 4.0;             // Wall thickness

// Common parameters
toroid_od = 62;
hub_depth = 55;
flange_d = 120;       // Reduced from 175mm for 40m capacity
clearance = 6;
$fn = 100;

// Pillar parameters (must be after flange_d, hub_depth, clearance, wall)
pillar_radius = flange_d/2 + 8;                      // Distance from center to pillar
pillar_height = hub_depth;                           // Match drum+cap height (55mm + 4mm rim = 59mm)

// Display material info
echo(str("=== Building for ", material, " ==="));
echo(str("Bearing seat: ", bearing_seat, "mm"));
echo(str("Wall thickness: ", wall, "mm"));

// ========================================
// 1. THE HANDLE (Y-Shaped Tubular Frame)
// ========================================
// Print with flat top (drum contact surface) against bed
// 3/4-round tubes: small flat on bed side, mostly rounded
module handle() {
    short_arm_radius = 6.5;   // 13mm diameter for short legs
    long_arm_radius = 8;      // 16mm diameter for long leg + handle
    hub_radius = 12;        // Central hub

    // 3/4 sphere - flat on top at Z=0, rounded underneath
    module three_quarter_sphere(r) {
        translate([0, 0, -r/2])  // Shift so flat surface is at Z=0
            intersection() {
                sphere(r = r, $fn = 30);
                // Keep bottom 3/4: from -r to +r/2
                translate([-r, -r, -r])
                    cube([r * 2, r * 2, r * 1.5]);
            }
    }

    color("dodgerblue") {
        difference() {
            union() {
                // Central hub - 3/4 sphere
                three_quarter_sphere(hub_radius);

                // Short arms at 120° and 240° (13mm diameter)
                for(a = [120, 240]) rotate([0, 0, a])
                    hull() {
                        // Hub end
                        three_quarter_sphere(short_arm_radius);
                        // Pillar end
                        translate([pillar_radius, 0, 0])
                            three_quarter_sphere(short_arm_radius);
                    }

                // Long arm at 0° (16mm diameter) - extends into handle
                hull() {
                    // Hub end
                    three_quarter_sphere(long_arm_radius);
                    // Pillar end
                    translate([pillar_radius, 0, 0])
                        three_quarter_sphere(long_arm_radius);
                }

                // Handle extending from long arm
                hull() {
                    translate([pillar_radius, 0, 0])
                        three_quarter_sphere(long_arm_radius);
                    translate([pillar_radius + 50, 0, 0])
                        three_quarter_sphere(long_arm_radius);
                }
            }

            // M8 axle bore - goes all the way through
            // Hub now extends from Z = -hub_radius*1.5 to Z = 0
            translate([0, 0, -hub_radius * 1.5 - 1])
                cylinder(d = m8_bore, h = hub_radius * 2);

            // M8 nut trap on bottom (rounded side, away from drum)
            // M8 nut is ~6.5mm thick, make pocket 7mm deep
            translate([0, 0, -hub_radius * 1.5 - 1])
                rotate([0, 0, 30]) cylinder(d = 15.5, h = 7, $fn=6);

            // M3 screw holes for pillar mounting with countersink for hex cap heads
            // Short arms (120°, 240°) use short_arm_radius
            for(a = [120, 240]) rotate([0, 0, a]) {
                translate([pillar_radius, 0, -short_arm_radius * 1.5 - 1])
                    cylinder(d = 3.5, h = short_arm_radius * 1.5 + 2);
                // Countersink for M3 hex cap head (6mm dia, 3mm deep)
                translate([pillar_radius, 0, -short_arm_radius * 1.5 - 1])
                    cylinder(d = 6, h = 3);
            }
            // Long arm (0°) uses long_arm_radius
            translate([pillar_radius, 0, -long_arm_radius * 1.5 - 1])
                cylinder(d = 3.5, h = long_arm_radius * 1.5 + 2);
            // Countersink for M3 hex cap head
            translate([pillar_radius, 0, -long_arm_radius * 1.5 - 1])
                cylinder(d = 6, h = 3);
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

            // BEARING REINFORCEMENT - compact base around bearing seat
            cylinder(d = bearing_seat + 6, h = wall);

            // BEARING RETENTION RING - solid disc, center hole cut in difference block
            // Creates a 2mm thick ring to prevent bearing from sliding out
            cylinder(d = bearing_seat, h = 2);

            // ALIGNMENT PEGS (2 pegs at 90° and 270° to avoid M3 holes and zip-tie slots)
            for(a = [90, 270]) rotate([0, 0, a])
                translate([toroid_od/2 + 10, 0, hub_depth - wall])
                    cylinder(d = 5, h = 6);

            // REINFORCEMENT BOSSES for M3 nut traps (thicken wall at these points)
            for(i = [0:120:359]) rotate([0, 0, i])
                translate([toroid_od/2 + 10, 0, hub_depth - wall - 12])
                    cylinder(d = 10, h = 12); // Solid boss around each nut trap

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

        // Bearing seat with retention ring
        // 608zz bearing: 22mm OD, 8mm ID, 7mm wide
        // Ring is 2mm thick at Z=0-2, bearing seat opens above it
        translate([0, 0, -1])
            cylinder(d = 14, h = 4);  // Center hole through ring and spokes (14mm clears M8 axle)
        translate([0, 0, 2])
            cylinder(d = bearing_seat, h = wall + 6);  // Bearing seat above retention ring

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

        // M3 nut traps for cap attachment (at TOP of hub, aligned with bosses)
        for(i = [0:120:359]) rotate([0, 0, i]) {
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 10])
                cylinder(d = 3.4, h = 12);
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 6])
                rotate([0, 0, 30]) cylinder(d = m3_nut_trap, h = 3, $fn=6);
        }

        // No cooling slots in rim - keeping it simple and consistent

        // COOLING SLOTS in hub walls (vertical slots - stop before alignment rim)
        for(v = [15:30:359]) rotate([0, 0, v])
            translate([toroid_od/2 + 7, -2.5, back_rim_height + 2])
                cube([22, 5, hub_depth - back_rim_height - wall - 8]);
    }

    // BEARING SUPPORT RING - added separately so hollow interior doesn't remove it
    // 4mm wall collar around bearing for grip
    difference() {
        cylinder(d = bearing_seat + 10, h = 9);
        // Cut bearing seat and center hole
        translate([0, 0, 2])
            cylinder(d = bearing_seat, h = 10);
        translate([0, 0, -1])
            cylinder(d = 14, h = 4);
    }

    // INTERNAL NUT REINFORCEMENT - ring around each nut pocket
    // Adds material for better nut retention without blocking the pocket
    for(i = [0:120:359]) rotate([0, 0, i])
        difference() {
            // Ring around nut pocket area
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 10])
                cylinder(d = 14, h = 10);
            // Cut out center to match M3 nut trap and screw hole
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 11])
                cylinder(d = 3.4, h = 12);
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 6])
                rotate([0, 0, 30]) cylinder(d = m3_nut_trap, h = 3, $fn=6);
            // Slot for nut insertion from inside drum
            translate([toroid_od/2 + 2, -2.75, hub_depth - wall - 6])
                cube([8, 5.5, 3]);
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
                rotate([0, 0, 85]) // Position at 85° - good clearance from M3 holes (0°,120°,240°) and zip-ties (60°,180°,300°)
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

            // M3 screw holes for attachment to drum (3 holes at 120°)
            for(i = [0:120:359]) rotate([0, 0, i])
                translate([toroid_od/2 + 10, 0, -1])
                    cylinder(d = 3.5, h = wall + 2);

            // Zip-tie slots for toroid mounting (in flat base)
            // Toroid: ID=36.35mm, OD=60.25mm, wire=1.3mm
            // Inner opening with wire: 16.875mm radius, outer edge: 31.425mm radius
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([10, -3, -1]) cube([6, 6, wall + 2]);   // Inner slot (10-16mm, inside hole)
                translate([33, -3, -1]) cube([6, 6, wall + 2]);   // Outer slot (33-39mm, outside toroid)
            }

            // LARGE TRIANGULAR COOLING VENTS - fewer but bigger, concentrated at toroid
            // Positioned between mounting features (avoid BNC, M3 holes, zip-ties)
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

    translate([-(flange_d + 40), 0, 0]) {
        difference() {
            // Circular ring at pillar radius
            difference() {
                cylinder(d = (pillar_radius + rim_width/2) * 2, h = rim_thickness);
                translate([0, 0, -1])
                    cylinder(d = (pillar_radius - rim_width/2) * 2, h = rim_thickness + 2);
            }

            // M3 screw holes at each pillar position with countersink
            for(a = [0, 120, 240]) rotate([0, 0, a]) {
                translate([pillar_radius, 0, -1])
                    cylinder(d = 3.5, h = rim_thickness + 2);
                // Countersink for M3 hex cap head (6mm dia, 3mm deep)
                translate([pillar_radius, 0, -1])
                    cylinder(d = 6, h = 3);
            }
        }
    }
}

// ========================================
// 5. BEARING SPACER (Printed - replaces washers)
// ========================================
// Fits in the retention ring hole, spaces drum from frame
module bearing_spacer() {
    spacer_od = 13.5;      // Fits loosely in 14mm retention hole
    spacer_id = m8_bore;   // M8 bolt passes through
    spacer_height = 4;     // Contacts bearing, spaces drum from frame

    translate([-(flange_d + 40), -(flange_d/2 + 20), 0]) {
        difference() {
            cylinder(d = spacer_od, h = spacer_height);
            translate([0, 0, -1])
                cylinder(d = spacer_id, h = spacer_height + 2);
        }
    }
}

// ========================================
// 6. GUARD PILLAR (Printed Separately - need 2 plain, 1 with eyelet)
// ========================================
module guard_pillar(with_eyelet = false) {
    pillar_dia = 10;          // Diameter of half-cylinder
    flare_len = 8;            // Length of flared ends
    flare_dia = 16;           // Diameter at flared ends
    eyelet_pos = pillar_height / 2;  // Eyelet at midpoint

    // Helper for half-cylinder (flat at Z=0 for print bed, round toward +Z)
    module half_cyl(d, h) {
        intersection() {
            translate([0, d/2, 0])
                rotate([0, 90, 0])
                    cylinder(d = d, h = h, $fn = 40);
            cube([h, d, d/2]);
        }
    }

    // Helper for half-cone (flat at Z=0 for print bed, round toward +Z)
    // Cone is centered at Y = max(d1,d2)/2
    module half_cone(d1, d2, h) {
        intersection() {
            translate([0, max(d1,d2)/2, 0])
                rotate([0, 90, 0])
                    cylinder(d1 = d1, d2 = d2, h = h, $fn = 40);
            cube([h, max(d1,d2), max(d1,d2)/2]);
        }
    }

    // Center Y position for all geometry (flares are centered at Y=flare_dia/2)
    center_y = flare_dia / 2;  // = 8

    translate([-(flange_d + 40), flange_d/2 + 20, 0]) {
        difference() {
            union() {
                // Bottom flare (wide at X=0, tapers to pillar_dia)
                half_cone(flare_dia, pillar_dia, flare_len);

                // Main pillar body
                translate([flare_len, (flare_dia - pillar_dia)/2, 0])
                    half_cyl(pillar_dia, pillar_height - flare_len*2);

                // Top flare (pillar_dia at start, wide at end)
                translate([pillar_height - flare_len, 0, 0])
                    half_cone(pillar_dia, flare_dia, flare_len);

                // 2mm flat spine on bottom (print bed side) for extra thickness
                translate([0, (flare_dia - pillar_dia)/2, -2])
                    cube([pillar_height, pillar_dia, 2]);

                // Tapered base under bottom flare (follows cone profile)
                hull() {
                    // Wide end at X=0
                    translate([0, 0, -2])
                        cube([0.01, flare_dia, 2]);
                    // Narrow end at X=flare_len (matches pillar width)
                    translate([flare_len - 0.01, (flare_dia - pillar_dia)/2, -2])
                        cube([0.01, pillar_dia, 2]);
                }

                // Tapered base under top flare (follows cone profile)
                hull() {
                    // Narrow end (matches pillar width)
                    translate([pillar_height - flare_len, (flare_dia - pillar_dia)/2, -2])
                        cube([0.01, pillar_dia, 2]);
                    // Wide end at X=pillar_height
                    translate([pillar_height - 0.01, 0, -2])
                        cube([0.01, flare_dia, 2]);
                }

                // Eyelet (wire guide) - matches full pillar thickness
                if (with_eyelet) {
                    pillar_y_offset = (flare_dia - pillar_dia)/2;
                    translate([eyelet_pos, pillar_y_offset + pillar_dia/2, -2])
                        cylinder(d = 12, h = pillar_dia/2 + 2, $fn = 40);
                }
            }

            // Eyelet bore - cut through so wire can pass
            if (with_eyelet) {
                pillar_y_offset = (flare_dia - pillar_dia)/2;
                translate([eyelet_pos, pillar_y_offset + pillar_dia/2, -3])
                    cylinder(d = 8, h = pillar_dia/2 + 4, $fn = 40);
            }

            // M3 screw hole at bottom end - through center of pillar thickness
            translate([-1, center_y, pillar_dia/4])
                rotate([0, 90, 0])
                    cylinder(d = 4.0, h = flare_len + 2);

            // M3 nut pocket at bottom - hex axis along X, flats at top/bottom
            translate([flare_len/2 - 1.5, center_y, pillar_dia/4])
                rotate([0, 90, 0])
                    rotate([0, 0, 30])
                        cylinder(d = m3_nut_trap, h = 3, $fn = 6);

            // Nut insertion slot at bottom - from flat side (Z=-2) up to pocket
            translate([flare_len/2 - 1.5, center_y - 2.75, -2.1])
                cube([3, 5.5, pillar_dia/4 + 2.1]);

            // M3 screw hole at top end - through center of pillar thickness
            translate([pillar_height - flare_len - 1, center_y, pillar_dia/4])
                rotate([0, 90, 0])
                    cylinder(d = 4.0, h = flare_len + 2);

            // M3 nut pocket at top - hex axis along X, flats at top/bottom
            translate([pillar_height - flare_len/2 - 1.5, center_y, pillar_dia/4])
                rotate([0, 90, 0])
                    rotate([0, 0, 30])
                        cylinder(d = m3_nut_trap, h = 3, $fn = 6);

            // Nut insertion slot at top - from flat side (Z=-2) up to pocket
            translate([pillar_height - flare_len/2 - 1.5, center_y - 2.75, -2.1])
                cube([3, 5.5, pillar_dia/4 + 2.1]);
        }
    }
}

// ========================================
// LAYOUT FOR SLICER
// ========================================
// Part dimensions (for 220x220mm print bed):
//   Frame:         Y-shaped tubular (print flat side down)
//   Drum:          120mm diameter
//   Cap:           120mm diameter
//   Pillar rim:    148mm diameter (optional)
//   Bearing spacer: 13.5mm diameter x 4mm (print multiple as spares)
//   Guard pillar:  ~55mm x 16mm (print flat side down)
//     - Print 2x plain pillars (0° and 240° positions)
//     - Print 1x eyelet pillar (120° position, has wire guide)
// All parts fit on a standard 220x220mm bed when printed individually.

translate([0, 0, -20])  // Shifted down for easier viewing
    handle();
rotating_drum();
master_cap();
pillar_rim();                    // Optional - print separately if desired
bearing_spacer();                // Replaces washers - print 1 (plus spares)
guard_pillar(with_eyelet=false); // Print 2 of these (for 0° and 240° positions)
translate([0, 30, 0])
    guard_pillar(with_eyelet=true);  // Print 1 of this (for 120° position, has wire guide)
