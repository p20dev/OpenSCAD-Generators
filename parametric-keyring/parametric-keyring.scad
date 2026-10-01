/*
===============================================================================
 PARAMETRIC KEYRING GENERATOR v5
 OpenSCAD Nightly / Development Snapshot
===============================================================================

Design goals
------------
* Text must NEVER extend outside the usable keyring face.
  - First: textmetrics() fits actual glyph bounds to a conservative safe box.
  - Second: the final text geometry is clipped by an inset copy of the real
    body shape and by a safety zone around an internal ring hole.
* Ring holes and lugs automatically enforce minimum material thickness.
* Colored preview for base, text/inlay and accents.
* Useful output modes for combined STL and separate multi-color parts.
* No external libraries.

Nightly requirement
-------------------
This file uses textmetrics(), including object members:
.position, .size, .ascent, .descent and .advance.

All dimensions are millimetres.
===============================================================================
*/


/* [Output] */

output_mode = "3D"; // [3D,2D]

output_part = "All"; // [All,Base Only,Text Only,Accent Only]

// Show useful dimensions/warnings in the console
debug_info = true;


/* [Body] */

shape = "Rounded Rectangle"; // [Rounded Rectangle,Capsule,Circle,Oval,Hexagon,Dog Tag,Shield,Heart]

body_width = 58;       // [20:1:120]
body_height = 30;      // [15:1:80]
body_thickness = 3.2;  // [1:0.1:10]
corner_radius = 6;     // [0:0.5:25]

// Curve quality
quality = 96;          // [24:8:240]


/* [Ring attachment] */

attachment = "Reinforced Lug"; // [Side Lug,Reinforced Lug,Inside Hole,None]

// Requested hole diameter. It may be clamped smaller for an Inside Hole if
// the chosen body is too small to preserve minimum_wall.
ring_hole_diameter = 5.2; // [2:0.1:14]

// Requested lug outer diameter. Side lugs automatically grow when necessary.
lug_outer_diameter = 12; // [6:0.5:28]

// How much the lug overlaps into the body. 0 = automatic.
lug_overlap = 0; // [0:0.5:12]

// Width of the reinforcing bridge/neck.
lug_bridge = 5; // [2:0.5:18]

// Position mode for side lugs.
// Preset positions keep the lug attached to the chosen side.
// Custom XY lets you place the lug centre manually.
lug_position_mode = "Right"; // [Right,Left,Top,Bottom,Custom XY]

// Manual lug centre offsets from the body centre.
// Used only when lug_position_mode = "Custom XY".
lug_x = 34; // [-80:0.5:80]
lug_y = 0; // [-80:0.5:80]

// Fine offset added after a preset lug position.
lug_offset_x = 0; // [-20:0.5:20]
lug_offset_y = 0; // [-20:0.5:20]

// Number of side lugs. Applies only to Side Lug / Reinforced Lug.
lug_count = 1; // [1,2]

// Second lug settings. These are independent of Lug 1.
lug2_position_mode = "Left"; // [Right,Left,Top,Bottom,Custom XY]
lug2_hole_diameter = 5.2; // [2:0.1:14]
lug2_outer_diameter = 12; // [6:0.5:28]
lug2_overlap = 0; // [0:0.5:12]
lug2_bridge = 5; // [2:0.5:18]
lug2_x = -34; // [-80:0.5:80]
lug2_y = 0; // [-80:0.5:80]
lug2_offset_x = 0; // [-20:0.5:20]
lug2_offset_y = 0; // [-20:0.5:20]

// Position mode for an internal hole.
inside_hole_position_mode = "Left"; // [Left,Right,Top,Bottom,Center,Custom XY]

// Manual internal-hole centre.
// Used only when inside_hole_position_mode = "Custom XY".
inside_hole_custom_x = -20; // [-60:0.5:60]
inside_hole_custom_y = 0; // [-40:0.5:40]

// Fine offset added after preset internal-hole positioning.
inside_hole_offset_x = 0; // [-20:0.5:20]
inside_hole_offset_y = 0; // [-20:0.5:20]

// Minimum material around every ring hole.
minimum_wall = 2.2; // [1:0.1:6]


/* [Main text] */

text_line_1 = "MAKER";
text_line_2 = "SPACE";

text_mode = "Raised"; // [None,Raised,Engraved,Cut Through,Inlay]

font = "Liberation Sans:style=Bold";

// Starting size. textmetrics() automatically reduces it.
font_size = 13; // [3:0.5:40]
minimum_font_size = 2.5; // [1:0.5:10]
text_spacing = 1.0; // [0.6:0.05:2]

