/*
===============================================================================
 UNIVERSAL SIGN GENERATOR - OpenSCAD Nightly
 Version 1.0 - 2026-09
-------------------------------------------------------------------------------
 Selvstændig parametrisk skiltegenerator til:
   - 3D-print
   - CNC-fræsning / 2.5D-gravering
   - Laserskæring / lasergravering

 Designmål:
   * Flere tekstlinjer med individuel font, størrelse, spacing og finjustering.
   * Nightly textmetrics() + fontmetrics() til reel fontmåling og auto-sizing.
   * Moderne em-baseret fontstørrelse kan vælges.
   * Mange pladeformer, konstruktioner og monteringsformer kan kombineres.
   * Raised / engraved / cut-through / inlay tekst.
   * Raised / engraved / cut-through kant.
   * 2D outputs til SVG/DXF og 3D outputs til STL/3MF.
   * Ingen eksterne libraries.

 NIGHTLY:
   textmetrics() / fontmetrics() er fortsat en udviklingsfunktion i aktuelle
   snapshots. I GUI: Preferences -> Features -> textmetrics.
   CLI: openscad-nightly --enable=textmetrics ...

 FALLBACK:
   Sæt Use_Nightly_Metrics=false hvis du vil åbne filen i en ældre OpenSCAD.
   Auto-sizing bliver da en tilnærmelse og em-mode bør ikke anvendes.

 FONT-FILER:
   Projektspecifikke .ttf/.otf kan registreres med en literal use<>-linje,
   eksempel:
       use <fonts/MyFont.ttf>
   Derefter anvendes fontens logiske navn i Line_*_Font.

 OBS:
   OpenSCAD arbejder uden fysiske enheder; værdierne er tænkt som millimeter.
===============================================================================
*/


/* [Output] */

// Primært output
Output_Mode = "3D"; // ["3D","2D Cut Outline","2D Engrave Text","2D Text/Inlay","2D Border","2D Fold Score"]

// Grundkonstruktion
Construction = "Flat Plate"; // ["Flat Plate","Desk L-Stand","Desk Wedge","Desk Slot Stand","A-Frame Tent","Foldable Sheet Blank","Stake Sign"]

// Hvilken del vises/eksporteres i 3D
Part_Selection = "Assembly"; // ["Assembly","Face only","Support only","Text insert only"]

// Brug præcis Nightly fontmåling
Use_Nightly_Metrics = true;


/* [Skiltform] */

Plate_Shape = "Rounded Rectangle"; // ["Rectangle","Square","Rounded Rectangle","Capsule","Circle","Oval","Triangle","Diamond","Hexagon","Octagon","Shield","Arch","Tag","Arrow Right","Pennant"]

Auto_Size_Plate = true;

// Bruges hvis Auto_Size_Plate=false
Manual_Width = 160;   // [20:1:600]
Manual_Height = 70;   // [20:1:400]

// Minimum ved auto-size
Minimum_Width = 70;   // [10:1:600]
Minimum_Height = 35;  // [10:1:400]

// Luft omkring tekstblokken
Padding_X = 14;       // [0:0.5:80]
Padding_Y = 10;       // [0:0.5:80]

// Ekstra konservativ sikkerhed for former med smalle hjørner
Shape_Text_Safety = 1.00; // [0.5:0.01:1.2]

// Hjørner / formdetaljer
Corner_Radius = 8;    // [0:0.5:60]
Tag_Cut = 10;         // [1:0.5:60]
Arrow_Head_Fraction = 0.30; // [0.15:0.01:0.50]
Arch_Radius_Fraction = 0.40; // [0.20:0.01:0.50]

// Pladetykkelse
Plate_Thickness = 3.0; // [0.4:0.1:30]

// Kantprofil
Edge_Profile = "Straight"; // ["Straight","Chamfered"]
Bevel_Size = 0.8;          // [0:0.1:5]


/* [Tekst - generelt] */

Font_Sizing_Mode = "size"; // ["size","em"]

Text_Mode = "Raised"; // ["Raised","Engraved","Cut-through","Inlay","None"]

Text_HAlign = "center"; // ["left","center","right"]
Text_Direction = "ltr"; // ["ltr","rtl","ttb","btt"]
Text_Language = "da";
Text_Script = "latin";

// Afstand mellem line-boxes ud over fontens interline
Line_Gap = 2.0;       // [-5:0.25:30]
Leading_Scale = 1.00; // [0.5:0.01:2.0]

// Global flytning af tekstblokken
Text_Offset_X = 0; // [-100:0.5:100]
Text_Offset_Y = 0; // [-100:0.5:100]

// Ved fast pladestørrelse: nedskaler automatisk hvis teksten ikke kan være der
Scale_Text_Down_To_Fit = true;
Text_Global_Scale = 1.0; // [0.1:0.01:3]

// Relief / gravering
Text_Raised_Height = 1.0; // [0.1:0.1:10]
Text_Engrave_Depth = 0.8; // [0.1:0.1:20]

// Inlay
Inlay_Depth = 1.2;        // [0.2:0.1:20]
Inlay_XY_Clearance = 0.15; // [0:0.01:1]
Inlay_Z_Clearance = 0.10;  // [0:0.01:1]


