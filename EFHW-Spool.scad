// --- EFHW 100W "Baitcaster" PETG EDITION V19 ---
// Optimized for 220x220mm Build Plates. 

toroid_od = 62;        
hub_depth = 55;       
flange_d = 175;       
wall = 5.5;           
clearance = 6;        
$fn = 100;

// 1. THE STATIONARY FRAME (Compact Handle Design)
module left_frame_cage() {
    color("dodgerblue") {
        difference() {
            union() {
                // Reduced footprint base
                translate([0, 0, -clearance]) cylinder(d = flange_d + 15, h = wall);
                
                // Optimized Pillars (Tapered for clearance)
                for(a = [0, 90, 180, 270]) rotate([0,0,a])
                    translate([flange_d/2 + 4, 0, -clearance])
                        cylinder(d1 = 14, d2 = 12, h = hub_depth + (clearance*2) + wall);
                
                // Eyelet Support
                translate([0, flange_d/2 + 4, hub_depth/2])
                    rotate([90, 0, 0]) cylinder(d = 20, h = 12, center=true);
                
                // Compact "D-Grip" Handle Base
                translate([-105, -20, -clearance]) 
                    cube([80, 40, wall]); // Shortened handle bridge
            }
            // M8 Nut Trap
            translate([0, 0, -clearance - 1]) {
                cylinder(d = 8.2, h = wall + 2); 
                rotate([0, 0, 30]) cylinder(d = 14.3, h = 4.5, $fn=6); 
            }
            // Eyelet Bore
            translate([0, flange_d/2 + 4, hub_depth/2])
                rotate([90, 0, 0]) cylinder(d = 9, h = 30, center=true); 
            
            // Frame Vents
            for(v = [0:45:359]) rotate([0,0,v])
                translate([toroid_od/2, -5, -clearance - 1]) cube([22, 10, wall + 2]);
        }
    }
}

// 2. THE ROTATING DRUM (No changes needed for plate fit)
module rotating_drum() {
    difference() {
        union() {
            cylinder(d = toroid_od + 28, h = hub_depth - wall); 
            cylinder(d = flange_d, h = wall); 
            translate([0,0, hub_depth - wall]) cylinder(d = toroid_od + 19, h = 4); 
        }
        translate([0, 0, wall]) cylinder(d = toroid_od + 18.5, h = hub_depth + 10); 
        translate([0, 0, -1]) cylinder(d = 22.15, h = wall + 2); 
        
        for(v = [22.5:45:359]) rotate([0,0,v])
            translate([toroid_od/2 - 5, -5, -1]) cube([15, 10, wall + 2]);

        translate([toroid_od/2 + 5, 0, (hub_depth-wall)/2]) rotate([0, 90, 0]) {
            cylinder(d = 4.2, h = 35);
            translate([0,0,-20]) cylinder(d=9, h=10); 
        }

        for(i = [0:120:359]) rotate([0,0,i]) {
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 12]) cylinder(d = 4.1, h = 15);
            translate([toroid_od/2 + 10, 0, hub_depth - wall - 8.5])
                rotate([0, 0, 30]) cylinder(d = 7.9, h = 4, $fn=6);
        }
    }
}

// 3. THE MASTER CAP
module master_cap() {
    translate([flange_d + 30, 0, 0]) {
        difference() {
            union() {
                cylinder(d = flange_d, h = wall); 
                translate([flange_d/2 - 20, 0, wall]) cylinder(d1=24, d2=18, h=38);
            }
            translate([0,0,-1]) 
                difference() {
                    cylinder(d = toroid_od + 19.5, h = 4.5);
                    translate([0,0,-1]) cylinder(d = toroid_od + 18.5, h = 6.5);
                }

            translate([0,0,-1]) cylinder(d = 13.5, h = wall + 2); 
            translate([22, 0, -1]) cylinder(d = 9.9, h = wall + 2); 
            translate([-22, 0, -1]) cylinder(d = 5.3, h = wall + 2); 
            
            for(i = [0:120:359]) rotate([0,0,i])
                translate([toroid_od/2 + 10, 0, -1]) cylinder(d = 4.5, h = wall + 2);
            for(zt = [60, 180, 300]) rotate([0, 0, zt]) {
                translate([toroid_od/2 - 10, -3, -1]) cube([6, 6, wall + 2]); 
                translate([toroid_od/2 + 4, -3, -1]) cube([6, 6, wall + 2]); 
            }
            for(v = [0, 120, 240]) rotate([0,0,v+30])
                translate([toroid_od/4, -4, -1]) cube([20, 8, wall + 2]);
        }
    }
}

// Layout for Slicer
left_frame_cage();
rotating_drum(); // Render 
master_cap();    // Render separately for STLs