// Guaranteed clearance between text and the actual body edge.
text_edge_clearance = 2.2; // [0.5:0.1:10]

// Additional clearance around an internal keyring hole.
text_hole_clearance = 2.0; // [0.5:0.1:10]

// Gap between line 1 and line 2.
line_gap = 1.3; // [0:0.1:8]

// Fine positioning after automatic layout.
text_x_adjust = 0; // [-15:0.25:15]
text_y_adjust = 0; // [-15:0.25:15]

text_relief = 0.8; // [0.2:0.1:3]
engrave_depth = 0.8; // [0.2:0.1:3]

// Inlay recess and insert height. The insert is automatically made slightly
// smaller in XY by inlay_clearance.
inlay_depth = 0.8; // [0.2:0.1:3]
inlay_clearance = 0.12; // [0:0.02:0.5]


/* [Symbol / monogram] */

symbol_text = "";

symbol_mode = "None"; // [None,Raised,Engraved,Cut Through,Inlay]

symbol_font = "Liberation Sans:style=Bold";
symbol_size = 8; // [2:0.5:30]

symbol_x = 0; // [-40:0.5:40]
symbol_y = -9; // [-30:0.5:30]

symbol_relief = 0.8; // [0.2:0.1:3]
symbol_engrave_depth = 0.8; // [0.2:0.1:3]
symbol_inlay_depth = 0.8; // [0.2:0.1:3]


/* [Border / face effect] */

border = true;

border_mode = "Raised"; // [Raised,Engraved,Inlay]

border_width = 1.1; // [0.4:0.1:5]
border_inset = 1.5; // [0.5:0.1:10]
border_relief = 0.55; // [0.2:0.05:3]
border_engrave_depth = 0.45; // [0.2:0.05:3]
border_inlay_depth = 0.6; // [0.2:0.05:3]


/* [Colors] */

// Preview color mode:
// Single Color = everything uses base_color
// Two Colors   = base uses base_color, all text/decorations use secondary_color
// Three Colors = base uses base_color, text uses text_color, decorations use decoration_color
color_display_mode = "Three Colors"; // [Single Color,Two Colors,Three Colors]

// Preset palette. Select Custom to use the custom colors below.
color_scheme = "Blue White"; // [Blue White,Black Yellow,Red White,Green White,Purple Gold,Orange Black,Custom]

// Custom colors are RGBA [R,G,B,A], values 0..1
custom_base_color = [0.10,0.35,0.85,1];
custom_secondary_color = [0.95,0.95,0.95,1];
custom_text_color = [0.95,0.95,0.95,1];
custom_decoration_color = [1.00,0.55,0.05,1];


/* [Advanced safety] */

// Tiny overlap for robust booleans; avoids coincident faces.
epsilon = 0.03;

// If true, text is ALWAYS intersected with the actual safe body mask.
// Keep this on unless debugging.
strict_text_clipping = true;

// Minimum width/height retained for generated safe regions.
minimum_safe_size = 1.0;


$fn = quality;


// ============================================================================
// Utility functions
// ============================================================================

function clamp(v, lo, hi) = min(max(v, lo), hi);
function nz(v, fallback=1) = abs(v) < 0.000001 ? fallback : v;
function nonempty(s) = len(s) > 0;

function body_diameter_if_circle() = min(body_width, body_height);

function nominal_w() =
    shape == "Circle" ? body_diameter_if_circle() : body_width;

function nominal_h() =
    shape == "Circle" ? body_diameter_if_circle() : body_height;

// Conservative rectangles fully contained well inside each shape.
// These are intentionally cautious; strict clipping remains the final guard.
function shape_safe_fx() =
    shape == "Rounded Rectangle" ? 0.92 :
    shape == "Capsule"           ? 0.80 :
    shape == "Circle"            ? 0.70 :
    shape == "Oval"              ? 0.70 :
    shape == "Hexagon"           ? 0.72 :
    shape == "Dog Tag"           ? 0.70 :
    shape == "Shield"            ? 0.58 :
    shape == "Heart"             ? 0.52 :
                                   0.70;

function shape_safe_fy() =
    shape == "Rounded Rectangle" ? 0.88 :
    shape == "Capsule"           ? 0.68 :
    shape == "Circle"            ? 0.70 :
    shape == "Oval"              ? 0.70 :
    shape == "Hexagon"           ? 0.72 :
    shape == "Dog Tag"           ? 0.68 :
    shape == "Shield"            ? 0.58 :
    shape == "Heart"             ? 0.42 :
                                   0.65;

function safe_rect_w_raw() =
    max(minimum_safe_size, nominal_w()*shape_safe_fx() - 2*text_edge_clearance);