/* [Tekstlinje 1] */
Line_1_Text = "MAKERSPACE";
Line_1_Size = 18; // [1:0.5:150]
Line_1_Font = "Liberation Sans:style=Bold";
Line_1_Spacing = 1.0; // [0.5:0.01:2]
Line_1_X = 0; // [-100:0.5:100]
Line_1_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 2] */
Line_2_Text = "NÆSTVED";
Line_2_Size = 11; // [1:0.5:150]
Line_2_Font = "Liberation Sans";
Line_2_Spacing = 1.0; // [0.5:0.01:2]
Line_2_X = 0; // [-100:0.5:100]
Line_2_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 3] */
Line_3_Text = "";
Line_3_Size = 9; // [1:0.5:150]
Line_3_Font = "Liberation Sans";
Line_3_Spacing = 1.0; // [0.5:0.01:2]
Line_3_X = 0; // [-100:0.5:100]
Line_3_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 4] */
Line_4_Text = "";
Line_4_Size = 8; // [1:0.5:150]
Line_4_Font = "Liberation Sans";
Line_4_Spacing = 1.0; // [0.5:0.01:2]
Line_4_X = 0; // [-100:0.5:100]
Line_4_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 5] */
Line_5_Text = "";
Line_5_Size = 8; // [1:0.5:150]
Line_5_Font = "Liberation Sans";
Line_5_Spacing = 1.0; // [0.5:0.01:2]
Line_5_X = 0; // [-100:0.5:100]
Line_5_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 6] */
Line_6_Text = "";
Line_6_Size = 8; // [1:0.5:150]
Line_6_Font = "Liberation Sans";
Line_6_Spacing = 1.0; // [0.5:0.01:2]
Line_6_X = 0; // [-100:0.5:100]
Line_6_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 7] */
Line_7_Text = "";
Line_7_Size = 8; // [1:0.5:150]
Line_7_Font = "Liberation Sans";
Line_7_Spacing = 1.0; // [0.5:0.01:2]
Line_7_X = 0; // [-100:0.5:100]
Line_7_Y = 0; // [-100:0.5:100]

/* [Tekstlinje 8] */
Line_8_Text = "";
Line_8_Size = 8; // [1:0.5:150]
Line_8_Font = "Liberation Sans";
Line_8_Spacing = 1.0; // [0.5:0.01:2]
Line_8_X = 0; // [-100:0.5:100]
Line_8_Y = 0; // [-100:0.5:100]


/* [Kant / border] */

Border_Style = "None"; // ["None","Raised","Engraved","Cut-through"]
Border_Width = 2.0;    // [0.3:0.1:20]
Border_Inset = 3.0;    // [0:0.1:30]
Border_Raised_Height = 0.8; // [0.1:0.1:10]
Border_Engrave_Depth = 0.6; // [0.1:0.1:20]


/* [Montering] */

Mounting_Style = "None"; // ["None","2 Hanging Holes","2 Side Holes","4 Corner Holes","2 Countersunk","4 Countersunk","Lanyard Hole","Zip-tie Slots","Keyhole Pair","Magnet Pair","Magnet Quad"]

Mount_Edge = 10;       // [2:0.5:80]
Hole_Diameter = 4.0;   // [1:0.1:30]

Countersink_Diameter = 8.0; // [2:0.1:40]
Countersink_Depth = 1.8;    // [0.2:0.1:10]

// Magnetlommer skæres fra bagsiden
Magnet_Diameter = 10.2; // [2:0.1:40]
Magnet_Depth = 2.2;     // [0.2:0.1:20]
Magnet_Spacing = 70;    // [5:1:400]

// Nøglehulslommer skæres fra bagsiden
Keyhole_Head_Diameter = 8.5; // [2:0.1:30]
Keyhole_Neck_Width = 4.0;    // [1:0.1:20]
Keyhole_Length = 14;         // [4:0.5:50]
Keyhole_Depth = 2.0;         // [0.2:0.1:20]

// Kabelbinder-slots
Zip_Slot_Length = 12; // [3:0.5:50]
Zip_Slot_Width = 3.5; // [1:0.1:20]


/* [Bordskilte / standere] */

Desk_Angle = 72; // [45:1:90]

Base_Thickness = 4; // [1:0.5:30]
Base_Depth = 45;    // [10:1:150]
Base_Width_Extra = 16; // [0:1:100]
Base_Front_Lip = 8; // [0:1:50]

// Giver fysisk overlap ved monolitiske standere
Base_Embed = 1.5; // [0.2:0.1:10]

// Slotstander
Slot_Clearance = 0.30; // [0:0.05:2]
Slot_Depth = 2.5;      // [0.5:0.1:20]

// Wedge
Wedge_Depth = 35;          // [5:1:150]
Wedge_Height_Fraction = 0.65; // [0.2:0.01:0.95]
Wedge_Width_Fraction = 0.70;  // [0.2:0.01:1]

// A-frame
Tent_Angle = 70;          // [45:1:85]
Tent_Top_Bar = true;
Tent_Top_Bar_Diameter = 5; // [1:0.5:20]


/* [Foldbart plademateriale] */

// Foldable Sheet Blank er lavet til fx karton, PP, tynd plast, finer mv.
Fold_Hinge_Band = 4; // [0:0.5:30]
Fold_Score_Width = 0.35; // [0.1:0.05:3]
Fold_Corner_Radius = 4; // [0:0.5:30]
Fold_Sheet_Thickness = 1.0; // [0.2:0.1:10]
Fold_Text_On_Both_Panels = true;


/* [Stake sign] */

Stake_Width = 18;  // [5:1:80]
Stake_Length = 90; // [20:1:400]
Stake_Tip_Length = 25; // [5:1:100]


/* [Kvalitet] */

