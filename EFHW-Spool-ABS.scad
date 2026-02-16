// --- EFHW 100W "Baitcaster" ABS EDITION V13 ---
// Optimized for 100% flat bed contact and through-hole venting.

toroid_od = 62;        
hub_depth = 52;       
flange_d = 175;       
wall = 5.5;             
clearance = 9;        
$fn = 100;

// 1. THE STATIONARY FRAME 
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
                    rotate([90, 0, 0]) cylinder(d = 22, h = 18, center=true);
                translate([-120, -25, -clearance]) cube([100, 50, wall]);
            }
            translate([0, 0, -clearance - 1]) {
                cylinder(d = 8.8, h = wall + 2); 
                rotate([0, 0, 30]) cylinder(d = 15.0, h = 4.5, $fn=6); 
            }
            translate([0, flange_d/2 + 8, hub_depth/2])
                rotate([90, 0, 0]) cylinder(d = 9, h = 35, center=true); 
            for(v = [0:45:359]) rotate([0,0,v])
                translate([toroid_od/2, -5, -clearance - 1]) cube([22, 10, wall + 2]);
        }
    }
}

// 2. THE ROTATING DRUM (Drum + Alignment Lip)
module rotating_drum() {
    difference() {
        union() {
            cylinder(d = toroid_od + 28, h = hub_depth - wall); 
            cylinder(d = flange_d, h = wall); 
            // Internal alignment lip moved here so Cap can stay flat
            translate([0,0, hub_depth - wall]) 
                cylinder(d = toroid_od + 18, h = 4);
        }
        translate([0, 0, wall]) cylinder(d = toroid_od + 18.5, h = hub_depth + 10); 
        translate([0, 0, -1]) cylinder(d = 22.4, h = wall + 2); 
        translate([toroid_od/2 + 5, 0, (hub_depth-wall)/2]) rotate([0, 90, 0])
            cylinder(d = 8.5, h = 35);
        for(v = [22.5:45:359]) rotate([0,0,v])
            translate([toroid_od/2 - 10, -4, -1]) cube([18, 8, wall + 2]);
        for(i = [0:120:359]) rotate([0,0,i]) {
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 12])
                cylinder(d = 4.5, h = 15);
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 8.5])
                rotate([0, 0, 30]) cylinder(d = 8.5, h = 4, $fn=6);
        }
    }
}

// 3. THE MASTER CAP (Flat Printing Version)
module master_cap() {
    translate([flange_d + 40, 0, 0]) {
        difference() {
            union() {
                cylinder(d = flange_d, h = wall); // Flat face
                // Crank Handle (Only part needing support)
                translate([flange_d/2 - 20, 0, wall])
                    cylinder(d1=24, d2=18, h=38);
            }
            // 1. Center BNC & Ground Bolt
            translate([0,0,-1]) cylinder(d = 10.2, h = wall + 2); 
            translate([24, 0, -1]) cylinder(d = 5.5, h = wall + 2); 
            
            // 2. M4 Mounting Screw Holes 
            for(i = [0:120:359]) rotate([0,0,i])
                translate([toroid_od/2 + 10, 0, -1]) cylinder(d = 4.8, h = wall + 2);

            // 3. ZIP-TIE SLOTS (Tunnels cut into the surface)
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([toroid_od/2 - 10, -3, -1]) cube([6, 6, wall + 2]); // Inner
                translate([toroid_od/2 + 4, -3, -1]) cube([6, 6, wall + 2]); // Outer
            }

            // 4. COOLING VENTS (Radial through-slots)
            for(v = [0, 120, 240]) rotate([0,0,v+30])
                translate([toroid_od/4, -4, -1]) cube([20, 8, wall + 2]);
        }
    }
}

// Render
left_frame_cage();
rotating_drum();
master_cap();