function safe_rect_h_raw() =
    max(minimum_safe_size, nominal_h()*shape_safe_fy() - 2*text_edge_clearance);

// Hole size for internal holes is limited by the conservative safe rectangle.
// Side-lug holes do not need this clamp because the lug itself can grow.
function inside_hole_max_d() =
    max(1,
        min(
            nominal_w()*shape_safe_fx(),
            nominal_h()*shape_safe_fy()
        ) - 2*minimum_wall);

function effective_hole_d() =
    attachment == "Inside Hole"
    ? min(ring_hole_diameter, inside_hole_max_d())
    : ring_hole_diameter;

function effective_lug_outer_d() =
    max(lug_outer_diameter, effective_hole_d() + 2*minimum_wall);

function effective_lug_overlap() =
    lug_overlap > 0
    ? min(lug_overlap, effective_lug_outer_d()*0.48)
    : max(minimum_wall, effective_lug_outer_d()*0.24);

function lug_preset_x() =
    lug_position_mode == "Right" ? nominal_w()/2 + effective_lug_outer_d()/2 - effective_lug_overlap() :
    lug_position_mode == "Left"  ? -nominal_w()/2 - effective_lug_outer_d()/2 + effective_lug_overlap() :
    0;

function lug_preset_y() =
    lug_position_mode == "Top"    ? nominal_h()/2 + effective_lug_outer_d()/2 - effective_lug_overlap() :
    lug_position_mode == "Bottom" ? -nominal_h()/2 - effective_lug_outer_d()/2 + effective_lug_overlap() :
    0;

function lug_center_x() =
    (lug_position_mode == "Custom XY" ? lug_x : lug_preset_x()) + lug_offset_x;

function lug_center_y() =
    (lug_position_mode == "Custom XY" ? lug_y : lug_preset_y()) + lug_offset_y;

// Lug 2 uses its own hole diameter, OD, overlap, bridge and position.
function effective_lug2_hole_d() =
    max(1, lug2_hole_diameter);

function effective_lug2_outer_d() =
    max(lug2_outer_diameter, effective_lug2_hole_d() + 2*minimum_wall);

function effective_lug2_overlap() =
    lug2_overlap > 0
    ? min(lug2_overlap, effective_lug2_outer_d()*0.48)
    : max(minimum_wall, effective_lug2_outer_d()*0.24);

function lug2_preset_x() =
    lug2_position_mode == "Right" ? nominal_w()/2 + effective_lug2_outer_d()/2 - effective_lug2_overlap() :
    lug2_position_mode == "Left"  ? -nominal_w()/2 - effective_lug2_outer_d()/2 + effective_lug2_overlap() :
    0;

function lug2_preset_y() =
    lug2_position_mode == "Top"    ? nominal_h()/2 + effective_lug2_outer_d()/2 - effective_lug2_overlap() :
    lug2_position_mode == "Bottom" ? -nominal_h()/2 - effective_lug2_outer_d()/2 + effective_lug2_overlap() :
    0;

function lug2_center_x() =
    (lug2_position_mode == "Custom XY" ? lug2_x : lug2_preset_x()) + lug2_offset_x;

function lug2_center_y() =
    (lug2_position_mode == "Custom XY" ? lug2_y : lug2_preset_y()) + lug2_offset_y;

function inside_hole_x_limit() =
    max(0, nominal_w()*shape_safe_fx()/2 - minimum_wall - inside_hole_radius());

function inside_hole_y_limit() =
    max(0, nominal_h()*shape_safe_fy()/2 - minimum_wall - inside_hole_radius());

function inside_hole_preset_x() =
    inside_hole_position_mode == "Left"  ? -inside_hole_x_limit() :
    inside_hole_position_mode == "Right" ?  inside_hole_x_limit() : 0;

function inside_hole_preset_y() =
    inside_hole_position_mode == "Top"    ?  inside_hole_y_limit() :
    inside_hole_position_mode == "Bottom" ? -inside_hole_y_limit() : 0;

function inside_hole_x() =
    clamp((inside_hole_position_mode == "Custom XY" ? inside_hole_custom_x : inside_hole_preset_x()) + inside_hole_offset_x, -inside_hole_x_limit(), inside_hole_x_limit());

function inside_hole_y() =
    clamp((inside_hole_position_mode == "Custom XY" ? inside_hole_custom_y : inside_hole_preset_y()) + inside_hole_offset_y, -inside_hole_y_limit(), inside_hole_y_limit());

function hole_keepout_r() =
    inside_hole_radius() + text_hole_clearance;

