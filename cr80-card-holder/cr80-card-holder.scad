/*
  CR80 / ID-1 CARD HOLDER GENERATOR — V2
  --------------------------------------
  One-piece FDM-printable holders for CR80 / ISO ID-1 cards.
  Designed for OpenSCAD Nightly, but deliberately avoids fragile/obscure
  experimental syntax so files remain easy to maintain and batch-render.

  Nominal card size: 85.60 x 53.98 x 0.76 mm.
  Recommended print orientation: back plate flat on the bed.

  V2 highlights:
  - multiple retention systems, including XY-flex snap tabs
  - slide-in and semi-permanent security variants
  - durable / abuse-proof construction profiles
  - rounded bumper frame
  - reinforced lanyard / chain attachments
  - optional dual attachments
  - tuneable clearances for PLA / PETG
  - support-free geometry as far as practical
*/

/* [Card] */
orientation = "Portrait"; // [Portrait,Landscape]
card_width = 85.60; // [80:0.01:90]
card_height = 53.98; // [50:0.01:60]
card_thickness = 0.76; // [0.50:0.01:1.50]
card_corner_radius = 3.18; // [2.0:0.01:4.0]
xy_clearance = 0.30; // [0.10:0.05:0.80]
z_clearance = 0.20; // [0.05:0.05:0.60]

/* [Material / Construction Profile] */
material_profile = "PETG"; // [PLA,PETG,Custom]
construction = "Durable"; // [Light,Standard,Durable,Abuse Proof]
wall_width = 2.40; // [1.20:0.10:6.00]
back_thickness = 1.60; // [0.80:0.10:4.00]
outer_corner_radius = 5.00; // [2.0:0.25:12.0]
front_edge_height = 0.70; // [0.30:0.10:2.00]
bumper_enabled = true; // [true,false]
bumper_extra_width = 1.20; // [0.40:0.10:3.50]
bumper_height = 1.20; // [0.40:0.10:3.00]

/* [Retention] */
retention = "Flex Tabs"; // [Corner Clips,Edge Clips,Side Detents,Flex Tabs,Slide Rails,Security Rails,Full Bezel,Friction Only]
clip_overhang = 1.35; // [0.50:0.05:2.80]
clip_length = 10.0; // [5:0.5:22]
clip_thickness = 0.90; // [0.50:0.05:1.80]
clip_entry_chamfer = 0.55; // [0.20:0.05:1.20]
detent_depth = 0.45; // [0.15:0.05:1.00]
detent_diameter = 3.0; // [1.5:0.25:5.0]
slide_rail_overhang = 1.40; // [0.50:0.05:3.00]

/* [Flex Tabs] */
flex_tab_length = 15.0; // [8:0.5:28]
flex_tab_width = 2.20; // [1.20:0.10:4.00]
flex_relief_gap = 0.75; // [0.40:0.05:1.50]
flex_hook_depth = 0.70; // [0.25:0.05:1.40]
flex_hook_length = 3.20; // [1.5:0.10:6.0]
flex_tabs_per_side = 1; // [1,2]

/* [Security] */
security_capture = 1.80; // [0.80:0.10:3.50]
security_entry_gap = 0.45; // [0.20:0.05:1.20]
security_release_notch = true; // [true,false]
security_release_width = 7.0; // [4:0.5:14]

/* [Access / Removal] */
thumb_notch = true; // [true,false]
thumb_notch_side = "Top"; // [Top,Bottom,Left,Right]
thumb_notch_diameter = 16.0; // [8:1:28]
back_push_hole = false; // [true,false]
back_push_hole_diameter = 18.0; // [10:1:30]

/* [Attachment] */
attachment = "Slot"; // [None,Round,Slot,Dual Round,Dual Slot,Round + Slot]
attachment_side = "Top"; // [Top,Bottom,Left,Right]
second_attachment = false; // [true,false]
attachment_width = 24.0; // [14:1:44]
attachment_extension = 12.0; // [8:1:28]
round_hole_diameter = 5.0; // [3:0.25:10]
slot_length = 14.0; // [8:0.5:26]
slot_width = 4.5; // [3:0.25:9]
dual_hole_spacing = 10.0; // [6:0.5:22]
attachment_reinforcement = 3.0; // [1.5:0.25:7]
attachment_gussets = true; // [true,false]

/* [Preview / Quality] */
show_card_preview = true; // [true,false]
preview_explode = 0.0; // [0:0.5:12]
quality = "Normal"; // [Draft,Normal,Fine]