Curve_FN = 96; // [12:4:360]
Text_FN = 32;  // [8:2:128]
Arch_Segments = 48; // [12:2:180]

EPS = 0.02;


/* ---------------------------------------------------------------------------
   DATA + FONT METRICS
--------------------------------------------------------------------------- */

raw_lines = [
    [Line_1_Text, Line_1_Size, Line_1_Font, Line_1_Spacing, Line_1_X, Line_1_Y],
    [Line_2_Text, Line_2_Size, Line_2_Font, Line_2_Spacing, Line_2_X, Line_2_Y],
    [Line_3_Text, Line_3_Size, Line_3_Font, Line_3_Spacing, Line_3_X, Line_3_Y],
    [Line_4_Text, Line_4_Size, Line_4_Font, Line_4_Spacing, Line_4_X, Line_4_Y],
    [Line_5_Text, Line_5_Size, Line_5_Font, Line_5_Spacing, Line_5_X, Line_5_Y],
    [Line_6_Text, Line_6_Size, Line_6_Font, Line_6_Spacing, Line_6_X, Line_6_Y],
    [Line_7_Text, Line_7_Size, Line_7_Font, Line_7_Spacing, Line_7_X, Line_7_Y],
    [Line_8_Text, Line_8_Size, Line_8_Font, Line_8_Spacing, Line_8_X, Line_8_Y]
];

active_lines = [for (l = raw_lines) if (len(l[0]) > 0) l];

function sum_vec(v, i=0) =
    i >= len(v) ? 0 : v[i] + sum_vec(v, i+1);

function sum_first(v, count, i=0) =
    i >= count ? 0 : v[i] + sum_first(v, count, i+1);

function line_tm(l) =
    Font_Sizing_Mode == "em"
    ? textmetrics(
        text=l[0], em=l[1], font=l[2],
        direction=Text_Direction, language=Text_Language, script=Text_Script,
        halign="center", valign="center", spacing=l[3])
    : textmetrics(
        text=l[0], size=l[1], font=l[2],
        direction=Text_Direction, language=Text_Language, script=Text_Script,
        halign="center", valign="center", spacing=l[3]);

function line_fm(l) =
    Font_Sizing_Mode == "em"
    ? fontmetrics(em=l[1], font=l[2])
    : fontmetrics(size=l[1], font=l[2]);

function fallback_width(l) =
    max([0.01, len(l[0]) * l[1] * 0.62 * l[3]]);

function fallback_height(l) =
    max([0.01, l[1]]);

function line_width(l) =
    Use_Nightly_Metrics ? max([0.01, line_tm(l).size[0]]) : fallback_width(l);

function line_height(l) =
    Use_Nightly_Metrics ? max([0.01, line_tm(l).size[1]]) : fallback_height(l);

function line_interline(l) =
    Use_Nightly_Metrics
    ? max([0.01, line_fm(l).interline])
    : l[1] * 1.22;

line_boxes = [
    for (l = active_lines)
        max([line_height(l), line_interline(l) * Leading_Scale])
];

text_block_width =
    len(active_lines) > 0
    ? max([for (l = active_lines) line_width(l)])
    : 0.01;

text_block_height =
    len(active_lines) > 0
    ? sum_vec(line_boxes) + max([0, len(active_lines)-1]) * Line_Gap
    : 0.01;

function line_center_y(i) =
    text_block_height/2
    - sum_first(line_boxes, i)
    - i * Line_Gap
    - line_boxes[i]/2;

function text_anchor_x() =
    Text_HAlign == "left"  ? -text_block_width/2 :
    Text_HAlign == "right" ?  text_block_width/2 :
                              0;


/* ---------------------------------------------------------------------------
   SHAPE MATH
--------------------------------------------------------------------------- */

// Faktor for den nogenlunde rektangulære "safe text area" inde i formen.
function native_shape_safe(shape) =
    shape == "Circle"   ? [0.80, 0.80] :
    shape == "Oval"     ? [0.84, 0.78] :
    shape == "Triangle" ? [0.62, 0.54] :
    shape == "Diamond"  ? [0.65, 0.65] :
    shape == "Hexagon"  ? [0.82, 0.82] :
    shape == "Octagon"  ? [0.88, 0.88] :
    shape == "Shield"   ? [0.76, 0.74] :
    shape == "Arch"     ? [0.88, 0.82] :
    shape == "Arrow Right" ? [0.66, 0.82] :
    shape == "Pennant"  ? [0.70, 0.82] :
    [1.0, 1.0];

safe_factor = native_shape_safe(Plate_Shape) * Shape_Text_Safety;

mount_feature_d =
    Mounting_Style == "Magnet Pair" || Mounting_Style == "Magnet Quad"
    ? Magnet_Diameter
    : Mounting_Style == "Keyhole Pair"
      ? Keyhole_Head_Diameter
      : max([Hole_Diameter, Countersink_Diameter]);

mount_min_w =
    Mounting_Style == "None" || Mounting_Style == "Lanyard Hole"
    ? 0
    : 2 * (Mount_Edge + mount_feature_d/2 + 2);

mount_min_h =
    Mounting_Style == "None"
    ? 0
    : 2 * (Mount_Edge + mount_feature_d/2 + 2);

auto_width_raw =
    max([
        Minimum_Width,
        (text_block_width + 2*Padding_X) / max([0.1, safe_factor[0]]),
        mount_min_w
    ]);