// Text box accounts for internal hole by reserving everything left of the
// keepout circle. Fine user X adjustment is then clamped to keep text safe.
function text_box_left() =
    attachment == "Inside Hole"
    ? max(
        -safe_rect_w_raw()/2,
        inside_hole_x() + hole_keepout_r()
      )
    : -safe_rect_w_raw()/2;

function text_box_right() = safe_rect_w_raw()/2;

function text_box_w() =
    max(minimum_safe_size, text_box_right() - text_box_left());

function text_box_h() = safe_rect_h_raw();

function text_box_cx() = (text_box_left() + text_box_right())/2;

function text_x_adjust_clamped() =
    clamp(
        text_x_adjust,
        -text_box_w()*0.18,
         text_box_w()*0.18
    );

function text_y_adjust_clamped() =
    clamp(
        text_y_adjust,
        -text_box_h()*0.18,
         text_box_h()*0.18
    );


// textmetrics() wrapper matching the settings used by text().
function tm(s, size, fnt, spacing=1) =
    textmetrics(
        text=s,
        size=size,
        font=fnt,
        halign="left",
        valign="baseline",
        spacing=spacing
    );

function fit_text_size(s, wanted_size, max_w, max_h, fnt, spacing=1, min_size=1) =
    !nonempty(s) ? wanted_size :
    let(
        m = tm(s, wanted_size, fnt, spacing),
        sx = max_w / nz(m.size.x),
        sy = max_h / nz(m.size.y),
        k = min(1, sx, sy)
    )
    max(min_size, wanted_size*k);

// Offset which places actual glyph ink bounds around origin, not merely the
// font's nominal advance box.
function ink_center_offset(s, size, fnt, spacing=1) =
    let(m = tm(s, size, fnt, spacing))
    [
        -m.position.x - m.size.x/2,
        -m.position.y - m.size.y/2
    ];

function line_count() =
    (nonempty(text_line_1) ? 1 : 0)
    + (nonempty(text_line_2) ? 1 : 0);

function per_line_box_h() =
    line_count() <= 1
    ? text_box_h()
    : max(minimum_safe_size, (text_box_h()-line_gap)/2);

function line1_size() =
    fit_text_size(
        text_line_1, font_size,
        text_box_w(), per_line_box_h(),
        font, text_spacing, minimum_font_size
    );

function line2_size() =
    fit_text_size(
        text_line_2, font_size,
        text_box_w(), per_line_box_h(),
        font, text_spacing, minimum_font_size
    );


// ============================================================================
// Color functions
// ============================================================================

// Palette base color.
function palette_base_col() =
    color_scheme == "Blue White"   ? [0.08,0.32,0.78,1] :
    color_scheme == "Black Yellow" ? [0.04,0.04,0.05,1] :
    color_scheme == "Red White"    ? [0.72,0.05,0.08,1] :
    color_scheme == "Green White"  ? [0.05,0.48,0.24,1] :
    color_scheme == "Purple Gold"  ? [0.32,0.10,0.52,1] :
    color_scheme == "Orange Black" ? [0.95,0.30,0.03,1] :
                                     custom_base_color;

// Palette secondary color, used by Two Colors mode for *everything except base*.
function palette_secondary_col() =
    color_scheme == "Blue White"   ? [0.96,0.97,1.00,1] :
    color_scheme == "Black Yellow" ? [1.00,0.80,0.02,1] :
    color_scheme == "Red White"    ? [1.00,0.97,0.96,1] :
    color_scheme == "Green White"  ? [0.96,1.00,0.96,1] :
    color_scheme == "Purple Gold"  ? [0.95,0.68,0.12,1] :
    color_scheme == "Orange Black" ? [0.03,0.03,0.03,1] :
                                     custom_secondary_color;

// Palette text color, used only by Three Colors mode.
function palette_text_col() =
    color_scheme == "Blue White"   ? [0.96,0.97,1.00,1] :
    color_scheme == "Black Yellow" ? [1.00,0.80,0.02,1] :
    color_scheme == "Red White"    ? [1.00,0.97,0.96,1] :
    color_scheme == "Green White"  ? [0.96,1.00,0.96,1] :
    color_scheme == "Purple Gold"  ? [0.95,0.68,0.12,1] :
    color_scheme == "Orange Black" ? [0.03,0.03,0.03,1] :
                                     custom_text_color;

// Palette decoration/accent color, used only by Three Colors mode.
function palette_decoration_col() =
    color_scheme == "Blue White"   ? [0.15,0.72,1.00,1] :
    color_scheme == "Black Yellow" ? [1.00,0.52,0.00,1] :
    color_scheme == "Red White"    ? [1.00,0.58,0.12,1] :
    color_scheme == "Green White"  ? [0.20,0.85,0.52,1] :
    color_scheme == "Purple Gold"  ? [1.00,0.73,0.18,1] :
    color_scheme == "Orange Black" ? [1.00,0.76,0.20,1] :
                                     custom_decoration_color;