// ---------- Quality ----------
$fn = quality == "Draft" ? 28 : quality == "Fine" ? 96 : 56;

// ---------- Material-derived tuning ----------
// These do not override your explicit dimensions; they set safe lower bounds.
MAT_FLEX_MIN = material_profile == "PLA" ? 2.40 : material_profile == "PETG" ? 1.80 : 1.20;
MAT_GAP_MIN  = material_profile == "PLA" ? 0.70 : material_profile == "PETG" ? 0.55 : 0.40;

// ---------- Construction profile ----------
PROFILE_WALL = construction == "Light" ? 1.60 :
               construction == "Standard" ? 2.20 :
               construction == "Durable" ? 3.00 : 3.80;
PROFILE_BACK = construction == "Light" ? 1.00 :
               construction == "Standard" ? 1.40 :
               construction == "Durable" ? 2.00 : 2.60;
PROFILE_RADIUS = construction == "Light" ? 3.50 :
                 construction == "Standard" ? 4.50 :
                 construction == "Durable" ? 5.50 : 6.50;
PROFILE_ATTACH = construction == "Abuse Proof" ? 14.0 : construction == "Durable" ? 12.0 : 9.0;

WALL = max(wall_width, PROFILE_WALL);
BACK = max(back_thickness, PROFILE_BACK);
R_OUT = max(outer_corner_radius, PROFILE_RADIUS);
FLEX_W = max(flex_tab_width, MAT_FLEX_MIN);
FLEX_GAP = max(flex_relief_gap, MAT_GAP_MIN);
ATT_EXT = max(attachment_extension, PROFILE_ATTACH);
ATT_REINF = construction == "Abuse Proof" ? max(attachment_reinforcement, 4.2) :
             construction == "Durable" ? max(attachment_reinforcement, 3.4) : attachment_reinforcement;

// ---------- Derived card / holder geometry ----------
raw_w = orientation == "Landscape" ? card_width : card_height;
raw_h = orientation == "Landscape" ? card_height : card_width;
pocket_w = raw_w + 2 * xy_clearance;
pocket_h = raw_h + 2 * xy_clearance;
outer_w = pocket_w + 2 * WALL;
outer_h = pocket_h + 2 * WALL;

card_top_z = BACK + card_thickness + z_clearance;
wall_top_z = card_top_z + front_edge_height;
attach_t = max(wall_top_z, construction == "Abuse Proof" ? 3.6 : 2.8);
bumper_w = construction == "Abuse Proof" ? max(bumper_extra_width, 1.8) : bumper_extra_width;
bumper_h = construction == "Abuse Proof" ? max(bumper_height, 1.6) : bumper_height;

assert(xy_clearance >= 0.10, "xy_clearance is probably too small for FDM.");
assert(WALL > max(clip_overhang, flex_hook_depth), "Wall is too narrow for selected retention geometry.");
assert(slot_length > slot_width, "slot_length must be greater than slot_width.");
assert(FLEX_W < WALL + 1.5, "Flex tab is unusually thick. Reduce flex_tab_width or increase wall_width.");

// ---------- 2D primitives ----------
module rounded_rect_2d(w, h, r) {
    rr = min(r, min(w,h)/2 - 0.01);
    offset(r=rr)
        square([max(0.01,w - 2*rr), max(0.01,h - 2*rr)], center=true);
}

module slot_2d(len, wid) {
    hull() {
        translate([-(len-wid)/2, 0]) circle(d=wid);
        translate([ +(len-wid)/2, 0]) circle(d=wid);
    }
}

// ---------- Attachment positioning ----------
module at_attachment_side(side=attachment_side) {
    if (side == "Top")
        translate([0, outer_h/2 + ATT_EXT/2 - 1.0, 0]) children();
    else if (side == "Bottom")
        translate([0, -outer_h/2 - ATT_EXT/2 + 1.0, 0]) rotate([0,0,180]) children();
    else if (side == "Left")
        translate([-outer_w/2 - ATT_EXT/2 + 1.0, 0, 0]) rotate([0,0,90]) children();
    else
        translate([outer_w/2 + ATT_EXT/2 - 1.0, 0, 0]) rotate([0,0,-90]) children();
}

function opposite_side(s) = s == "Top" ? "Bottom" : s == "Bottom" ? "Top" : s == "Left" ? "Right" : "Left";

module attachment_plate_2d() {
    rounded_rect_2d(attachment_width, ATT_EXT + 4.0,
                    min(R_OUT, min(attachment_width, ATT_EXT+4)/2 - 0.1));
}

