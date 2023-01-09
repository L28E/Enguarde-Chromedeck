/*  
    Puzzle Piece Joint 
    For connecting large components which had to be split up to fit on the print bed
    Jan 5, 2023
*/

//x=length
//y=width
//z=height

module puzzle_joint(tab_length,stem_length,width,height,corner_rad){
    joint_x=tab_length-2*corner_rad;    // Must be >0!
    joint_y=width-2*corner_rad;
    // The "Tab"
    minkowski(){
        translate([corner_rad,corner_rad,0])cylinder(h=0.5*height,r=corner_rad);
        cube([joint_x,joint_y,0.5*height]);
    }
    
    stem_width=0.95*(width-2*corner_rad);
    // The stem
    translate([tab_length,0.5*(width-stem_width),0])cube([stem_length,stem_width,height]);
}

// For testing

//$fn=50;
//puzzle_joint(5,2,9,20,2);