// Final preview colors according to the requested display mode.
function base_col() =
    palette_base_col();

function text_col() =
    color_display_mode == "Single Color" ? palette_base_col() :
    color_display_mode == "Two Colors"   ? palette_secondary_col() :
                                           palette_text_col();

function decoration_col() =
    color_display_mode == "Single Color" ? palette_base_col() :
    color_display_mode == "Two Colors"   ? palette_secondary_col() :
                                           palette_decoration_col();


// ============================================================================
// ============================================================================
// 2D body geometry
// ============================================================================

module rounded_rectangle_2d(w, h, r) {
    rr = clamp(r, 0, min(w,h)/2);
    if (rr <= epsilon)
        square([w,h], center=true);
    else
        offset(r=rr)
            square(
                [max(epsilon,w-2*rr), max(epsilon,h-2*rr)],
                center=true
            );
}

module capsule_2d(w,h) {
    if (w >= h) {
        r = h/2;
        hull() {
            translate([-w/2+r,0]) circle(r=r);
            translate([ w/2-r,0]) circle(r=r);
        }
    } else {
        r = w/2;
        hull() {
            translate([0,-h/2+r]) circle(r=r);
            translate([0, h/2-r]) circle(r=r);
        }
    }
}

module hexagon_2d(w,h) {
    polygon([
        [-w/2,0],[-w/4,h/2],[w/4,h/2],
        [w/2,0],[w/4,-h/2],[-w/4,-h/2]
    ]);
}

module dog_tag_2d(w,h,r) {
    rr = clamp(r,0.8,min(w,h)/5);
    hull() {
        translate([-w/2+rr,-h/2+rr]) circle(r=rr);
        translate([ w/2-rr,-h/2+rr]) circle(r=rr);
        translate([-w/2+rr, h/2-rr*1.7]) circle(r=rr);
        translate([ w/2-rr, h/2-rr*1.7]) circle(r=rr);
        translate([0,h/2-rr*0.30])
            square([max(epsilon,w-4*rr),rr*0.55],center=true);
    }
}

module shield_2d(w,h) {
    polygon([
        [-w/2,h*0.40],
        [-w*0.36,h/2],
        [ w*0.36,h/2],
        [ w/2,h*0.40],
        [ w*0.43,-h*0.08],
        [ w*0.24,-h*0.32],
        [ 0,-h/2],
        [-w*0.24,-h*0.32],
        [-w*0.43,-h*0.08]
    ]);
}

module heart_2d(w,h) {
    // Symmetric, solid printable heart centered around the origin.
    scale([w/40,h/38])
    union() {
        hull() {
            translate([-10,7]) circle(r=10);
            translate([0,-15]) circle(r=1.0);
        }
        hull() {
            translate([10,7]) circle(r=10);
            translate([0,-15]) circle(r=1.0);
        }
    }
}

module core_body_2d() {
    w = nominal_w();
    h = nominal_h();

    if (shape == "Rounded Rectangle")
        rounded_rectangle_2d(w,h,corner_radius);
    else if (shape == "Capsule")
        capsule_2d(w,h);
    else if (shape == "Circle")
        circle(d=body_diameter_if_circle());
    else if (shape == "Oval")
        scale([w/2,h/2]) circle(r=1);
    else if (shape == "Hexagon")
        hexagon_2d(w,h);
    else if (shape == "Dog Tag")
        dog_tag_2d(w,h,corner_radius);
    else if (shape == "Shield")
        shield_2d(w,h);
    else if (shape == "Heart")
        heart_2d(w,h);
    else
        rounded_rectangle_2d(w,h,corner_radius);
}


// ============================================================================
// Attachment geometry
// ============================================================================

module one_lug_positive_2d(position_mode, cx, cy, d, overlap, bridge) {
    bridge_d = max(bridge, minimum_wall*2);

    ax =
        position_mode == "Right" ? nominal_w()/2-overlap :
        position_mode == "Left"  ? -nominal_w()/2+overlap :
        clamp(cx, -nominal_w()/2+overlap, nominal_w()/2-overlap);

    ay =
        position_mode == "Top" ? nominal_h()/2-overlap :
        position_mode == "Bottom" ? -nominal_h()/2+overlap :
        clamp(cy, -nominal_h()/2+overlap, nominal_h()/2-overlap);

    // Main neck. hull() guarantees a connected printable join.
    hull() {
        translate([ax,ay]) circle(d=bridge_d);
        translate([cx,cy]) circle(d=d);
    }