module attachment_holes_2d() {
    if (attachment == "Round") {
        circle(d=round_hole_diameter);
    } else if (attachment == "Slot") {
        slot_2d(slot_length, slot_width);
    } else if (attachment == "Dual Round") {
        translate([-dual_hole_spacing/2,0]) circle(d=round_hole_diameter);
        translate([ dual_hole_spacing/2,0]) circle(d=round_hole_diameter);
    } else if (attachment == "Dual Slot") {
        translate([-dual_hole_spacing/2,0]) rotate(90) slot_2d(slot_length*0.65, slot_width);
        translate([ dual_hole_spacing/2,0]) rotate(90) slot_2d(slot_length*0.65, slot_width);
    } else if (attachment == "Round + Slot") {
        translate([0,-3.5]) slot_2d(slot_length, slot_width);
        translate([0, 4.5]) circle(d=round_hole_diameter);
    }
}

module one_attachment(side=attachment_side) {
    if (attachment != "None") {
        at_attachment_side(side)
        difference() {
            union() {
                linear_extrude(attach_t) attachment_plate_2d();

                // Local reinforcement rings distribute load around the opening.
                if (construction == "Durable" || construction == "Abuse Proof") {
                    if (attachment == "Round")
                        cylinder(h=attach_t, d=round_hole_diameter + 2*ATT_REINF);
                    else if (attachment == "Slot")
                        linear_extrude(attach_t) offset(r=ATT_REINF) slot_2d(slot_length, slot_width);
                    else if (attachment == "Dual Round") {
                        translate([-dual_hole_spacing/2,0,0]) cylinder(h=attach_t, d=round_hole_diameter + 2*ATT_REINF);
                        translate([ dual_hole_spacing/2,0,0]) cylinder(h=attach_t, d=round_hole_diameter + 2*ATT_REINF);
                    }
                }
            }
            translate([0,0,-0.1]) linear_extrude(attach_t + 0.2) attachment_holes_2d();
        }

        // Broad triangular-ish roots reduce stress concentration where tab meets body.
        if (attachment_gussets)
            at_attachment_side(side)
                for (sx=[-1,1])
                    hull() {
                        translate([sx*(attachment_width/2-2.0), -ATT_EXT/2+2.0, 0])
                            cylinder(h=min(attach_t, BACK+1.0), d=3.2);
                        translate([sx*(outer_w < outer_h ? outer_w : outer_h)*0.10, -ATT_EXT/2-3.5, 0])
                            cylinder(h=min(attach_t, BACK+1.0), d=3.2);
                    }
    }
}

module attachments() {
    one_attachment(attachment_side);
    if (second_attachment && attachment != "None")
        one_attachment(opposite_side(attachment_side));
}

// ---------- Base shell ----------
module back_plate() {
    linear_extrude(BACK)
        rounded_rect_2d(outer_w, outer_h, R_OUT);
}

module perimeter_walls(open_top=false) {
    difference() {
        translate([0,0,BACK-0.08])
            linear_extrude(wall_top_z - BACK + 0.08)
                rounded_rect_2d(outer_w, outer_h, R_OUT);

        translate([0,0,BACK-0.05])
            linear_extrude(wall_top_z - BACK + 0.10)
                rounded_rect_2d(pocket_w, pocket_h, card_corner_radius + xy_clearance);

        if (open_top)
            translate([0, outer_h/2 - WALL/2, BACK-0.1])
                cube([pocket_w + 0.6, WALL + 0.8, wall_top_z-BACK+0.3], center=true);
    }
}

module bumper_frame() {
    if (bumper_enabled) {
        bh = min(BACK + bumper_h, wall_top_z);

        if (retention == "Flex Tabs") {
            // Flex tabs need free space to deflect outward in XY. A continuous
            // side bumper would mechanically block them, so this mode uses
            // heavy top/bottom impact rails instead of a closed bumper ring.
            for (sy=[-1,1])
                translate([0, sy*(outer_h/2 + bumper_w/2 - 0.20), 0])
                    linear_extrude(bh)
                        rounded_rect_2d(outer_w + 2*bumper_w, bumper_w + 0.80,
                                        min((bumper_w+0.80)/2-0.01, R_OUT));
        } else {
            // Closed low bumper for rigid retention systems.
            difference() {
                linear_extrude(bh)
                    rounded_rect_2d(outer_w + 2*bumper_w, outer_h + 2*bumper_w, R_OUT + bumper_w);
                translate([0,0,-0.1])
                    linear_extrude(bh+0.2)
                        rounded_rect_2d(outer_w - 0.20, outer_h - 0.20, max(0.5,R_OUT-0.10));
            }
        }
    }
}

