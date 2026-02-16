// --- EFHW 100W "Baitcaster" PETG EDITION V14 ---
// Optimized for PETG: 0.2% shrinkage, high layer adhesion.

toroid_od = 62;        
hub_depth = 52;       
flange_d = 175;       
wall = 5.0;             // Slightly thinner than ABS for PETG efficiency
clearance = 6;        // Tighter clearance (PETG warps less)
$fn = 100;

// 1. THE STATIONARY FRAME 
module left_frame_cage() {
    color("dodgerblue") {
        difference() {
            union() {
                translate([0, 0, -clearance])
                    cylinder(d = flange_d + 20, h = wall);
                for(a = [0, 90, 180, 270]) rotate([0,0,a])
                    translate([flange_d/2 + 6, 0, -clearance])
                        cylinder(d = 13, h = hub_depth + (clearance*2) + wall);
                translate([0, flange_d/2 + 6, hub_depth/2])
                    rotate([90, 0, 0]) cylinder(d = 20, h = 15, center=true);
                translate([-110, -25, -clearance]) cube([90, 50, wall]);
            }
            // M8 Axle & Nut Trap (Tight fit for PETG)
            translate([0, 0, -clearance - 1]) {
                cylinder(d = 8.2, h = wall + 2); 
                rotate([0, 0, 30]) cylinder(d = 14.2, h = 4.0, $fn=6); 
            }
            // Wire Pass-through
            translate([0, flange_d/2 + 6, hub_depth/2])
                rotate([90, 0, 0]) cylinder(d = 8, h = 35, center=true); 
            // Frame Cooling Vents
            for(v = [0:45:359]) rotate([0,0,v])
                translate([toroid_od/2, -4, -clearance - 1]) cube([20, 8, wall + 2]);
        }
    }
}

// 2. THE ROTATING DRUM 
module rotating_drum() {
    difference() {
        union() {
            cylinder(d = toroid_od + 24, h = hub_depth - wall); 
            cylinder(d = flange_d, h = wall); 
            translate([0,0, hub_depth - wall]) 
                cylinder(d = toroid_od + 18, h = 4);
        }
        translate([0, 0, wall]) cylinder(d = toroid_od + 18.5, h = hub_depth + 10); 
        // Bearing Seat (Tight 22mm 608zz fit)
        translate([0, 0, -1]) cylinder(d = 22.15, h = wall + 2); 
        
        translate([toroid_od/2 + 5, 0, (hub_depth-wall)/2]) rotate([0, 90, 0])
            cylinder(d = 7, h = 35);
            
        for(i = [0:120:359]) rotate([0,0,i]) {
            translate([toroid_od/2 + 8, 0, hub_depth - wall - 12])
                cylinder(d = 4.1, h = 15);
            translate([toroid_od/2 + 8, 0, hub_depth - wall - 8.5])
                rotate([0, 0, 30]) cylinder(d = 7.8, h = 3.5, $fn=6);
        }
    }
}

// 3. THE MASTER CAP (Flat Face)
module master_cap() {
    translate([flange_d + 40, 0, 0]) {
        difference() {
            union() {
                cylinder(d = flange_d, h = wall); 
                translate([flange_d/2 - 20, 0, wall])
                    cylinder(d1=22, d2=18, h=38);
            }
            translate([0,0,-1]) cylinder(d = 9.8, h = wall + 2); // BNC
            translate([22, 0, -1]) cylinder(d = 5.2, h = wall + 2); // Ground
            
            for(i = [0:120:359]) rotate([0,0,i])
                translate([toroid_od/2 + 8, 0, -1]) cylinder(d = 4.5, h = wall + 2);

            // Zip-Tie Tunnels
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([toroid_od/2 - 8, -2.5, -1]) cube([5, 5, wall + 2]); 
                translate([toroid_od/2 + 2, -2.5, -1]) cube([5, 5, wall + 2]); 
            }

            // Cooling Vents
            for(v = [0, 120, 240]) rotate([0,0,v+30])
                translate([toroid_od/4, -4, -1]) cube([18, 8, wall + 2]);
        }
    }
}

// Render
left_frame_cage();
rotating_drum();
master_cap();