auto_height_raw =
    max([
        Minimum_Height,
        (text_block_height + 2*Padding_Y) / max([0.1, safe_factor[1]]),
        mount_min_h
    ]);

pre_w = Auto_Size_Plate ? auto_width_raw : Manual_Width;
pre_h = Auto_Size_Plate ? auto_height_raw : Manual_Height;

square_side = max([pre_w, pre_h]);

plate_w =
    Plate_Shape == "Square" || Plate_Shape == "Circle"
    ? square_side
    : pre_w;

plate_h =
    Plate_Shape == "Square" || Plate_Shape == "Circle"
    ? square_side
    : pre_h;

usable_text_w =
    max([0.1, (plate_w - 2*Padding_X) * safe_factor[0]]);

usable_text_h =
    max([0.1, (plate_h - 2*Padding_Y) * safe_factor[1]]);

auto_fit_scale =
    Scale_Text_Down_To_Fit
    ? min([
        1,
        usable_text_w / max([0.01, text_block_width]),
        usable_text_h / max([0.01, text_block_height])
      ])
    : 1;

final_text_scale = auto_fit_scale * Text_Global_Scale;


/* ---------------------------------------------------------------------------
   VALIDATION + DIAGNOSTICS
--------------------------------------------------------------------------- */

module validate_parameters() {
    assert(plate_w > 0 && plate_h > 0, "Plate dimensions must be positive.");
    assert(Plate_Thickness > 0, "Plate_Thickness must be > 0.");
    assert(Corner_Radius >= 0, "Corner_Radius cannot be negative.");
    assert(Bevel_Size >= 0, "Bevel_Size cannot be negative.");
    assert(final_text_scale > 0, "Text scale must be > 0.");

    if (Text_Mode == "Engraved")
        assert(Text_Engrave_Depth <= Plate_Thickness + EPS,
               "Text_Engrave_Depth is larger than Plate_Thickness.");

    if (Text_Mode == "Inlay") {
        assert(Inlay_Depth <= Plate_Thickness + EPS,
               "Inlay_Depth is larger than Plate_Thickness.");
        assert(Inlay_Depth > Inlay_Z_Clearance,
               "Inlay_Z_Clearance must be smaller than Inlay_Depth.");
    }

    if (Border_Style == "Engraved")
        assert(Border_Engrave_Depth <= Plate_Thickness + EPS,
               "Border_Engrave_Depth is larger than Plate_Thickness.");

    if (Mounting_Style == "Magnet Pair" || Mounting_Style == "Magnet Quad")
        assert(Magnet_Depth < Plate_Thickness,
               "Magnet_Depth must be smaller than Plate_Thickness.");

    if (Mounting_Style == "Keyhole Pair")
        assert(Keyhole_Depth < Plate_Thickness,
               "Keyhole_Depth must be smaller than Plate_Thickness.");

    if (Construction == "Desk Slot Stand")
        assert(Slot_Depth < Base_Thickness,
               "Slot_Depth must be smaller than Base_Thickness.");

    children();
}

echo("=== Universal Sign Generator / Nightly ===");
echo("OpenSCAD version", version());
echo("Use_Nightly_Metrics", Use_Nightly_Metrics);
echo("Plate shape", Plate_Shape);
echo("Construction", Construction);
echo("Plate size", [plate_w, plate_h, Plate_Thickness]);
echo("Text block raw", [text_block_width, text_block_height]);
echo("Final text scale", final_text_scale);
echo("Mounting", Mounting_Style);

if (!Use_Nightly_Metrics)
    echo("WARNING: Nightly metrics disabled: text auto-sizing is approximate.");

if (final_text_scale < 0.65)
    echo("WARNING: Text has been scaled below 65%. Consider a larger sign or smaller text.");

if (Text_Mode == "Raised" && Construction == "Foldable Sheet Blank")
    echo("NOTE: Foldable Sheet Blank is primarily intended for 2D cut/engrave workflows.");


/* ---------------------------------------------------------------------------
   2D SHAPES
--------------------------------------------------------------------------- */

module rounded_rect_2d(w, h, r) {
    rr = min([max([0, r]), w/2, h/2]);

    if (rr <= EPS)
        square([w, h], center=true);
    else
        offset(r=rr, $fn=Curve_FN)
            square([max([EPS, w-2*rr]), max([EPS, h-2*rr])], center=true);
}

module capsule_2d(w, h) {
    if (w >= h) {
        r = h/2;
        hull() {
            translate([-(w-h)/2, 0]) circle(r=r, $fn=Curve_FN);
            translate([ +(w-h)/2, 0]) circle(r=r, $fn=Curve_FN);
        }
    } else {
        r = w/2;
        hull() {
            translate([0, -(h-w)/2]) circle(r=r, $fn=Curve_FN);
            translate([0, +(h-w)/2]) circle(r=r, $fn=Curve_FN);
        }
    }
}

module ellipse_2d(w, h) {
    scale([w/2, h/2])
        circle(r=1, $fn=Curve_FN);
}

module regular_polygon_2d(w, h, n, rot=90) {
    polygon(points=[
        for (i=[0:n-1])
            [w/2*cos(rot + i*360/n), h/2*sin(rot + i*360/n)]
    ]);
}

module arch_2d(w, h) {
    r = min([w/2, h * Arch_Radius_Fraction]);
    cy = h/2 - r;

    pts = concat(
        [[-w/2, -h/2], [w/2, -h/2], [w/2, cy]],
        [for (i=[0:Arch_Segments])
            let(a = i * 180 / Arch_Segments)
            [r*cos(a), cy + r*sin(a)]
        ]
    );