// ---------- Traditional roof-style retainers ----------
module edge_roof_x(y, len=clip_length) {
    translate([0, y, card_top_z + clip_thickness/2])
        cube([len, WALL + clip_overhang, clip_thickness], center=true);
}

module edge_roof_y(x, len=clip_length) {
    translate([x, 0, card_top_z + clip_thickness/2])
        cube([WALL + clip_overhang, len, clip_thickness], center=true);
}

module corner_clips() {
    x = pocket_w/2 + (WALL-clip_overhang)/2;
    y = pocket_h/2 + (WALL-clip_overhang)/2;
    for (sx=[-1,1], sy=[-1,1])
        translate([sx*x, sy*y, card_top_z + clip_thickness/2])
            cube([WALL + clip_overhang, WALL + clip_overhang, clip_thickness], center=true);
}

module edge_clips() {
    edge_roof_x( pocket_h/2 + (WALL-clip_overhang)/2);
    edge_roof_x(-pocket_h/2 - (WALL-clip_overhang)/2);
    edge_roof_y( pocket_w/2 + (WALL-clip_overhang)/2);
    edge_roof_y(-pocket_w/2 - (WALL-clip_overhang)/2);
}

// ---------- Side detents ----------
module side_detents() {
    d = detent_depth;
    for (sy=[-0.24,0.24]) {
        translate([ pocket_w/2 + detent_diameter/2 - d, pocket_h*sy, BACK + card_thickness*0.58])
            rotate([90,0,0]) cylinder(h=detent_diameter, d=detent_diameter, center=true);
        translate([-pocket_w/2 - detent_diameter/2 + d, pocket_h*sy, BACK + card_thickness*0.58])
            rotate([90,0,0]) cylinder(h=detent_diameter, d=detent_diameter, center=true);
    }
}

// ---------- XY flex tabs ----------
// A long leaf is isolated from each side wall by relief cuts. The rounded hook
// protrudes into the pocket. During insertion the leaf bends OUTWARD in XY,
// so flexing does not rely primarily on Z-layer adhesion.
module flex_tab_positive(side=1, y0=0) {
    xwall = side*(pocket_w/2 + FLEX_W/2);
    translate([xwall, y0, BACK])
        cube([FLEX_W, flex_tab_length, wall_top_z-BACK], center=false);
}

module flex_hook(side=1, y0=0) {
    x = side*(pocket_w/2 + flex_hook_depth/2 - 0.08);
    y = y0 + flex_tab_length/2 - flex_hook_length/2;
    translate([x,y,BACK + card_thickness*0.58])
        rotate([90,0,0]) cylinder(h=flex_hook_length, d=2*flex_hook_depth, center=true);
}

module flex_tab_relief_cuts() {
    tab_positions = flex_tabs_per_side == 2 ? [-pocket_h*0.24-flex_tab_length/2, pocket_h*0.24-flex_tab_length/2] : [-flex_tab_length/2];
    for (side=[-1,1], y0=tab_positions) {
        // Along the inner/outer side of the cantilever: leave its root connected.
        x = side*(pocket_w/2 + WALL/2);
        translate([x, y0-flex_relief_gap/2, BACK-0.1])
            cube([WALL+1.0, FLEX_GAP, wall_top_z-BACK+0.3], center=true);
        translate([x, y0+flex_tab_length+flex_relief_gap/2, BACK-0.1])
            cube([WALL+1.0, FLEX_GAP, wall_top_z-BACK+0.3], center=true);
        // Outer clearance pocket lets the leaf deflect outward.
        translate([side*(pocket_w/2 + WALL - FLEX_GAP/2), y0+flex_tab_length*0.58, BACK-0.1])
            cube([FLEX_GAP, flex_tab_length*0.78, wall_top_z-BACK+0.3], center=true);
    }
}

module flex_tabs() {
    tab_positions = flex_tabs_per_side == 2 ? [-pocket_h*0.24-flex_tab_length/2, pocket_h*0.24-flex_tab_length/2] : [-flex_tab_length/2];
    for (side=[-1,1], y0=tab_positions)
        flex_hook(side,y0);
}

// ---------- Slide rails ----------
module slide_rails(security=false) {
    over = security ? max(slide_rail_overhang, security_capture) : slide_rail_overhang;
    rail_h = max(clip_thickness, 0.8);
    x = pocket_w/2 + (WALL-over)/2;

