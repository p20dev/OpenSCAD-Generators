/*
  SMART TEA-BAG DISPENSER GENERATOR — OpenSCAD Nightly
  -----------------------------------------------------------------------
  Designed around individually wrapped, flat tea envelopes.  The default
  envelope is 60 x 70 mm.  The default model is a front-pull gravity
  magazine: envelopes stand on their bottom edge, lean toward the front,
  and are held by a low retaining lip plus two rounded side fingers.

  Print orientation: place the back flat on the print bed.  No supports are
  needed in the standard configuration.  Use 3+ perimeters for a durable
  kitchen part.  Measure the actual sachets: their width/height may differ
  noticeably between brands.

  Key design choices:
  - clearance around paper packets prevents jamming from seams and wrinkles;
  - a low front lip retains the stack, while a central thumb opening gives a
    deliberate, one-at-a-time grasp point;
  - two tapered side fingers stop the next packet following the first one;
  - a rearward lean uses gravity to keep the front packet presented;
  - open top and open side windows make refilling and stock level obvious;
  - optional drain/crumb slot and either countertop feet or wall screw holes.
*/

// [Tea envelope]
packet_width = 60; // [30:0.5:120]
packet_height = 70; // [35:0.5:150]
packet_thickness = 1.6; // [0.5:0.1:5]
capacity = 24; // [4:1:80]
side_clearance = 1.5; // [0.4:0.1:5]
height_clearance = 3; // [0.5:0.5:15]
depth_clearance = 3; // [0.5:0.5:12]

// [Format and mounting]
dispenser_style = "Front Pull Magazine"; // [Front Pull Magazine,Angled Counter Tray,Open Organizer]
mounting = "Countertop"; // [Countertop,Wall Mount,Magnetic Back]
back_lean = 10; // [0:1:18]
show_front_label = false; // [true,false]
label_text = "TEA";

// [Dispensing geometry]
front_lip_height = 15; // [6:0.5:30]
thumb_opening_width = 34; // [18:0.5:55]
thumb_opening_depth = 13; // [5:0.5:32]
side_fingers = true; // [true,false]
finger_width = 7; // [3:0.5:16]
finger_height = 28; // [10:0.5:45]
finger_overlap = 2.2; // [0.5:0.1:6]
front_window = true; // [true,false]
window_height = 34; // [10:1:80]

// [Construction]
wall = 2.4; // [1.2:0.1:5]
corner_radius = 4; // [0:0.5:12]
bottom_thickness = 2.4; // [1.2:0.1:6]
foot_height = 3; // [0:0.5:10]
add_drain_slot = true; // [true,false]
drain_slot_width = 22; // [5:1:50]
wall_hole_diameter = 4.5; // [3:0.1:8]
wall_hole_spacing = 54; // [20:1:150]
magnet_diameter = 10; // [6:0.5:20]
magnet_depth = 2.2; // [1:0.1:5]
$fn = 48;

// Derived sizes. Y is depth (front to back); Z is height.
inner_w = packet_width + 2*side_clearance;
inner_d = capacity*packet_thickness + depth_clearance;
inner_h = packet_height + height_clearance;
outer_w = inner_w + 2*wall;
outer_d = inner_d + 2*wall;
outer_h = inner_h + bottom_thickness + wall;
front_y = -outer_d/2;
rear_y = outer_d/2;

assert(packet_width > 0 && packet_height > 0 && packet_thickness > 0, "Packet dimensions must be positive.");
assert(thumb_opening_width < inner_w - 2*finger_width, "Thumb opening is too wide for the chosen dispenser.");
assert(front_lip_height < inner_h - 5, "Front lip must be lower than the packets.");

module rounded_box(size=[10,10,10], r=2) {
  rr = min(r, min(size[0],size[1])/2);
  hull() for (x=[-size[0]/2+rr,size[0]/2-rr]) for (y=[-size[1]/2+rr,size[1]/2-rr])
    translate([x,y,0]) cylinder(h=size[2],r=rr);
}

// A large horizontal capsule cutout, gentler on fingers than a rectangular slot.
module capsule_2d(length, diameter) {
  hull() for (x=[-length/2+diameter/2,length/2-diameter/2]) translate([x,0]) circle(d=diameter);
}

module front_gate() {
  // Low continuous lip with a deep centre thumb notch.
  difference() {
    translate([0,front_y+wall/2,bottom_thickness]) rounded_box([outer_w,wall,front_lip_height],corner_radius);
    translate([0,front_y-1,bottom_thickness+front_lip_height]) rotate([90,0,0])
      linear_extrude(height=wall+2) capsule_2d(thumb_opening_width,thumb_opening_depth*2);
  }
  // Tapered fingers prevent a second sachet from simply following the first.
  if (side_fingers) for (sx=[-1,1])
    translate([sx*(inner_w/2-finger_width/2+wall-finger_overlap),front_y+wall/2,bottom_thickness])
      hull() {
        translate([0,0,0]) rounded_box([finger_width,wall,finger_height],min(2,corner_radius));
        translate([sx*1.5,0,finger_height-7]) rounded_box([finger_width-1,wall,7],min(2,corner_radius));
      }
}