    polygon(points=pts);
}

module shield_2d(w, h) {
    polygon(points=[
        [-w/2,  h*0.34],
        [-w*0.34, h/2],
        [ w*0.34, h/2],
        [ w/2,  h*0.34],
        [ w*0.43, -h*0.18],
        [ 0, -h/2],
        [-w*0.43, -h*0.18]
    ]);
}

module tag_2d(w, h) {
    c = min([Tag_Cut, w/3, h/2]);
    polygon(points=[
        [-w/2+c, -h/2],
        [ w/2-c, -h/2],
        [ w/2,   -h/2+c],
        [ w/2,    h/2-c],
        [ w/2-c,  h/2],
        [-w/2+c,  h/2],
        [-w/2,    h/2-c],
        [-w/2,   -h/2+c]
    ]);
}

module arrow_right_2d(w, h) {
    ah = w * Arrow_Head_Fraction;
    polygon(points=[
        [-w/2, -h/2],
        [ w/2-ah, -h/2],
        [ w/2-ah, -h/2],
        [ w/2, 0],
        [ w/2-ah, h/2],
        [-w/2, h/2]
    ]);
}

module pennant_2d(w, h) {
    polygon(points=[
        [-w/2, -h/2],
        [ w*0.20, -h/2],
        [ w/2, 0],
        [ w*0.20, h/2],
        [-w/2, h/2]
    ]);
}

module face_outline_2d() {
    if (Plate_Shape == "Rectangle")
        square([plate_w, plate_h], center=true);

    else if (Plate_Shape == "Square")
        square([plate_w, plate_h], center=true);

    else if (Plate_Shape == "Rounded Rectangle")
        rounded_rect_2d(plate_w, plate_h, Corner_Radius);

    else if (Plate_Shape == "Capsule")
        capsule_2d(plate_w, plate_h);

    else if (Plate_Shape == "Circle")
        circle(d=plate_w, $fn=Curve_FN);

    else if (Plate_Shape == "Oval")
        ellipse_2d(plate_w, plate_h);

    else if (Plate_Shape == "Triangle")
        polygon(points=[
            [-plate_w/2, -plate_h/2],
            [ plate_w/2, -plate_h/2],
            [0, plate_h/2]
        ]);

    else if (Plate_Shape == "Diamond")
        polygon(points=[
            [0, plate_h/2],
            [plate_w/2, 0],
            [0, -plate_h/2],
            [-plate_w/2, 0]
        ]);

    else if (Plate_Shape == "Hexagon")
        regular_polygon_2d(plate_w, plate_h, 6, 0);

    else if (Plate_Shape == "Octagon")
        regular_polygon_2d(plate_w, plate_h, 8, 22.5);

    else if (Plate_Shape == "Shield")
        shield_2d(plate_w, plate_h);

    else if (Plate_Shape == "Arch")
        arch_2d(plate_w, plate_h);

    else if (Plate_Shape == "Tag")
        tag_2d(plate_w, plate_h);

    else if (Plate_Shape == "Arrow Right")
        arrow_right_2d(plate_w, plate_h);

    else if (Plate_Shape == "Pennant")
        pennant_2d(plate_w, plate_h);

    else
        rounded_rect_2d(plate_w, plate_h, Corner_Radius);
}

module inset_outline_2d(d) {
    offset(delta=-d, $fn=Curve_FN)
        face_outline_2d();
}


/* ---------------------------------------------------------------------------
   TEXT GEOMETRY
--------------------------------------------------------------------------- */

module one_line_text_2d(l) {
    if (Font_Sizing_Mode == "em")
        text(
            text=l[0],
            em=l[1],
            font=l[2],
            direction=Text_Direction,
            language=Text_Language,
            script=Text_Script,
            halign=Text_HAlign,
            valign="center",
            spacing=l[3],
            $fn=Text_FN
        );
    else
        text(
            text=l[0],
            size=l[1],
            font=l[2],
            direction=Text_Direction,
            language=Text_Language,
            script=Text_Script,
            halign=Text_HAlign,
            valign="center",
            spacing=l[3],
            $fn=Text_FN
        );
}

module text_block_2d() {
    translate([Text_Offset_X, Text_Offset_Y])
        scale([final_text_scale, final_text_scale])
            if (len(active_lines) > 0)
                for (i=[0:len(active_lines)-1]) {
                    l = active_lines[i];

                    translate([
                        text_anchor_x() + l[4],
                        line_center_y(i) + l[5]
                    ])
                        one_line_text_2d(l);
                }
}

module text_recess_shape_2d() {
    if (Text_Mode == "Inlay")
        offset(delta=Inlay_XY_Clearance, $fn=Curve_FN)
            text_block_2d();
    else
        text_block_2d();
}


/* ---------------------------------------------------------------------------
   BORDER
--------------------------------------------------------------------------- */

module border_ring_2d() {
    if (Border_Width > EPS)
        difference() {
            inset_outline_2d(Border_Inset);
            inset_outline_2d(Border_Inset + Border_Width);
        }
}


/* ---------------------------------------------------------------------------
   MOUNTING - 2D CUT SHAPES
--------------------------------------------------------------------------- */

function x_edge_pos() = max([0, plate_w/2 - Mount_Edge]);
function y_edge_pos() = max([0, plate_h/2 - Mount_Edge]);

module round_hole_2d(x, y, d=Hole_Diameter) {
    translate([x,y])
        circle(d=d, $fn=Curve_FN);
}