    // Reinforced Lug adds two gussets perpendicular to the bridge direction.
    if (attachment == "Reinforced Lug") {
        vx = cx-ax;
        vy = cy-ay;
        vl = max(epsilon, sqrt(vx*vx + vy*vy));
        px = -vy/vl;
        py =  vx/vl;

        for (sgn=[-1,1])
            hull() {
                translate([
                    ax + px*sgn*bridge_d*0.36,
                    ay + py*sgn*bridge_d*0.36
                ])
                    circle(d=max(minimum_wall*1.6,bridge_d*0.55));

                translate([
                    cx - vx/vl*d*0.18 + px*sgn*d*0.18,
                    cy - vy/vl*d*0.18 + py*sgn*d*0.18
                ])
                    circle(d=max(minimum_wall*1.6,bridge_d*0.50));
            }
    }
}

module side_lug_1_positive_2d() {
    one_lug_positive_2d(
        lug_position_mode,
        lug_center_x(),
        lug_center_y(),
        effective_lug_outer_d(),
        effective_lug_overlap(),
        lug_bridge
    );
}

module side_lug_2_positive_2d() {
    one_lug_positive_2d(
        lug2_position_mode,
        lug2_center_x(),
        lug2_center_y(),
        effective_lug2_outer_d(),
        effective_lug2_overlap(),
        lug2_bridge
    );
}

module attachment_positive_2d() {
    if (attachment == "Side Lug" || attachment == "Reinforced Lug") {
        side_lug_1_positive_2d();

        if (lug_count >= 2)
            side_lug_2_positive_2d();
    }
}

module ring_hole_2d(extra=0) {
    if (attachment == "Side Lug" || attachment == "Reinforced Lug") {
        translate([lug_center_x(),lug_center_y()])
            circle(d=max(epsilon,effective_hole_d()+2*extra));

        if (lug_count >= 2)
            translate([lug2_center_x(),lug2_center_y()])
                circle(d=max(epsilon,effective_lug2_hole_d()+2*extra));
    }

    else if (attachment == "Inside Hole")
        translate([inside_hole_x(),inside_hole_y()])
            circle(d=max(epsilon,effective_hole_d()+2*extra));
}

module full_profile_2d() {
    difference() {
        union() {
            core_body_2d();
            attachment_positive_2d();
        }
        ring_hole_2d();
    }
}


// ============================================================================
// Safe masks
// ============================================================================

module inset_core_mask_2d(clearance) {
    // offset(delta<0) follows the ACTUAL contour, so circles, hearts,
    // shields, etc. receive a true geometry-based inset.
    offset(delta=-max(0,clearance))
        core_body_2d();
}

module text_safe_mask_2d() {
    difference() {
        inset_core_mask_2d(text_edge_clearance);

        // Reserve a wider safety circle around an internal ring hole.
        if (attachment == "Inside Hole")
            ring_hole_2d(text_hole_clearance);
    }
}

module accent_safe_mask_2d() {
    difference() {
        inset_core_mask_2d(max(0.5,text_edge_clearance*0.5));
        if (attachment == "Inside Hole")
            ring_hole_2d(max(0.5,text_hole_clearance*0.5));
    }
}


// ============================================================================
// Text geometry
// ============================================================================

module tight_text_2d(s,size,fnt,spacing=1) {
    if (nonempty(s)) {
        o = ink_center_offset(s,size,fnt,spacing);
        translate(o)
            text(
                text=s,
                size=size,
                font=fnt,
                halign="left",
                valign="baseline",
                spacing=spacing
            );
    }
}

module raw_fitted_text_2d() {
    n = line_count();
    cx = text_box_cx() + text_x_adjust_clamped();
    cy = text_y_adjust_clamped();

    if (n == 1) {
        s = nonempty(text_line_1) ? text_line_1 : text_line_2;
        fs = nonempty(text_line_1) ? line1_size() : line2_size();

        translate([cx,cy])
            tight_text_2d(s,fs,font,text_spacing);
    }

    if (n == 2) {
        fs1 = line1_size();
        fs2 = line2_size();

        m1 = tm(text_line_1,fs1,font,text_spacing);
        m2 = tm(text_line_2,fs2,font,text_spacing);

        total_h = m1.size.y + line_gap + m2.size.y;

        y1 = cy + total_h/2 - m1.size.y/2;
        y2 = cy - total_h/2 + m2.size.y/2;

        translate([cx,y1])
            tight_text_2d(text_line_1,fs1,font,text_spacing);

        translate([cx,y2])
            tight_text_2d(text_line_2,fs2,font,text_spacing);
    }
}

