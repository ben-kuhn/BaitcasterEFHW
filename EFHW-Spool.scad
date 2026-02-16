// --- EFHW 100W "Baitcaster" V9 (Easy-Print Modular Design) ---
toroid_od = 62;        
hub_depth = 52;       
flange_d = 175;       
wall = 5;             
clearance = 8;        
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
                        cylinder(d = 14, h = hub_depth + (clearance*2) + wall);
                translate([0, flange_d/2 + 8, hub_depth/2])
                    rotate([90, 0, 0]) cylinder(d = 20, h = 15, center=true);
                translate([-120, -25, -clearance]) cube([100, 50, wall]);
            }
            // M8 Axle & Nut Trap
            translate([0, 0, -clearance - 1]) {
                cylinder(d = 8.5, h = wall + 2); 
                rotate([0, 0, 30]) cylinder(d = 14.5, h = 4, $fn=6); 
            }
            // Wire Pass-through
            translate([0, flange_d/2 + 8, hub_depth/2])
                rotate([90, 0, 0]) cylinder(d = 8, h = 30, center=true); 
            // Frame Cooling Vents
            for(v = [0:45:359]) rotate([0,0,v])
                translate([toroid_od/2, -4, -clearance - 1]) cube([20, 8, wall + 2]);
        }
    }
}

// 2. THE ROTATING DRUM (Left Flange + Hub + Nut Pockets)
// Print this flat on the left flange (no supports needed for the hub!)
module rotating_drum() {
    difference() {
        union() {
            cylinder(d = toroid_od + 26, h = hub_depth - wall); // Drum Body
            cylinder(d = flange_d, h = wall); // Left Flange
        }
        // Interior for Toroid
        translate([0, 0, wall]) cylinder(d = toroid_od + 18, h = hub_depth); 
        // Bearing Seat
        translate([0, 0, -1]) cylinder(d = 22.1, h = wall + 2); 
        // Wire Exit Path
        translate([toroid_od/2 + 5, 0, (hub_depth-wall)/2]) rotate([0, 90, 0])
            cylinder(d = 8, h = 30);
        // Back Vents
        for(v = [22.5:45:359]) rotate([0,0,v])
            translate([toroid_od/2 - 10, -3, -1]) cube([15, 6, wall + 2]);
        // M4 Nut Pockets for the Cap
        for(i = [0:120:359]) rotate([0,0,i]) {
            translate([toroid_od/2 + 8.5, 0, hub_depth - wall - 12])
                cylinder(d = 4.2, h = 15);
            translate([toroid_od/2 + 8.5, 0, hub_depth - wall - 8])
                rotate([0, 0, 30]) cylinder(d = 8.1, h = 3.5, $fn=6);
        }
    }
}

// 3. THE MASTER CAP (Right Flange + Hub Cover + Crank)
// Print this flat on its face
module master_cap() {
    translate([flange_d + 40, 0, 0]) {
        difference() {
            union() {
                cylinder(d = flange_d, h = wall); // Right Flange
                // Alignment lip to seat into the drum
                translate([0,0,-3]) cylinder(d = toroid_od + 17.5, h = 3);
                // Crank Handle
                translate([flange_d/2 - 20, 0, wall])
                    cylinder(d1=22, d2=18, h=35);
            }
            // BNC Port
            cylinder(d = 9.8, h = wall + 6, center=true); 
            // Ground Bolt (M5)
            translate([22, 0, -1]) cylinder(d = 5.2, h = wall + 2); 
            // Front Cooling Vents
            for(v = [45:45:359]) rotate([0,0,v])
                translate([toroid_od/4, -3, -1]) cube([20, 6, wall + 2]);
            // M4 Screw Holes
            for(i = [0:120:359]) rotate([0,0,i])
                translate([toroid_od/2 + 8.5, 0, -5]) cylinder(d = 4.5, h = 15);
        }
    }
}

// Render
left_frame_cage();
rotating_drum();
master_cap();