module slot_2d(x, y, length, width, vertical=true) {
    translate([x,y])
        hull() {
            if (vertical) {
                translate([0, -(length-width)/2]) circle(d=width, $fn=Curve_FN);
                translate([0, +(length-width)/2]) circle(d=width, $fn=Curve_FN);
            } else {
                translate([-(length-width)/2, 0]) circle(d=width, $fn=Curve_FN);
                translate([+(length-width)/2, 0]) circle(d=width, $fn=Curve_FN);
            }
        }
}

module through_mounts_2d() {
    xe = x_edge_pos();
    ye = y_edge_pos();

    if (Mounting_Style == "2 Hanging Holes") {
        round_hole_2d(-xe, ye);
        round_hole_2d( xe, ye);
    }

    else if (Mounting_Style == "2 Side Holes") {
        round_hole_2d(-xe, 0);
        round_hole_2d( xe, 0);
    }

    else if (Mounting_Style == "4 Corner Holes" ||
             Mounting_Style == "4 Countersunk") {
        for (x=[-xe,xe], y=[-ye,ye])
            round_hole_2d(x,y);
    }

    else if (Mounting_Style == "2 Countersunk") {
        round_hole_2d(-xe, ye);
        round_hole_2d( xe, ye);
    }

    else if (Mounting_Style == "Lanyard Hole") {
        round_hole_2d(0, ye);
    }

    else if (Mounting_Style == "Zip-tie Slots") {
        slot_2d(-xe, 0, Zip_Slot_Length, Zip_Slot_Width, true);
        slot_2d( xe, 0, Zip_Slot_Length, Zip_Slot_Width, true);
    }
}

module keyhole_2d() {
    // Stort indføringshul nederst, smal kanal opad.
    union() {
        translate([0, -Keyhole_Length/2 + Keyhole_Head_Diameter/2])
            circle(d=Keyhole_Head_Diameter, $fn=Curve_FN);

        translate([0, Keyhole_Length/4])
            square([Keyhole_Neck_Width, Keyhole_Length], center=true);
    }
}


/* ---------------------------------------------------------------------------
   3D BASE PLATE
--------------------------------------------------------------------------- */

module plate_solid_3d() {
    b = min([
        max([0, Bevel_Size]),
        max([0, Plate_Thickness/2 - EPS])
    ]);

    if (Edge_Profile == "Straight" || b <= EPS) {
        linear_extrude(height=Plate_Thickness)
            face_outline_2d();
    } else {
        // Chamfer begge sider uden Minkowski: hurtigere og robust på mange former.
        union() {
            hull() {
                translate([0,0,0])
                    linear_extrude(height=EPS)
                        inset_outline_2d(b);

                translate([0,0,b])
                    linear_extrude(height=EPS)
                        face_outline_2d();
            }

            if (Plate_Thickness > 2*b)
                translate([0,0,b])
                    linear_extrude(height=Plate_Thickness-2*b)
                        face_outline_2d();

            hull() {
                translate([0,0,Plate_Thickness-b])
                    linear_extrude(height=EPS)
                        face_outline_2d();

                translate([0,0,Plate_Thickness-EPS])
                    linear_extrude(height=EPS)
                        inset_outline_2d(b);
            }
        }
    }
}

module through_mounts_3d() {
    translate([0,0,-EPS])
        linear_extrude(height=Plate_Thickness + 2*EPS)
            through_mounts_2d();
}

module countersinks_3d() {
    xe = x_edge_pos();
    ye = y_edge_pos();

    positions =
        Mounting_Style == "2 Countersunk"
        ? [[-xe,ye],[xe,ye]]
        : Mounting_Style == "4 Countersunk"
          ? [[-xe,-ye],[-xe,ye],[xe,-ye],[xe,ye]]
          : [];

    if (len(positions) > 0)
        for (p = positions)
            translate([p[0], p[1], Plate_Thickness-Countersink_Depth])
                cylinder(
                    h=Countersink_Depth + EPS,
                    d1=Hole_Diameter,
                    d2=Countersink_Diameter,
                    $fn=Curve_FN
                );
}

module backside_mount_recesses_3d() {
    xe = x_edge_pos();
    ye = y_edge_pos();

    if (Mounting_Style == "Magnet Pair") {
        mx = min([Magnet_Spacing/2, xe]);

        for (x=[-mx,mx])
            translate([x,0,-EPS])
                cylinder(h=Magnet_Depth+EPS, d=Magnet_Diameter, $fn=Curve_FN);
    }

    else if (Mounting_Style == "Magnet Quad") {
        for (x=[-xe,xe], y=[-ye,ye])
            translate([x,y,-EPS])
                cylinder(h=Magnet_Depth+EPS, d=Magnet_Diameter, $fn=Curve_FN);
    }

    else if (Mounting_Style == "Keyhole Pair") {
        for (x=[-xe,xe])
            translate([x, ye - Keyhole_Length/2, -EPS])
                linear_extrude(height=Keyhole_Depth+EPS)
                    keyhole_2d();
    }
}


/* ---------------------------------------------------------------------------
   FACE: BASE + SUBTRACTIONS + RELIEF
--------------------------------------------------------------------------- */