module fitted_text_2d() {
    if (strict_text_clipping)
        intersection() {
            raw_fitted_text_2d();
            text_safe_mask_2d();
        }
    else
        raw_fitted_text_2d();
}

module symbol_raw_2d() {
    if (nonempty(symbol_text))
        translate([symbol_x,symbol_y])
            tight_text_2d(symbol_text,symbol_size,symbol_font,1);
}

module symbol_safe_2d() {
    if (strict_text_clipping)
        intersection() {
            symbol_raw_2d();
            text_safe_mask_2d();
        }
    else
        symbol_raw_2d();
}


// ============================================================================
// Border geometry
// ============================================================================

module border_ring_2d() {
    // Inset border follows the exact body silhouette.
    difference() {
        offset(delta=-border_inset)
            core_body_2d();
        offset(delta=-(border_inset+border_width))
            core_body_2d();
    }
}


// ============================================================================
// Feature classification helpers
// ============================================================================

function text_is_subtractive() =
    text_mode == "Engraved"
    || text_mode == "Cut Through"
    || text_mode == "Inlay";

function symbol_is_subtractive() =
    symbol_mode == "Engraved"
    || symbol_mode == "Cut Through"
    || symbol_mode == "Inlay";

function border_is_subtractive() =
    border && (
        border_mode == "Engraved"
        || border_mode == "Inlay"
    );


// ============================================================================
// Base part
// ============================================================================

module base_solid_3d() {
    difference() {
        linear_extrude(height=body_thickness)
            full_profile_2d();

        // Main text cavities/cuts.
        if (text_mode == "Engraved" && line_count()>0)
            translate([0,0,max(0,body_thickness-engrave_depth)])
                linear_extrude(height=min(body_thickness,engrave_depth)+2*epsilon)
                    fitted_text_2d();

        if (text_mode == "Cut Through" && line_count()>0)
            translate([0,0,-epsilon])
                linear_extrude(height=body_thickness+2*epsilon)
                    fitted_text_2d();

        if (text_mode == "Inlay" && line_count()>0)
            translate([0,0,max(0,body_thickness-inlay_depth)])
                linear_extrude(height=min(body_thickness,inlay_depth)+2*epsilon)
                    fitted_text_2d();

        // Symbol cavities/cuts.
        if (symbol_mode == "Engraved" && nonempty(symbol_text))
            translate([0,0,max(0,body_thickness-symbol_engrave_depth)])
                linear_extrude(height=min(body_thickness,symbol_engrave_depth)+2*epsilon)
                    symbol_safe_2d();

        if (symbol_mode == "Cut Through" && nonempty(symbol_text))
            translate([0,0,-epsilon])
                linear_extrude(height=body_thickness+2*epsilon)
                    symbol_safe_2d();

        if (symbol_mode == "Inlay" && nonempty(symbol_text))
            translate([0,0,max(0,body_thickness-symbol_inlay_depth)])
                linear_extrude(height=min(body_thickness,symbol_inlay_depth)+2*epsilon)
                    symbol_safe_2d();

        // Border cavity.
        if (border && border_mode == "Engraved")
            translate([0,0,max(0,body_thickness-border_engrave_depth)])
                linear_extrude(height=min(body_thickness,border_engrave_depth)+2*epsilon)
                    border_ring_2d();

        if (border && border_mode == "Inlay")
            translate([0,0,max(0,body_thickness-border_inlay_depth)])
                linear_extrude(height=min(body_thickness,border_inlay_depth)+2*epsilon)
                    border_ring_2d();
    }
}


// ============================================================================
// Text / inlay part
// ============================================================================

module text_part_3d() {
    // Raised main text.
    if (text_mode == "Raised" && line_count()>0)
        translate([0,0,body_thickness-epsilon])
            linear_extrude(height=text_relief+epsilon)
                fitted_text_2d();

    // Inlay text. Negative offset creates assembly clearance.
    if (text_mode == "Inlay" && line_count()>0)
        translate([0,0,body_thickness-inlay_depth])
            linear_extrude(height=inlay_depth)
                offset(delta=-inlay_clearance)
                    fitted_text_2d();

    // Raised symbol shares the text color.
    if (symbol_mode == "Raised" && nonempty(symbol_text))
        translate([0,0,body_thickness-epsilon])
            linear_extrude(height=symbol_relief+epsilon)
                symbol_safe_2d();

    if (symbol_mode == "Inlay" && nonempty(symbol_text))
        translate([0,0,body_thickness-symbol_inlay_depth])
            linear_extrude(height=symbol_inlay_depth)
                offset(delta=-inlay_clearance)
                    symbol_safe_2d();
}


// ============================================================================
// Accent part
// ============================================================================

