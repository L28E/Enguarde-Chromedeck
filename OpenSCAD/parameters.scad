// Wall thicknesses
lateral_wall_thickness=2;
longitudinal_wall_thickness=10;
bottom_thickness=2;

// Actual size of the board
// This leaves 2mm gap on each side of the chassis
dev_length=262;
dev_width=113;

// Board/Chassis dimensions
board_length=266;
board_width=117;
board_height=21;
bottom_piece_length=1/2*board_length+lateral_wall_thickness;
bottom_piece_width=board_width+2*longitudinal_wall_thickness;

insert_depth=3;
insert_rad=1.5;
standoff_rad=3.5;

case_standoff_insert_depth=3;
case_standoff_insert_rad=2;
case_standoff_rad=4;

// Puzzle Joint dimensions
puzzle_joint_tab_length=5;
puzzle_joint_stem_length=2;
puzzle_joint_length=puzzle_joint_tab_length+puzzle_joint_stem_length;
puzzle_joint_width=6;
puzzle_joint_corner_rad=1.5;

// Overlap Joint dimensions
overlap_joint_length=10; // Because im using a minkowski sum to define the overlap joint, it actually protrudes by this length + overlap_joint_corner_rad
overlap_joint_width=70;
overlap_joint_thickness=2;
overlap_joint_corner_rad=4;

// Left piece standoffs
num_logic_l=2;
sx_l=[lateral_wall_thickness+(board_length-dev_length)/2+11,lateral_wall_thickness+(board_length-dev_length)/2+20.5];
sy_l=[longitudinal_wall_thickness+(board_width-dev_width)/2+3,longitudinal_wall_thickness+(board_width-dev_width)/2+52];
standoff_height_l=overlap_joint_thickness+11;

// Right piece standoffs
num_logic_r=2;
sx_r=[bottom_piece_length-lateral_wall_thickness-(board_length-dev_length)/2-18,bottom_piece_length-lateral_wall_thickness-(board_length-dev_length)/2-18];
sy_r=[longitudinal_wall_thickness+(board_width-dev_width)/2+30.5,longitudinal_wall_thickness+(board_width-dev_width)/2+98];
standoff_height_r=overlap_joint_thickness+7;

// Define triangle to remove corners
triangle_vertices=[[0,0],[0,longitudinal_wall_thickness-lateral_wall_thickness],[longitudinal_wall_thickness,0]];

// Define trapezoid to remove from sides
trapezoid_long_edge=70;
trapezoid_offset=0.5*(bottom_piece_length-trapezoid_long_edge);
trapezoid_short_edge_offset=longitudinal_wall_thickness;
trapezoid_vertices=[[trapezoid_offset,0],
[trapezoid_offset+trapezoid_long_edge,0],
[trapezoid_offset+trapezoid_long_edge-trapezoid_short_edge_offset,longitudinal_wall_thickness-lateral_wall_thickness],
[trapezoid_offset+trapezoid_short_edge_offset,longitudinal_wall_thickness-lateral_wall_thickness]];

// Another trapezoid to remove material from the corners
// I could only think of this funny graphical approach to make sure all sides are the same thickness
m1=-(longitudinal_wall_thickness-lateral_wall_thickness)/longitudinal_wall_thickness;
b1=longitudinal_wall_thickness-lateral_wall_thickness+sqrt(2*lateral_wall_thickness^2);

c1y=longitudinal_wall_thickness-lateral_wall_thickness;
c1x=(c1y-b1)/m1;

c2y=lateral_wall_thickness;
c2x=(c2y-b1)/m1;

m2=(longitudinal_wall_thickness-lateral_wall_thickness)/longitudinal_wall_thickness;
d=trapezoid_offset-sqrt(2*lateral_wall_thickness^2);

c3y=lateral_wall_thickness;
c3x=(c3y+m2*d)/m2;

c4y=longitudinal_wall_thickness-lateral_wall_thickness;
c4x=(c4y+m2*d)/m2;

corner_vertices=[[c1x,c1y],[c2x,c2y],[c3x,c3y],[c4x,c4y]];

// Define a polygon to remove material near the puzzle joint on the left piece 
middle_vertices_l=[[trapezoid_offset+trapezoid_long_edge-trapezoid_short_edge_offset+c1x,c1y],
[trapezoid_offset+trapezoid_long_edge-trapezoid_short_edge_offset+c2x,c2y],
[bottom_piece_length-1.5*puzzle_joint_length,c3y],
[bottom_piece_length-1.5*puzzle_joint_length,c4y]];

// Define a polygon to remove material near the puzzle joint on the right piece
middle_vertices_r=[[c3x,c3y],
[c4x,c4y],
[puzzle_joint_length,c4y],
[puzzle_joint_length,c3y]];


// Grid of holes to punch out
num_holes=21;
hole_rad=5;

hole_x=[0,-20,20,
-30,-10,10,30,
0,-20,20,
-30,-10,10,30,
0,-20,20,
-10,10,
-10,10];

hole_y=[0,0,0,
10,10,10,10,
20,20,20,
-10,-10,-10,-10,
-20,-20,-20,
30,30,
-30,-30];

// Barrel plug
barrel_plug_offset=97;
barrel_plug_height=4;
barrel_plug_width=6;
mount_width=12;
mount_length=11.5;
key_length=2;
key_offset=6.5;

// I/O
io_rad=2;
io_vertical_offset=bottom_thickness+overlap_joint_thickness+io_rad+9;
io_height=15; // Just needs to be big enough to hull out the rest of the height idc
io_width=100;