module face_core_3d() {
    difference() {
        plate_solid_3d();

        // Gennemgående monteringshuller / slots
        through_mounts_3d();

        // Forsænkning på forsiden
        countersinks_3d();

        // Magneter / keyholes fra bagsiden
        backside_mount_recesses_3d();

        // Tekst
        if (Text_Mode == "Engraved")
            translate([0,0,Plate_Thickness-Text_Engrave_Depth])
                linear_extrude(height=Text_Engrave_Depth+EPS)
                    text_block_2d();

        else if (Text_Mode == "Cut-through")
            translate([0,0,-EPS])
                linear_extrude(height=Plate_Thickness+2*EPS)
                    text_block_2d();

        else if (Text_Mode == "Inlay")
            translate([0,0,Plate_Thickness-Inlay_Depth])
                linear_extrude(height=Inlay_Depth+EPS)
                    text_recess_shape_2d();

        // Border
        if (Border_Style == "Engraved")
            translate([0,0,Plate_Thickness-Border_Engrave_Depth])
                linear_extrude(height=Border_Engrave_Depth+EPS)
                    border_ring_2d();

        else if (Border_Style == "Cut-through")
            translate([0,0,-EPS])
                linear_extrude(height=Plate_Thickness+2*EPS)
                    border_ring_2d();
    }
}

module face_relief_3d() {
    if (Text_Mode == "Raised")
        translate([0,0,Plate_Thickness-EPS])
            linear_extrude(height=Text_Raised_Height+EPS)
                text_block_2d();

    if (Border_Style == "Raised")
        translate([0,0,Plate_Thickness-EPS])
            linear_extrude(height=Border_Raised_Height+EPS)
                border_ring_2d();
}

module sign_face_3d() {
    union() {
        face_core_3d();
        face_relief_3d();
    }
}

module inlay_insert_3d(on_face=false) {
    insert_h = max([EPS, Inlay_Depth-Inlay_Z_Clearance]);

    z0 =
        on_face
        ? Plate_Thickness-Inlay_Depth+Inlay_Z_Clearance
        : 0;

    translate([0,0,z0])
        linear_extrude(height=insert_h)
            text_block_2d();
}


/* ---------------------------------------------------------------------------
   DESK / SUPPORT GEOMETRY
--------------------------------------------------------------------------- */

module desk_base_3d(with_slot=false) {
bw = plate_w + Base_Width_Extra;

    difference() {
        translate([0, (Base_Depth-Base_Front_Lip)/2, Base_Thickness/2])
            cube([bw, Base_Depth+Base_Front_Lip, Base_Thickness], center=true);

        if (with_slot)
            translate([
                0,
                0,
                Base_Thickness - Slot_Depth/2 + EPS
            ])
                cube([
                    plate_w + 2*Slot_Clearance,
                    Plate_Thickness + 2*Slot_Clearance,
                    Slot_Depth + 2*EPS
                ], center=true);
    }
}

// Sign_face er modelleret i XY. Denne transform drejer bundkanten ned på bordet.
module posed_face(angle=90, y0=0, z0=0) {
    translate([0,y0,z0])
        rotate([angle,0,0])
            translate([0,plate_h/2,0])
                children();
}

// Ekstrudér en polygon i YZ langs X.
module prism_x(width, yz_points) {
    rotate([0,90,0])
        linear_extrude(height=width, center=true, convexity=10)
            polygon(points=[
                for (p=yz_points) [-p[1], p[0]]
            ]);
}

module l_stand_support_3d() {
    desk_base_3d(false);
}

module desk_l_stand_3d(include_face=true, include_support=true) {
    if (include_support)
        l_stand_support_3d();

    if (include_face)
        posed_face(90, 0, Base_Thickness-Base_Embed)
            sign_face_3d();
}

module wedge_support_3d() {
    support_w = plate_w * Wedge_Width_Fraction;
    rise_len = plate_h * Wedge_Height_Fraction;
    tip_y = rise_len * cos(Desk_Angle);
    tip_z = Base_Thickness + rise_len * sin(Desk_Angle) - Base_Embed;

    desk_base_3d(false);

    prism_x(
        support_w,
        [
            [0, Base_Thickness-EPS],
            [Wedge_Depth, Base_Thickness-EPS],
            [tip_y, tip_z]
        ]
    );
}

module desk_wedge_3d(include_face=true, include_support=true) {
    if (include_support)
        wedge_support_3d();

    if (include_face)
        posed_face(Desk_Angle, 0, Base_Thickness-Base_Embed)
            sign_face_3d();
}

module slot_support_3d() {
    desk_base_3d(true);
}

module desk_slot_stand_3d(include_face=true, include_support=true) {
    if (include_support)
        slot_support_3d();

    if (include_face)
        posed_face(
            90,
            0,
            Base_Thickness-Slot_Depth
        )
            sign_face_3d();
}

module tent_face_pair_3d() {
    a = Tent_Angle;
    half_spread = plate_h * cos(a);
    top_z = plate_h * sin(a);

    // Forside
    posed_face(a, -half_spread, 0)
        sign_face_3d();

    // Bagside: spejling over Y giver læsbar tekst fra modsatte side.
    mirror([0,1,0])
        posed_face(a, -half_spread, 0)
            sign_face_3d();

    if (Tent_Top_Bar)
        translate([0,0,top_z])
            rotate([0,90,0])
                cylinder(
                    h=plate_w,
                    d=Tent_Top_Bar_Diameter,
                    center=true,
                    $fn=Curve_FN
                );
}


/* ---------------------------------------------------------------------------
   FOLDABLE SHEET BLANK
--------------------------------------------------------------------------- */

fold_blank_h = 2*plate_h + Fold_Hinge_Band;

