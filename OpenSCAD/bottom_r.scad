/*  
    Bottom Right Half of the Case    
    Jan 9, 2023
*/

include <puzzle_joint.scad>
include <parameters.scad>
include <standoff_w_insert.scad>

module bottom_r(){
    difference(){   
        union(){    
            // Bottom
            cube([bottom_piece_length,bottom_piece_width,bottom_thickness]);

            // Lateral side (right side)
            translate([1/2*board_length,0,bottom_thickness])
            cube([lateral_wall_thickness,bottom_piece_width,board_height]); 

            // Near longitudinal side
            translate([0,0,bottom_thickness])
            cube([bottom_piece_length,longitudinal_wall_thickness,board_height]); 

            // Far longitudinal side
            translate([0,board_width+longitudinal_wall_thickness,bottom_thickness])
            cube([bottom_piece_length,longitudinal_wall_thickness,board_height]); 

            // Near positive puzzle joint
            translate([-puzzle_joint_length,0.5*(longitudinal_wall_thickness-puzzle_joint_width),0])
            puzzle_joint(puzzle_joint_tab_length,puzzle_joint_stem_length,puzzle_joint_width,board_height+bottom_thickness,puzzle_joint_corner_rad);  
               
            // Far positive puzzle joint
            translate([-puzzle_joint_length,bottom_piece_width-longitudinal_wall_thickness+0.5*(longitudinal_wall_thickness-puzzle_joint_width),0])
            puzzle_joint(puzzle_joint_tab_length,puzzle_joint_stem_length,puzzle_joint_width,board_height+bottom_thickness,puzzle_joint_corner_rad); 
                
            // Positive overlap joint
            translate([0,longitudinal_wall_thickness,bottom_thickness])
            cube([puzzle_joint_length,board_width,overlap_joint_thickness]);
            
            translate([-overlap_joint_length,0.5*(bottom_piece_width-overlap_joint_width),bottom_thickness])
            minkowski(){
                cube([overlap_joint_length,overlap_joint_width,0.5*overlap_joint_thickness]);
                cylinder(h=0.5*overlap_joint_thickness,r=overlap_joint_corner_rad);
            } 
           
           hull(){
               translate([-overlap_joint_length,0.5*(bottom_piece_width-overlap_joint_width),0])
               cylinder(h=overlap_joint_thickness,r=overlap_joint_corner_rad);
               translate([-overlap_joint_length,bottom_piece_width-0.5*(bottom_piece_width-overlap_joint_width),0])
               cylinder(h=overlap_joint_thickness,r=overlap_joint_corner_rad);
           }
       }
       
        // Remove extra material from the longitudinal walls
        linear_extrude(board_height+bottom_thickness){polygon(trapezoid_vertices);}
        
        translate([0,bottom_piece_width,0])
        mirror([0,1,0])
        linear_extrude(board_height+bottom_thickness){polygon(trapezoid_vertices);}
        
        // Chop corners    
        translate([bottom_piece_length,0,0])
        mirror([1,0,0])    
        linear_extrude(board_height+bottom_thickness){polygon(triangle_vertices);}       
    
        translate([bottom_piece_length,bottom_piece_width,0])
        rotate(a=180, v=[0,0,1])
        linear_extrude(board_height+bottom_thickness){polygon(triangle_vertices);}
       
        // Removing material from the right side corners
        translate([bottom_piece_length-trapezoid_offset-trapezoid_short_edge_offset,0,bottom_thickness])
        linear_extrude(board_height){polygon(corner_vertices);}
        
        translate([bottom_piece_length-trapezoid_offset-trapezoid_short_edge_offset,bottom_piece_width,bottom_thickness])
        mirror([0,1,0])
        linear_extrude(board_height){polygon(corner_vertices);}
        
        // Removing material near the puzzle joints
        translate([0,0,bottom_thickness])
        linear_extrude(board_height){polygon(middle_vertices_r);}
        
        translate([0,bottom_piece_width,bottom_thickness])
        mirror([0,1,0])
        linear_extrude(board_height){polygon(middle_vertices_r);}  
  
        // speed holes
        translate([bottom_piece_length/2,bottom_piece_width/2,0])
        for(i=[0:num_holes-1]){
            translate([hole_x[i],hole_y[i],0])
            cylinder(h=bottom_thickness,r=hole_rad);
        }  
        
    }
    
    // Standoffs
    for(i=[0:num_logic_l-1]){
        translate([sx_r[i],sy_r[i],bottom_thickness])
        standoff_w_insert(standoff_height_r,standoff_rad,insert_depth,insert_rad);
    }
    
    // Case screw standoffs
    
    // Standoffs near the puzzle joint
    translate([(trapezoid_offset+trapezoid_short_edge_offset)/2,longitudinal_wall_thickness/2,bottom_thickness])
    standoff_w_insert(board_height,case_standoff_rad,case_standoff_insert_depth,case_standoff_insert_rad);
    
    translate([(trapezoid_offset+trapezoid_short_edge_offset)/2,bottom_piece_width-longitudinal_wall_thickness/2,bottom_thickness])
    standoff_w_insert(board_height,case_standoff_rad,case_standoff_insert_depth,case_standoff_insert_rad);
    
    // Standoffs in the corners
    translate([trapezoid_offset+trapezoid_long_edge-trapezoid_short_edge_offset+(trapezoid_offset+trapezoid_short_edge_offset)/2,longitudinal_wall_thickness/2,bottom_thickness])
    standoff_w_insert(board_height,case_standoff_rad,case_standoff_insert_depth,case_standoff_insert_rad);
    
    translate([trapezoid_offset+trapezoid_long_edge-trapezoid_short_edge_offset+(trapezoid_offset+trapezoid_short_edge_offset)/2,bottom_piece_width-longitudinal_wall_thickness/2,bottom_thickness])
    standoff_w_insert(board_height,case_standoff_rad,case_standoff_insert_depth,case_standoff_insert_rad); 
    
}

fn=50;
bottom_r();