    for (sx=[-1,1])
        translate([sx*x, -WALL*0.15, card_top_z + rail_h/2])
            cube([WALL + over, pocket_h - 3.5, rail_h], center=true);

    // Bottom capture / stop.
    translate([0, -pocket_h/2 - (WALL-over)/2, card_top_z + rail_h/2])
        cube([pocket_w*0.60, WALL + over, rail_h], center=true);

    // Entrance retention.
    if (!security) {
        for (sx=[-1,1])
            translate([sx*(pocket_w/2 - 5), pocket_h/2 - 2.0, BACK + card_thickness*0.58])
                sphere(d=max(1.6, detent_diameter*0.62));
    } else {
        // Stronger shoulders at entry: semi-permanent but serviceable.
        for (sx=[-1,1])
            translate([sx*(pocket_w/2 - 5.5), pocket_h/2 - 2.4, BACK + card_thickness*0.60])
                sphere(d=max(2.0, security_capture*1.55));
    }
}

// ---------- Full bezel ----------
module full_bezel() {
    // Continuous front frame. Card is intended to slide in from the top opening.
    bezel_t = max(clip_thickness, 0.9);
    difference() {
        translate([0,0,card_top_z])
            linear_extrude(bezel_t)
                rounded_rect_2d(outer_w, outer_h, R_OUT);
        translate([0,0,card_top_z-0.05])
            linear_extrude(bezel_t+0.10)
                rounded_rect_2d(max(1,pocket_w-2*security_capture), max(1,pocket_h-2*security_capture), max(0.5,card_corner_radius-0.4));
        // top loading opening
        translate([0, outer_h/2-WALL/2, card_top_z-0.1])
            cube([pocket_w*0.78, WALL+1.0, bezel_t+0.3], center=true);
    }
}

module retention_features() {
    if (retention == "Corner Clips") corner_clips();
    else if (retention == "Edge Clips") edge_clips();
    else if (retention == "Side Detents") side_detents();
    else if (retention == "Flex Tabs") flex_tabs();
    else if (retention == "Slide Rails") slide_rails(false);
    else if (retention == "Security Rails") slide_rails(true);
    else if (retention == "Full Bezel") full_bezel();
}

// ---------- Access cuts ----------
module thumb_notch_cut() {
    if (thumb_notch) {
        h = wall_top_z-BACK + clip_thickness + 0.6;
        if (thumb_notch_side == "Top")
            translate([0, pocket_h/2 + WALL*0.30, BACK-0.05]) cylinder(h=h, d=thumb_notch_diameter);
        else if (thumb_notch_side == "Bottom")
            translate([0, -pocket_h/2 - WALL*0.30, BACK-0.05]) cylinder(h=h, d=thumb_notch_diameter);
        else if (thumb_notch_side == "Left")
            translate([-pocket_w/2 - WALL*0.30, 0, BACK-0.05]) cylinder(h=h, d=thumb_notch_diameter);
        else
            translate([pocket_w/2 + WALL*0.30, 0, BACK-0.05]) cylinder(h=h, d=thumb_notch_diameter);
    }
}

module back_push_cut() {
    if (back_push_hole)
        translate([0,0,-0.1]) cylinder(h=BACK+0.2, d=back_push_hole_diameter);
}

module security_release_cut() {
    if (retention == "Security Rails" && security_release_notch) {
        // Narrow service notch at entry. Enough for a fingernail/small plastic tool,
        // but much less likely to release accidentally than an open rail system.
        translate([0, pocket_h/2 + WALL*0.15, BACK + card_thickness*0.35])
            cube([security_release_width, WALL+1.2, wall_top_z-BACK+clip_thickness+0.6], center=true);
    }
}

// ---------- Final holder ----------
module holder() {
    open_top = retention == "Slide Rails" || retention == "Security Rails" || retention == "Full Bezel";

    difference() {
        union() {
            back_plate();
            perimeter_walls(open_top);
            bumper_frame();
            retention_features();
            attachments();
        }

        // Relief slots are subtractive and belong to Flex Tabs only.
        if (retention == "Flex Tabs") flex_tab_relief_cuts();

        thumb_notch_cut();
        back_push_cut();
        security_release_cut();
    }
}

module card_preview() {
    if (show_card_preview)
        %translate([0,0,BACK + preview_explode])
            linear_extrude(card_thickness)
                rounded_rect_2d(raw_w, raw_h, card_corner_radius);
}

holder();
card_preview();
