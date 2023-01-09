// Chromedeck midframe
// Affixes the battery behind the logic board of a Lenovo N21 chromebook, the intent being to fit the device in a keyboard formfactor.
// July 14th, 2022


// Increase Resolution
$fn=50;

/* Define standoff positions relative to the origin. 
I'll put S0-the left CPU standoff, at the origin */

// Logic Board standoffs
num_logic_stands=8;
SX=[0,45,2.5,99.5,99.5,129,108,124];
SY=[0,0,-33.5,46.5,-32.5,30.5,-12,2];

// Battery standoffs
num_battery_stands=2;
BX=[22.5,141];
BY=[-25.5,15.5];

// Other parameters
logic_standoff_height=2.5;
logic_standoff_rad=2.5;
battery_standoff_height=3.5;
battery_standoff_rad=2.5;

threaded_insert_depth=2.5;
battery_insert_depth=3.5;
threaded_insert_rad=1.5;
midframe_thickness=2;

module logic_standoff(){
    cylinder(h=logic_standoff_height,r=logic_standoff_rad);
}

module battery_standoff(){
    cylinder(h=battery_standoff_height,r=logic_standoff_rad);
}

module threaded_insert_hole(depth){
    cylinder(h=depth,r=threaded_insert_rad);
}

// Define the flat surface
difference(){
    // The outline
    union(){
        minkowski(){
            cylinder(h=midframe_thickness/2,r=logic_standoff_rad);
            mirror([0,1,0]) cube([141,33.5,midframe_thickness/2]);
        }
        translate([99.5,0,0]) minkowski(){
            cylinder(h=midframe_thickness/2,r=logic_standoff_rad);
            cube([41.5,46.5,midframe_thickness/2]);
        }
        translate([99.5-2*logic_standoff_rad,logic_standoff_rad,0]) cube([logic_standoff_rad,logic_standoff_rad,midframe_thickness]);
    }

    // Punch-out version number, round the inside corner
    union(){
        translate([99.5-2*logic_standoff_rad,2*logic_standoff_rad,0])cylinder(h=midframe_thickness,r=logic_standoff_rad);
        translate([120,-30,midframe_thickness/2])linear_extrude(midframe_thickness/2) text("V1",font="Noto Sans Mono",size=12);
        translate([45,-30,midframe_thickness/2])linear_extrude(midframe_thickness/2) text("N21",font="Noto Sans Mono",size=12);            
    }
}

// Right side screw mounts (for future work)
difference(){
    translate([143.5,40.5,0]) cylinder(h=midframe_thickness,r=6);
    translate([146.5,40.5,0]) threaded_insert_hole(midframe_thickness);
}

difference(){
    translate([143.5,-27.5,0]) cylinder(h=midframe_thickness,r=6);
    translate([146.5,-27.5,0]) threaded_insert_hole(midframe_thickness);
}

// Define the logic board standoffs
difference(){
// The posts
for(i=[0:num_logic_stands-1])
    translate([SX[i],SY[i],midframe_thickness]) logic_standoff();
    
// The holes
for(i=[0:num_logic_stands-1])
    translate([SX[i],SY[i],midframe_thickness]) threaded_insert_hole(threaded_insert_depth);    
}

// Define the battery standoffs
mirror([0,0,1])
difference(){
// The posts
for(i=[0:num_battery_stands-1])
    translate([BX[i],BY[i],0]) battery_standoff();
    
// The holes
for(i=[0:num_battery_stands-1])
    translate([BX[i],BY[i],0]) threaded_insert_hole(battery_insert_depth);    
}


