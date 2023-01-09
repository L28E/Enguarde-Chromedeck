/*  
    Standoff with Insert
    A standoff with a hole for a threaded insert
    Jan 7, 2023
*/


module standoff_w_insert(standoff_height,standoff_rad,insert_depth,insert_rad){
    difference(){
        cylinder(h=standoff_height,r=standoff_rad);
        translate([0,0,standoff_height-insert_depth])
        cylinder(h=insert_depth,r=insert_rad);        
    }
}


// For testing
//$fn=50;
//standoff_w_insert(5,2.5,2.5,1.5);