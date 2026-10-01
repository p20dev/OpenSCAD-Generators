// Cable Clips v1 prototype: adhesive-backed, open-top cable clip.
// Kept separate from the storage family's dimensions.

/* [Cable and clip, mm] */
cable_diameter = 6; // [3:0.5:12]
clip_length = 35;   // [15:1:70]
base_thickness = 2.4; // [1.6:0.2:5]
wall_thickness = 2.0; // [1.6:0.2:5]
grip_lip = 1.2; // [0.6:0.2:2]
cable_clearance = 0.4; // [0.2:0.1:1]

channel = cable_diameter + 2 * cable_clearance;
width = channel + 2 * wall_thickness;
wall_height = cable_diameter + cable_clearance + 2;

assert(cable_diameter >= 3 && cable_diameter <= 12, "Cable diameter must be 3..12 mm");
assert(clip_length >= 15 && clip_length <= 70, "Clip length must be 15..70 mm");
assert(base_thickness >= 1.6 && wall_thickness >= 1.6, "Clip walls/base are too thin");
assert(grip_lip >= 0.6 && 2 * grip_lip < channel - 1, "Lip leaves too little cable entry");

union() {
    cube([clip_length, width, base_thickness]);
    translate([0, 0, base_thickness])
        cube([clip_length, wall_thickness, wall_height]);
    translate([0, width - wall_thickness, base_thickness])
        cube([clip_length, wall_thickness, wall_height]);
    translate([0, wall_thickness, base_thickness + wall_height - grip_lip])
        cube([clip_length, grip_lip, grip_lip]);
    translate([0, width - wall_thickness - grip_lip,
               base_thickness + wall_height - grip_lip])
        cube([clip_length, grip_lip, grip_lip]);
}