module accent_part_3d() {
    if (border && border_mode == "Raised")
        translate([0,0,body_thickness-epsilon])
            linear_extrude(height=border_relief+epsilon)
                border_ring_2d();

    if (border && border_mode == "Inlay")
        translate([0,0,body_thickness-border_inlay_depth])
            linear_extrude(height=border_inlay_depth)
                offset(delta=-min(inlay_clearance,border_width*0.25))
                    border_ring_2d();
}


// ============================================================================
// 2D output
// ============================================================================

module base_part_2d() {
    difference() {
        full_profile_2d();

        if (text_mode == "Cut Through")
            fitted_text_2d();

        if (symbol_mode == "Cut Through")
            symbol_safe_2d();
    }
}

module text_part_2d() {
    if (
        text_mode == "Raised"
        || text_mode == "Engraved"
        || text_mode == "Inlay"
    )
        fitted_text_2d();

    if (
        symbol_mode == "Raised"
        || symbol_mode == "Engraved"
        || symbol_mode == "Inlay"
    )
        symbol_safe_2d();
}

module accent_part_2d() {
    if (border)
        border_ring_2d();
}


// ============================================================================
// Colored assembly / selective export
// ============================================================================

module colored_3d() {
    if (output_part == "All" || output_part == "Base Only")
        color(base_col())
            base_solid_3d();

    if (output_part == "All" || output_part == "Text Only")
        color(text_col())
            text_part_3d();

    if (output_part == "All" || output_part == "Accent Only")
        color(decoration_col())
            accent_part_3d();
}

module colored_2d() {
    if (output_part == "All" || output_part == "Base Only")
        color(base_col())
            base_part_2d();

    if (output_part == "All" || output_part == "Text Only")
        color(text_col())
            text_part_2d();

    if (output_part == "All" || output_part == "Accent Only")
        color(decoration_col())
            accent_part_2d();
}


// ============================================================================
// Diagnostics
// ============================================================================

module diagnostics() {
    if (debug_info) {
        echo("=== KEYRING GENERATOR v5 ===");
        echo("Shape",shape);
        echo("Body", [nominal_w(),nominal_h(),body_thickness]);
        echo("Attachment",attachment);
        echo("Requested ring hole",ring_hole_diameter);
        echo("Effective ring hole",effective_hole_d());
        echo("Lug count",lug_count);
        echo("Lug 1 position mode",lug_position_mode);
        echo("Lug 1 center",[lug_center_x(),lug_center_y()]);
        if (lug_count >= 2) {
            echo("Lug 2 position mode",lug2_position_mode);
            echo("Lug 2 center",[lug2_center_x(),lug2_center_y()]);
            echo("Lug 2 hole diameter",effective_lug2_hole_d());
            echo("Lug 2 outer diameter",effective_lug2_outer_d());
            echo("Lug 2 radial wall",(effective_lug2_outer_d()-effective_lug2_hole_d())/2);
        }
        echo("Inside hole position mode",inside_hole_position_mode);

        if (attachment == "Side Lug" || attachment == "Reinforced Lug") {
            echo("Requested lug OD",lug_outer_diameter);
            echo("Effective lug OD",effective_lug_outer_d());
            echo(
                "Lug radial wall",
                (effective_lug_outer_d()-effective_hole_d())/2
            );
        }

        if (attachment == "Inside Hole") {
            echo("Inside hole center",[inside_hole_x(),inside_hole_y()]);
            echo("Inside hole max diameter",inside_hole_max_d());

            if (ring_hole_diameter > inside_hole_max_d())
                echo(
                    "NOTICE: Inside hole was automatically reduced to preserve minimum_wall."
                );
        }

        echo("Safe text rectangle",[text_box_w(),text_box_h()]);
        echo("Safe text center",[text_box_cx(),0]);
        echo("Text line 1 fitted size",line1_size());
        echo("Text line 2 fitted size",line2_size());
        echo("Strict text clipping",strict_text_clipping);
        echo("Color display mode",color_display_mode);

        if (text_mode == "Engraved" && engrave_depth >= body_thickness)
            echo(
                "NOTICE: Engraving depth reaches body thickness; consider Cut Through."
            );

        if (text_mode == "Inlay" && inlay_depth >= body_thickness)
            echo(
                "WARNING: Inlay depth consumes full base thickness."
            );

        if (border && border_inset+border_width >= min(nominal_w(),nominal_h())/2)
            echo(
                "WARNING: Border inset/width may collapse on this body size."
            );
    }
}


// ============================================================================
// Build
// ============================================================================

diagnostics();

if (output_mode == "2D")
    colored_2d();
else
    colored_3d();
