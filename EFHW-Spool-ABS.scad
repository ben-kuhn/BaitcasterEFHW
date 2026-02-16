// --- EFHW 100W "Baitcaster" ABS EDITION (V10) ---
// Note: Tolerances increased by ~0.2mm to account for ABS shrinkage.

toroid_od = 62;        
hub_depth = 52;       
flange_d = 175;       
wall = 5.5;             
clearance = 9;        // Extra gap for ABS warping variance
$fn = 100;

// 1. THE STATIONARY FRAME (Handle, Eyelet, & Nut Trap)
module left_frame_cage() {
    color("teal") {
        difference() {
            union() {
                translate([0, 0, -clearance])
                    cylinder(d = flange_d + 25, h = wall);
                for(a = [0, 90, 180, 270]) rotate([0,0,a])
                    translate([flange_d/2 + 8, 0, -clearance])
                        cylinder(d = 15, h = hub_depth + (clearance*2) + wall);
                
                // REINFORCED EYELET
                translate([0, flange_d/2 + 8, hub_depth/2])
                    rotate([90, 0, 0]) cylinder(d = 22, h = 18, center=true);
                
                // Hand Grip (Beefed up for ABS)
                translate([-120, -25, -clearance]) cube([100, 50, wall]);
            }
            // M8 Axle & Nut Trap (Oversized for shrinkage)
            translate([0, 0, -clearance - 1]) {
                cylinder(d = 8.8, h = wall + 2); 
                rotate([0, 0, 30]) cylinder(d = 15.0, h = 4.5, $fn=6); 
            }
            // Wire Pass-through
            translate([0, flange_d/2 + 8, hub_depth/2])
                rotate([90, 0, 0]) cylinder(d = 9, h = 35, center=true); 
            // Frame Cooling Vents
            for(v = [0:45:359]) rotate([0,0,v])
                translate([toroid_od/2, -5, -clearance - 1]) cube([22, 10, wall + 2]);
        }
    }
}

// 2. THE ROTATING DRUM (Left Flange + Hub)
module rotating_drum() {
    difference() {
        union() {
            cylinder(d = toroid_od + 28, h = hub_depth - wall); 
            cylinder(d = flange_d, h = wall); 
        }
        translate([0, 0, wall]) cylinder(d = toroid_od + 18.5, h = hub_depth); 
        // Bearing Seat (Oversized for 22mm 608zz bearing shrinkage)
        translate([0, 0, -1]) cylinder(d = 22.4, h = wall + 2); 
        
        translate([toroid_od/2 + 5, 0, (hub_depth-wall)/2]) rotate([0, 90, 0])
            cylinder(d = 8.5, h = 35);
            
        for(v = [22.5:45:359]) rotate([0,0,v])
            translate([toroid_od/2 - 10, -4, -1]) cube([18, 8, wall + 2]);
            
        // M4 Nut Pockets (Oversized for 7mm flat-to-flat hex)
        for(i = [0:120:359]) rotate([0,0,i]) {
            translate([toroid_od/2 + 9, 0, hub_depth - wall - 12])
                cylinder(d = 4.5, h = 15);
            translate([toroid_od/2 + 9, 0, hub_depth - wall - 8.5])
                rotate([0, 0, 30]) cylinder(d = 8.5, h = 4, $fn=6);
        }
    }
}

// 3. THE MASTER CAP (Right Flange + Hub Cover + Crank)
module master_cap() {
    translate([flange_d + 40, 0, 0]) {
        difference() {
            union() {
                cylinder(d = flange_d, h = wall); 
                translate([0,0,-3.5]) cylinder(d = toroid_od + 17, h = 4);
                translate([flange_d/2 - 20, 0, wall])
                    cylinder(d1=24, d2=18, h=38); // Stronger Crank Base
            }
            cylinder(d = 10.2, h = wall + 10, center=true); // BNC
            translate([24, 0, -1]) cylinder(d = 5.5, h = wall + 2); // Ground
            for(v = [45:45:359]) rotate([0,0,v])
                translate([toroid_od/4, -4, -1]) cube([22, 8, wall + 2]);
            for(i = [0:120:359]) rotate([0,0,i])
                translate([toroid_od/2 + 9, 0, -5]) cylinder(d = 4.8, h = 20);
        }
    }
}

// Render
left_frame_cage();
rotating_drum();
master_cap();