module gravity_shelf() {
  // The packet bottoms rest on this gentle front-down ramp. It biases the
  // stack into the gate without requiring a spring, moving parts, or support.
  rise = min(tan(back_lean)*inner_d, front_lip_height*0.45);
  translate([0,0,bottom_thickness])
    polyhedron(
      points=[[-inner_w/2,front_y+wall,0],[inner_w/2,front_y+wall,0],
              [inner_w/2,rear_y-wall,0],[-inner_w/2,rear_y-wall,0],
              [-inner_w/2,front_y+wall,0],[inner_w/2,front_y+wall,0],
              [inner_w/2,rear_y-wall,rise],[-inner_w/2,rear_y-wall,rise]],
      faces=[[0,1,2,3],[4,7,6,5],[0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0]]);
}

module magazine_body() {
  difference() {
    union() {
      // Back panel and side rails; leave top fully open for comfortable refilling.
      translate([0,rear_y-wall/2,0]) rounded_box([outer_w,wall,outer_h],corner_radius);
      for (sx=[-1,1]) translate([sx*(outer_w-wall)/2,0,0]) rounded_box([wall,outer_d,outer_h],corner_radius);
      translate([0,0,0]) rounded_box([outer_w,outer_d,bottom_thickness],corner_radius);
      gravity_shelf();
      front_gate();
      if (mounting == "Countertop" && foot_height > 0)
        for (x=[-outer_w/2+10,outer_w/2-10]) for (y=[front_y+10,rear_y-10])
          translate([x,y,-foot_height]) cylinder(h=foot_height,r=4);
    }
    // Large side windows: see stock, grab a jammed packet, and save material.
    if (front_window) for (sx=[-1,1])
      translate([sx*(outer_w/2-wall/2),0,bottom_thickness+front_lip_height+8]) rotate([0,90,0])
        linear_extrude(height=wall+2,center=true)
          capsule_2d(min(inner_d-14, window_height), min(inner_h-front_lip_height-16, window_height));
    if (add_drain_slot)
      translate([0,front_y+wall/2,-1]) rotate([90,0,0]) linear_extrude(height=wall+2,center=true)
        capsule_2d(drain_slot_width,4);
    if (mounting == "Wall Mount") for (x=[-wall_hole_spacing/2,wall_hole_spacing/2])
      translate([x,rear_y+1,outer_h-16]) rotate([90,0,0]) cylinder(h=wall+3,d=wall_hole_diameter);
    if (mounting == "Magnetic Back") for (x=[-wall_hole_spacing/2,wall_hole_spacing/2])
      translate([x,rear_y-wall+magnet_depth,outer_h-16]) rotate([90,0,0]) cylinder(h=magnet_depth+0.1,d=magnet_diameter);
  }
}

module angled_counter_tray() {
  // A shallow first-in/first-out gravity runway. Fill from the elevated rear;
  // the retaining gate presents one packet at the low front.
  tray_len = max(110, capacity*packet_thickness*1.35 + 45);
  tray_w = inner_w + 2*wall;
  rise = tan(back_lean)*tray_len;
  rotate([back_lean,0,0]) {
    difference() {
      union() {
        rounded_box([tray_w,tray_len,bottom_thickness],corner_radius);
        for (sx=[-1,1]) translate([sx*(tray_w-wall)/2,0,bottom_thickness]) rounded_box([wall,tray_len,packet_height*0.38],corner_radius);
        translate([0,-tray_len/2+wall/2,bottom_thickness]) rounded_box([tray_w,wall,front_lip_height],corner_radius);
      }
      translate([0,-tray_len/2-1,bottom_thickness+front_lip_height]) rotate([90,0,0]) linear_extrude(height=wall+2)
        capsule_2d(thumb_opening_width,thumb_opening_depth*2);
    }
  }
}

module open_organizer() {
  // A simple open caddy with the same intelligent front gate for quick sorting.
  difference() {
    union() {
      rounded_box([outer_w,outer_d,bottom_thickness],corner_radius);
      for (sx=[-1,1]) translate([sx*(outer_w-wall)/2,0,bottom_thickness]) rounded_box([wall,outer_d,inner_h*0.65],corner_radius);
      translate([0,rear_y-wall/2,bottom_thickness]) rounded_box([outer_w,wall,inner_h*0.65],corner_radius);
      front_gate();
    }
    translate([0,front_y-1,bottom_thickness+front_lip_height]) rotate([90,0,0]) linear_extrude(height=wall+2)
      capsule_2d(thumb_opening_width,thumb_opening_depth*2);
  }
}

module label() {
  if (show_front_label)
    translate([0,front_y-wall/2-0.05,bottom_thickness+front_lip_height+11]) rotate([90,0,0])
      linear_extrude(height=0.6) text(label_text,size=10,halign="center",valign="center",font="Liberation Sans:style=Bold");
}

// Main output.  Front Pull is the recommended all-round design.
if (dispenser_style == "Front Pull Magazine") {
  magazine_body(); label();
} else if (dispenser_style == "Angled Counter Tray") angled_counter_tray();
else { open_organizer(); label(); }