module fold_blank_outline_2d() {
    rounded_rect_2d(
        plate_w,
        fold_blank_h,
        min([Fold_Corner_Radius, plate_w/2, fold_blank_h/2])
    );
}

module fold_score_2d() {
    // To fold-linjer skaber en lille hinge-band. Ved band=0 bliver de samme linje.
    y1 = -Fold_Hinge_Band/2;
    y2 =  Fold_Hinge_Band/2;

    translate([0,y1])
        square([plate_w-2*Fold_Corner_Radius, Fold_Score_Width], center=true);

    if (Fold_Hinge_Band > EPS)
        translate([0,y2])
            square([plate_w-2*Fold_Corner_Radius, Fold_Score_Width], center=true);
}

module fold_text_2d() {
    panel_offset = (plate_h + Fold_Hinge_Band)/2;

    translate([0, panel_offset])
        text_block_2d();

    if (Fold_Text_On_Both_Panels)
        translate([0,-panel_offset])
            rotate(180)
                text_block_2d();
}

module fold_blank_3d() {
    linear_extrude(height=Fold_Sheet_Thickness)
        difference() {
            fold_blank_outline_2d();

            if (Text_Mode == "Cut-through")
                fold_text_2d();
        }
}


/* ---------------------------------------------------------------------------
   STAKE SIGN
--------------------------------------------------------------------------- */

module stake_2d() {
    y_top = -plate_h/2 + EPS;
    y_shoulder = -plate_h/2 - (Stake_Length-Stake_Tip_Length);
    y_tip = -plate_h/2 - Stake_Length;

    polygon(points=[
        [-Stake_Width/2, y_top],
        [ Stake_Width/2, y_top],
        [ Stake_Width/2, y_shoulder],
        [0, y_tip],
        [-Stake_Width/2, y_shoulder]
    ]);
}

module stake_body_3d() {
    union() {
        sign_face_3d();

        linear_extrude(height=Plate_Thickness)
            stake_2d();
    }
}


/* ---------------------------------------------------------------------------
   2D OUTPUTS
--------------------------------------------------------------------------- */

module face_cut_outline_2d() {
    difference() {
        face_outline_2d();

        // Kun features der faktisk går igennem pladen.
        through_mounts_2d();

        if (Text_Mode == "Cut-through")
            text_block_2d();

        if (Border_Style == "Cut-through")
            border_ring_2d();
    }
}

module stake_cut_outline_2d() {
    difference() {
        union() {
            face_outline_2d();
            stake_2d();
        }

        through_mounts_2d();

        if (Text_Mode == "Cut-through")
            text_block_2d();

        if (Border_Style == "Cut-through")
            border_ring_2d();
    }
}

module output_2d_cut() {
    if (Construction == "Foldable Sheet Blank")
        difference() {
            fold_blank_outline_2d();
            if (Text_Mode == "Cut-through")
                fold_text_2d();
        }

    else if (Construction == "Stake Sign")
        stake_cut_outline_2d();

    else
        face_cut_outline_2d();
}

module output_2d_text() {
    if (Construction == "Foldable Sheet Blank")
        fold_text_2d();
    else
        text_block_2d();
}


/* ---------------------------------------------------------------------------
   3D CONSTRUCTION DISPATCH
--------------------------------------------------------------------------- */

module output_3d() {
    want_face =
        Part_Selection == "Assembly" ||
        Part_Selection == "Face only";

    want_support =
        Part_Selection == "Assembly" ||
        Part_Selection == "Support only";

    if (Part_Selection == "Text insert only") {
        inlay_insert_3d(false);
    }

    else if (Construction == "Flat Plate") {
        if (want_face)
            if (Text_Mode == "Inlay" && Part_Selection == "Assembly") {
                sign_face_3d();
                inlay_insert_3d(true);
            } else {
                sign_face_3d();
            }
    }

    else if (Construction == "Desk L-Stand") {
        desk_l_stand_3d(want_face, want_support);
    }

    else if (Construction == "Desk Wedge") {
        desk_wedge_3d(want_face, want_support);
    }

    else if (Construction == "Desk Slot Stand") {
        desk_slot_stand_3d(want_face, want_support);
    }

    else if (Construction == "A-Frame Tent") {
        if (Part_Selection == "Support only") {
            if (Tent_Top_Bar) {
                top_z = plate_h * sin(Tent_Angle);

                translate([0,0,top_z])
                    rotate([0,90,0])
                        cylinder(
                            h=plate_w,
                            d=Tent_Top_Bar_Diameter,
                            center=true,
                            $fn=Curve_FN
                        );
            }
        } else {
            tent_face_pair_3d();
        }
    }

    else if (Construction == "Foldable Sheet Blank") {
        if (want_face)
            fold_blank_3d();
    }

    else if (Construction == "Stake Sign") {
        if (want_face)
            stake_body_3d();
    }

    else {
        sign_face_3d();
    }
}


/* ---------------------------------------------------------------------------
   MAIN
--------------------------------------------------------------------------- */

validate_parameters() {
    if (Output_Mode == "3D")
        output_3d();

    else if (Output_Mode == "2D Cut Outline")
        output_2d_cut();

    else if (Output_Mode == "2D Engrave Text")
        output_2d_text();

    else if (Output_Mode == "2D Text/Inlay")
        output_2d_text();

    else if (Output_Mode == "2D Border")
        border_ring_2d();

    else if (Output_Mode == "2D Fold Score")
        if (Construction == "Foldable Sheet Blank")
            fold_score_2d();

    else
        output_3d();
}