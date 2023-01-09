include <parameters.scad>

module barrel_plug_mount(){    
    difference(){
        cube([mount_length,mount_width,standoff_height_l+barrel_plug_height]);
        
        // The barrel plug
        translate([0,(mount_width-barrel_plug_width)/2,standoff_height_l])
        cube([mount_length,barrel_plug_width,barrel_plug_height]);
        
        // The key thing
        translate([key_offset,0,standoff_height_l])
        cube([key_length,mount_width,barrel_plug_height]); 
        
        // Hollow out the middle
        translate([lateral_wall_thickness,lateral_wall_thickness,0])
        cube([mount_length-2*lateral_wall_thickness,mount_width-2*lateral_wall_thickness,standoff_height_l-lateral_wall_thickness]);
        
    }    
    
}
    
// For testing
//$fn=50;
//barrel_plug_mount();