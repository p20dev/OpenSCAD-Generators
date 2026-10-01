/*
===============================================================================
 UNIVERSAL CLOCK DIAL GENERATOR — OpenSCAD Nightly
 Version 1.0 — 2026-09

 Requires a recent OpenSCAD Nightly / development snapshot because text layout
 deliberately uses textmetrics(). No external libraries are required.

 Designed for:
   • 3D printing
   • laser cutting / engraving
   • CNC routing / engraving
   • vinyl / plotter workflows via 2D export

 Recommended workflow:
   1. Select parameters in the Customizer.
   2. Use Output_Mode = "3D" for a printable dial.
   3. Use 2D_CUT / 2D_ENGRAVE / 2D_MARKS / 2D_TEXT for SVG/DXF export.
   4. Use F6 render before final export.

 textmetrics() notes:
   We do not assume text() starts at [0,0], and we do not use string length as
   a width estimate. The helpers below use textmetrics().position and .size to
   center and fit the actual ink bounds of each rendered string.
===============================================================================
*/

/* [Output] */
Output_Mode = "3D"; // [3D,2D_CUT,2D_ENGRAVE,2D_MARKS,2D_TEXT,2D_PREVIEW]
Preview_Colors = true;
Explode_3D = false;
Explode_Distance = 8; // [0:1:40]

/* [Dial shape] */
Dial_Shape = "Round"; // [Round,Oval,Rectangle,RoundedRectangle,Polygon,Star]
Dial_Diameter = 180; // [30:1:500]
Dial_Width = 180; // [30:1:500]
Dial_Height = 180; // [30:1:500]
Corner_Radius = 18; // [0:0.5:100]
Polygon_Sides = 8; // [3:1:24]
Polygon_Rotation = 22.5; // [-180:1:180]
Star_Points = 12; // [3:1:36]
Star_Inner_Ratio = 0.88; // [0.1:0.01:0.99]
Shape_Margin = 0; // [-20:0.5:40]

/* [3D body] */
Dial_Thickness = 3.0; // [0.4:0.1:20]
Back_Recess_Enable = false;
Back_Recess_Diameter = 58; // [5:1:200]
Back_Recess_Depth = 1.2; // [0:0.1:10]
Edge_Bevel_Enable = false;
Edge_Bevel = 0.8; // [0:0.1:5]

/* [Center / movement hole] */
Center_Hole_Enable = true;
Center_Hole_Type = "Round"; // [Round,Square,D_Shaft,None]
Center_Hole_Diameter = 8.2; // [0.5:0.1:30]
Center_Hole_Square = 8.2; // [0.5:0.1:30]
D_Shaft_Flat = 1.8; // [0:0.1:10]
Center_Hole_X = 0; // [-50:0.1:50]
Center_Hole_Y = 0; // [-50:0.1:50]

/* [Outer rings and borders] */
Outer_Rim_Enable = true;
Outer_Rim_Inset = 4; // [0:0.5:40]
Outer_Rim_Width = 1.2; // [0.2:0.1:10]
Outer_Rim_Mode = "Raised"; // [Raised,Engraved,None]
Outer_Rim_Height = 0.7; // [0.1:0.1:5]
Outer_Rim_Depth = 0.5; // [0.1:0.1:5]
Inner_Ring_Enable = true;
Inner_Ring_Radius = 58; // [5:0.5:240]
Inner_Ring_Width = 0.7; // [0.1:0.1:8]
Inner_Ring_Mode = "Engraved"; // [Raised,Engraved,None]

/* [Minute / second track] */
Track_Enable = true;
Track_Count = 60; // [1:1:240]
Track_Radius = 78; // [5:0.5:240]
Track_Major_Every = 5; // [1:1:60]
Track_Major_Style = "Line"; // [Line,Dot,Pill,Triangle,Diamond,None]
Track_Minor_Style = "Line"; // [Line,Dot,Pill,Triangle,Diamond,None]
Track_Major_Length = 6; // [0.5:0.25:30]
Track_Minor_Length = 3; // [0.25:0.25:20]
Track_Major_Width = 1.6; // [0.2:0.1:8]
Track_Minor_Width = 0.7; // [0.1:0.1:5]
Track_Major_Diameter = 3.2; // [0.5:0.1:12]
Track_Minor_Diameter = 1.5; // [0.3:0.1:8]
Track_Rotation = 0; // [-180:1:180]
Track_Mode = "Raised"; // [Raised,Engraved,Through,None]
Track_Height = 0.7; // [0.1:0.1:5]
Track_Depth = 0.5; // [0.1:0.1:5]

/* [Hour markers] */
Hour_Markers_Enable = false;
Hour_Marker_Count = 12; // [1:1:36]
Hour_Marker_Radius = 66; // [5:0.5:240]
Hour_Marker_Style = "Pill"; // [Line,Dot,Pill,Triangle,Diamond,None]
Hour_Marker_Length = 8; // [0.5:0.25:30]
Hour_Marker_Width = 2.4; // [0.2:0.1:12]
Hour_Marker_Diameter = 4; // [0.5:0.1:15]
Hour_Marker_Rotation = 0; // [-180:1:180]
Hour_Marker_Mode = "Raised"; // [Raised,Engraved,Through,None]
Hour_Marker_Height = 0.8; // [0.1:0.1:5]
Hour_Marker_Depth = 0.5; // [0.1:0.1:5]

/* [Hour numerals] */
Numbers_Enable = true;
Number_Set = "Arabic_1_12"; // [Arabic_1_12,Arabic_0_11,Roman,Quarter_Arabic,Quarter_Roman,Words,None]
Number_Radius = 61; // [5:0.5:240]
Number_Font = "Liberation Sans:style=Bold";
Number_Size = 18; // [2:0.5:80]
Number_Max_Width = 22; // [2:0.5:80]
Number_Max_Height = 18; // [2:0.5:80]
Number_Spacing = 1.0; // [0.5:0.05:2]
Number_Orientation = "Upright"; // [Upright,Radial,Tangent]
Number_Rotation = 0; // [-180:1:180]
Number_Mode = "Raised"; // [Raised,Engraved,Through,None]
Number_Height = 0.8; // [0.1:0.1:5]
Number_Depth = 0.5; // [0.1:0.1:5]

/* [Custom text] */
Top_Text_Enable = true;
Top_Text = "MAKERSPACE";
Top_Text_Y = 27; // [-200:0.5:200]
Top_Text_Font = "Liberation Sans:style=Bold";
Top_Text_Size = 8; // [1:0.5:50]
Top_Text_Max_Width = 70; // [5:1:300]
Top_Text_Max_Height = 12; // [2:0.5:100]
Top_Text_Mode = "Engraved"; // [Raised,Engraved,Through,None]

Bottom_Text_Enable = true;
Bottom_Text = "NÆSTVED";
Bottom_Text_Y = -30; // [-200:0.5:200]
Bottom_Text_Font = "Liberation Sans";
Bottom_Text_Size = 6; // [1:0.5:50]
Bottom_Text_Max_Width = 55; // [5:1:300]
Bottom_Text_Max_Height = 10; // [2:0.5:100]
Bottom_Text_Mode = "Engraved"; // [Raised,Engraved,Through,None]

Center_Text_Enable = false;
Center_Text = "QUARTZ";
Center_Text_X = 0; // [-200:0.5:200]
Center_Text_Y = -15; // [-200:0.5:200]
Center_Text_Font = "Liberation Sans";
Center_Text_Size = 5; // [1:0.5:50]
Center_Text_Max_Width = 45; // [5:1:300]
Center_Text_Max_Height = 8; // [2:0.5:100]
Center_Text_Mode = "Engraved"; // [Raised,Engraved,Through,None]

Text_Raised_Height = 0.7; // [0.1:0.1:5]
Text_Engrave_Depth = 0.45; // [0.1:0.1:5]

/* [Subdial 1] */
Subdial1_Enable = false;
Subdial1_X = 0; // [-200:0.5:200]
Subdial1_Y = -35; // [-200:0.5:200]
Subdial1_Radius = 19; // [4:0.5:80]
Subdial1_Count = 60; // [1:1:120]
Subdial1_Major_Every = 5; // [1:1:60]
Subdial1_Label = "SECONDS";
Subdial1_Label_Size = 3.5; // [1:0.25:20]
Subdial1_Center_Hole = 2.2; // [0:0.1:20]

/* [Subdial 2] */
Subdial2_Enable = false;
Subdial2_X = -38; // [-200:0.5:200]
Subdial2_Y = 0; // [-200:0.5:200]
Subdial2_Radius = 17; // [4:0.5:80]
Subdial2_Count = 24; // [1:1:120]
Subdial2_Major_Every = 4; // [1:1:60]
Subdial2_Label = "24 H";
Subdial2_Label_Size = 3.5; // [1:0.25:20]
Subdial2_Center_Hole = 2.2; // [0:0.1:20]

/* [Subdial 3] */
Subdial3_Enable = false;
Subdial3_X = 38; // [-200:0.5:200]
Subdial3_Y = 0; // [-200:0.5:200]
Subdial3_Radius = 17; // [4:0.5:80]
Subdial3_Count = 31; // [1:1:120]
Subdial3_Major_Every = 5; // [1:1:60]
Subdial3_Label = "DATE";
Subdial3_Label_Size = 3.5; // [1:0.25:20]
Subdial3_Center_Hole = 2.2; // [0:0.1:20]

/* [Subdial appearance] */
Subdial_Ring_Width = 0.65; // [0.1:0.05:5]
Subdial_Tick_Width = 0.45; // [0.1:0.05:3]
Subdial_Tick_Length = 2.0; // [0.2:0.1:8]
Subdial_Major_Length = 3.2; // [0.2:0.1:10]
Subdial_Mode = "Engraved"; // [Raised,Engraved,Through,None]
Subdial_Depth = 0.35; // [0.1:0.05:3]
Subdial_Height = 0.5; // [0.1:0.05:3]
Subdial_Font = "Liberation Sans";

/* [Decorative center] */
Center_Ring_Enable = true;
Center_Ring_Radius = 8; // [1:0.5:50]
Center_Ring_Width = 0.8; // [0.1:0.1:6]
Center_Ring_Mode = "Engraved"; // [Raised,Engraved,None]

/* [Mounting / auxiliary holes] */
Aux_Holes_Enable = false;
Aux_Hole_Diameter = 3.2; // [0.5:0.1:20]
Aux_Holes = [[0,75],[0,-75]];

/* [Manufacturing compensation] */
Cut_Kerf_Compensation = 0; // [-1:0.01:1]
Engrave_Expansion = 0; // [-1:0.01:1]
Min_Feature = 0.2; // [0.05:0.05:3]

/* [Quality] */
Curve_Fragments = 128; // [24:8:512]
Text_Fragments = 24; // [8:4:128]
$fn = Curve_Fragments;

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

function clamp(v, lo, hi) = min(max(v, lo), hi);
function safe_div(a,b,fallback=1) = abs(b) < 0.000001 ? fallback : a/b;
function polar(r,a) = [r*sin(a), r*cos(a)];
function is_major(i,every) = every > 0 && i % every == 0;

ROMAN = ["XII","I","II","III","IV","V","VI","VII","VIII","IX","X","XI"];
WORDS = ["TWELVE","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TEN","ELEVEN"];

function hour_label(i) =
    Number_Set == "Arabic_1_12" ? str(i == 0 ? 12 : i) :
    Number_Set == "Arabic_0_11" ? str(i) :
    Number_Set == "Roman" ? ROMAN[i] :
    Number_Set == "Quarter_Arabic" ? (i==0?"12":i==3?"3":i==6?"6":i==9?"9":"") :
    Number_Set == "Quarter_Roman" ? (i==0?"XII":i==3?"III":i==6?"VI":i==9?"IX":"") :
    Number_Set == "Words" ? WORDS[i] : "";

function star_pts(n, ro, ri, rot=0) =
    [for(i=[0:2*n-1])
        let(a = rot + i*180/n, r = (i%2==0 ? ro : ri))
        [r*sin(a), r*cos(a)]];

// Nightly textmetrics(): tight ink-bounds fit scale.
function text_fit_scale(s, nominal_size, font, max_w, max_h, spacing=1) =
    let(m = textmetrics(text=s, size=nominal_size, font=font,
                        halign="left", valign="baseline", spacing=spacing),
        sx = safe_div(max_w, max(m.size.x, 0.0001), 1),
        sy = safe_div(max_h, max(m.size.y, 0.0001), 1))
    min(1, sx, sy);

module tight_text_2d(s, nominal_size=10, font="Liberation Sans",
                     max_w=1000, max_h=1000, spacing=1) {
    if (s != "") {
        m = textmetrics(text=s, size=nominal_size, font=font,
                        halign="left", valign="baseline", spacing=spacing);
        fit = min(1,
                  safe_div(max_w, max(m.size.x,0.0001),1),
                  safe_div(max_h, max(m.size.y,0.0001),1));
        scale([fit,fit])
            translate([-m.position.x - m.size.x/2,
                       -m.position.y - m.size.y/2])
                text(text=s, size=nominal_size, font=font,
                     halign="left", valign="baseline", spacing=spacing,
                     $fn=Text_Fragments);
    }
}

module ring2d(radius, width) {
    w = max(width, Min_Feature);
    difference() {
        circle(r=radius + w/2);
        circle(r=max(0.001, radius - w/2));
    }
}

module rounded_rect_2d(w,h,r) {
    rr = min(max(r,0), min(w,h)/2);
    if (rr <= 0) square([w,h], center=true);
    else offset(r=rr) square([max(0.01,w-2*rr), max(0.01,h-2*rr)], center=true);
}

module raw_dial_shape_2d(delta=0) {
    if (Dial_Shape == "Round")
        circle(r=Dial_Diameter/2 + Shape_Margin + delta);
    else if (Dial_Shape == "Oval")
        scale([(Dial_Width/2 + Shape_Margin + delta),
               (Dial_Height/2 + Shape_Margin + delta)]) circle(r=1);
    else if (Dial_Shape == "Rectangle")
        square([Dial_Width + 2*(Shape_Margin+delta),
                Dial_Height + 2*(Shape_Margin+delta)], center=true);
    else if (Dial_Shape == "RoundedRectangle")
        rounded_rect_2d(Dial_Width + 2*(Shape_Margin+delta),
                        Dial_Height + 2*(Shape_Margin+delta),
                        max(0,Corner_Radius + delta));
    else if (Dial_Shape == "Polygon")
        rotate(Polygon_Rotation)
            circle(r=Dial_Diameter/2 + Shape_Margin + delta, $fn=Polygon_Sides);
    else if (Dial_Shape == "Star")
        polygon(star_pts(Star_Points,
                         Dial_Diameter/2 + Shape_Margin + delta,
                         (Dial_Diameter/2 + Shape_Margin + delta)*Star_Inner_Ratio,
                         Polygon_Rotation));
}

module dial_cut_outline_2d() {
    delta = Cut_Kerf_Compensation/2;
    raw_dial_shape_2d(delta);
}

module center_hole_2d(extra=0) {
    translate([Center_Hole_X,Center_Hole_Y]) {
        if (Center_Hole_Enable && Center_Hole_Type == "Round")
            circle(d=max(0.01,Center_Hole_Diameter + 2*extra));
        else if (Center_Hole_Enable && Center_Hole_Type == "Square")
            square([Center_Hole_Square+2*extra,Center_Hole_Square+2*extra],center=true);
        else if (Center_Hole_Enable && Center_Hole_Type == "D_Shaft") {
            d = Center_Hole_Diameter + 2*extra;
            flat = clamp(D_Shaft_Flat,0,d*0.9);
            intersection() {
                circle(d=d);
                translate([-d/2,-d/2]) square([d-flat,d]);
            }
        }
    }
}

module aux_holes_2d(extra=0) {
    if (Aux_Holes_Enable)
        for(p=Aux_Holes)
            translate(p) circle(d=max(0.01,Aux_Hole_Diameter + 2*extra));
}

module all_through_holes_2d() {
    center_hole_2d(Cut_Kerf_Compensation/2);
    aux_holes_2d(Cut_Kerf_Compensation/2);
    subdial_holes_2d(Cut_Kerf_Compensation/2);
}

// -----------------------------------------------------------------------------
// Marker primitives
// -----------------------------------------------------------------------------

module marker_shape_2d(style="Line", len=5, width=1, diameter=2) {
    w = max(width, Min_Feature);
    d = max(diameter, Min_Feature);
    if (style == "Line")
        square([w,max(len,Min_Feature)],center=true);
    else if (style == "Pill")
        hull() {
            translate([0,-max(0,len-d)/2]) circle(d=d);
            translate([0, max(0,len-d)/2]) circle(d=d);
        }
    else if (style == "Dot")
        circle(d=d);
    else if (style == "Triangle")
        polygon([[0,len/2],[-w,-len/2],[w,-len/2]]);
    else if (style == "Diamond")
        polygon([[0,len/2],[w,0],[0,-len/2],[-w,0]]);
}

module radial_marker_2d(radius, angle, style, len, width, diameter) {
    p = polar(radius,angle);
    translate(p) rotate(-angle) marker_shape_2d(style,len,width,diameter);
}

module track_geometry_2d() {
    if (Track_Enable && Track_Mode != "None")
        for(i=[0:Track_Count-1]) {
            major = is_major(i,Track_Major_Every);
            a = Track_Rotation + i*360/Track_Count;
            style = major ? Track_Major_Style : Track_Minor_Style;
            len = major ? Track_Major_Length : Track_Minor_Length;
            wid = major ? Track_Major_Width : Track_Minor_Width;
            dia = major ? Track_Major_Diameter : Track_Minor_Diameter;
            radial_marker_2d(Track_Radius,a,style,len,wid,dia);
        }
}

module hour_marker_geometry_2d() {
    if (Hour_Markers_Enable && Hour_Marker_Mode != "None")
        for(i=[0:Hour_Marker_Count-1])
            radial_marker_2d(Hour_Marker_Radius,
                             Hour_Marker_Rotation + i*360/Hour_Marker_Count,
                             Hour_Marker_Style,
                             Hour_Marker_Length,
                             Hour_Marker_Width,
                             Hour_Marker_Diameter);
}

// -----------------------------------------------------------------------------
// Numerals / text
// -----------------------------------------------------------------------------

module numeral_at(i) {
    s = hour_label(i);
    if (s != "") {
        a = Number_Rotation + i*30;
        p = polar(Number_Radius,a);
        orient = Number_Orientation == "Radial" ? -a :
                 Number_Orientation == "Tangent" ? -a+90 : 0;
        translate(p)
            rotate(orient)
                tight_text_2d(s, Number_Size, Number_Font,
                              Number_Max_Width, Number_Max_Height,
                              Number_Spacing);
    }
}

module number_geometry_2d() {
    if (Numbers_Enable && Number_Set != "None" && Number_Mode != "None")
        for(i=[0:11]) numeral_at(i);
}

module top_text_2d() {
    if (Top_Text_Enable && Top_Text_Mode != "None")
        translate([0,Top_Text_Y])
            tight_text_2d(Top_Text,Top_Text_Size,Top_Text_Font,
                          Top_Text_Max_Width,Top_Text_Max_Height);
}

module bottom_text_2d() {
    if (Bottom_Text_Enable && Bottom_Text_Mode != "None")
        translate([0,Bottom_Text_Y])
            tight_text_2d(Bottom_Text,Bottom_Text_Size,Bottom_Text_Font,
                          Bottom_Text_Max_Width,Bottom_Text_Max_Height);
}

module center_text_2d() {
    if (Center_Text_Enable && Center_Text_Mode != "None")
        translate([Center_Text_X,Center_Text_Y])
            tight_text_2d(Center_Text,Center_Text_Size,Center_Text_Font,
                          Center_Text_Max_Width,Center_Text_Max_Height);
}

module all_custom_text_2d() {
    top_text_2d();
    bottom_text_2d();
    center_text_2d();
}

// -----------------------------------------------------------------------------
// Rings / subdials
// -----------------------------------------------------------------------------

module outer_rim_2d() {
    // Generalized inset border: offset inward from actual dial outline.
    if (Outer_Rim_Enable && Outer_Rim_Mode != "None")
        difference() {
            offset(delta=-Outer_Rim_Inset + Outer_Rim_Width/2) raw_dial_shape_2d();
            offset(delta=-Outer_Rim_Inset - Outer_Rim_Width/2) raw_dial_shape_2d();
        }
}

module inner_ring_2d() {
    if (Inner_Ring_Enable && Inner_Ring_Mode != "None")
        ring2d(Inner_Ring_Radius,Inner_Ring_Width);
}

module center_ring_2d() {
    if (Center_Ring_Enable && Center_Ring_Mode != "None")
        translate([Center_Hole_X,Center_Hole_Y]) ring2d(Center_Ring_Radius,Center_Ring_Width);
}

module subdial_2d(x,y,r,count,major_every,label,label_size,hole_d) {
    translate([x,y]) {
        ring2d(r,Subdial_Ring_Width);
        for(i=[0:count-1]) {
            major = is_major(i,major_every);
            a = i*360/count;
            rr = r - (major ? Subdial_Major_Length : Subdial_Tick_Length)/2;
            radial_marker_2d(rr,a,"Line",
                             major ? Subdial_Major_Length : Subdial_Tick_Length,
                             Subdial_Tick_Width,Subdial_Tick_Width);
        }
        if (label != "")
            translate([0,-r*0.42])
                tight_text_2d(label,label_size,Subdial_Font,r*1.35,label_size*1.35);
    }
}

module subdial_holes_2d(extra=0) {
    if (Subdial1_Enable && Subdial1_Center_Hole > 0)
        translate([Subdial1_X,Subdial1_Y]) circle(d=Subdial1_Center_Hole+2*extra);
    if (Subdial2_Enable && Subdial2_Center_Hole > 0)
        translate([Subdial2_X,Subdial2_Y]) circle(d=Subdial2_Center_Hole+2*extra);
    if (Subdial3_Enable && Subdial3_Center_Hole > 0)
        translate([Subdial3_X,Subdial3_Y]) circle(d=Subdial3_Center_Hole+2*extra);
}

module subdial_geometry_2d() {
    if (Subdial_Mode != "None") {
        if (Subdial1_Enable) subdial_2d(Subdial1_X,Subdial1_Y,Subdial1_Radius,Subdial1_Count,Subdial1_Major_Every,Subdial1_Label,Subdial1_Label_Size,Subdial1_Center_Hole);
        if (Subdial2_Enable) subdial_2d(Subdial2_X,Subdial2_Y,Subdial2_Radius,Subdial2_Count,Subdial2_Major_Every,Subdial2_Label,Subdial2_Label_Size,Subdial2_Center_Hole);
        if (Subdial3_Enable) subdial_2d(Subdial3_X,Subdial3_Y,Subdial3_Radius,Subdial3_Count,Subdial3_Major_Every,Subdial3_Label,Subdial3_Label_Size,Subdial3_Center_Hole);
    }
}

// -----------------------------------------------------------------------------
// Group by manufacturing treatment
// -----------------------------------------------------------------------------

module raised_geometry_2d() {
    if (Track_Mode == "Raised") track_geometry_2d();
    if (Hour_Marker_Mode == "Raised") hour_marker_geometry_2d();
    if (Number_Mode == "Raised") number_geometry_2d();
    if (Outer_Rim_Mode == "Raised") outer_rim_2d();
    if (Inner_Ring_Mode == "Raised") inner_ring_2d();
    if (Center_Ring_Mode == "Raised") center_ring_2d();
    if (Subdial_Mode == "Raised") subdial_geometry_2d();
    if (Top_Text_Mode == "Raised") top_text_2d();
    if (Bottom_Text_Mode == "Raised") bottom_text_2d();
    if (Center_Text_Mode == "Raised") center_text_2d();
}

module engraved_geometry_2d() {
    if (Track_Mode == "Engraved") track_geometry_2d();
    if (Hour_Marker_Mode == "Engraved") hour_marker_geometry_2d();
    if (Number_Mode == "Engraved") number_geometry_2d();
    if (Outer_Rim_Mode == "Engraved") outer_rim_2d();
    if (Inner_Ring_Mode == "Engraved") inner_ring_2d();
    if (Center_Ring_Mode == "Engraved") center_ring_2d();
    if (Subdial_Mode == "Engraved") subdial_geometry_2d();
    if (Top_Text_Mode == "Engraved") top_text_2d();
    if (Bottom_Text_Mode == "Engraved") bottom_text_2d();
    if (Center_Text_Mode == "Engraved") center_text_2d();
}

module through_decoration_2d() {
    if (Track_Mode == "Through") track_geometry_2d();
    if (Hour_Marker_Mode == "Through") hour_marker_geometry_2d();
    if (Number_Mode == "Through") number_geometry_2d();
    if (Subdial_Mode == "Through") subdial_geometry_2d();
    if (Top_Text_Mode == "Through") top_text_2d();
    if (Bottom_Text_Mode == "Through") bottom_text_2d();
    if (Center_Text_Mode == "Through") center_text_2d();
}

module all_cutouts_2d() {
    all_through_holes_2d();
    through_decoration_2d();
}

module all_marks_2d() {
    track_geometry_2d();
    hour_marker_geometry_2d();
    outer_rim_2d();
    inner_ring_2d();
    center_ring_2d();
    subdial_geometry_2d();
}

module all_text_2d() {
    number_geometry_2d();
    all_custom_text_2d();
}

// -----------------------------------------------------------------------------
// 3D construction
// -----------------------------------------------------------------------------

module raw_body_3d() {
    b = min(max(Edge_Bevel,0), Dial_Thickness/2);
    if (Edge_Bevel_Enable && b > 0.01) {
        // True geometric top/bottom bevel using hulls between an inset profile
        // and the full profile; works for all supported dial outlines.
        hull() {
            linear_extrude(height=0.01) offset(delta=-b) raw_dial_shape_2d();
            translate([0,0,b]) linear_extrude(height=0.01) raw_dial_shape_2d();
        }
        translate([0,0,b])
            linear_extrude(height=max(0.01,Dial_Thickness-2*b)) raw_dial_shape_2d();
        hull() {
            translate([0,0,Dial_Thickness-b-0.01])
                linear_extrude(height=0.01) raw_dial_shape_2d();
            translate([0,0,Dial_Thickness-0.01])
                linear_extrude(height=0.01) offset(delta=-b) raw_dial_shape_2d();
        }
    } else
        linear_extrude(height=Dial_Thickness) raw_dial_shape_2d();
}

module base_body_3d() {
    difference() {
        raw_body_3d();

        // Through holes and through-decoration get a small Z overcut.
        translate([0,0,-0.2])
            linear_extrude(height=Dial_Thickness+0.4)
                all_cutouts_2d();

        if (Back_Recess_Enable && Back_Recess_Depth > 0)
            translate([Center_Hole_X,Center_Hole_Y,-0.01])
                cylinder(d=Back_Recess_Diameter,
                         h=min(Back_Recess_Depth,Dial_Thickness-0.05));

        // Engraving cut from front face.
        translate([0,0,max(0,Dial_Thickness-max(Track_Depth,Hour_Marker_Depth,Number_Depth,Outer_Rim_Depth,Subdial_Depth,Text_Engrave_Depth)-0.01)])
            linear_extrude(height=max(Track_Depth,Hour_Marker_Depth,Number_Depth,Outer_Rim_Depth,Subdial_Depth,Text_Engrave_Depth)+0.02)
                engraved_geometry_2d();
    }
}

module raised_features_3d() {
    // Features share one user-visible top height policy: each category may
    // request its own height, so they are extruded separately.
    z0 = Dial_Thickness + (Explode_3D ? Explode_Distance : 0);

    if (Track_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Track_Height) track_geometry_2d();
    if (Hour_Marker_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Hour_Marker_Height) hour_marker_geometry_2d();
    if (Number_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Number_Height) number_geometry_2d();
    if (Outer_Rim_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Outer_Rim_Height) outer_rim_2d();
    if (Inner_Ring_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Outer_Rim_Height) inner_ring_2d();
    if (Center_Ring_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Outer_Rim_Height) center_ring_2d();
    if (Subdial_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Subdial_Height) subdial_geometry_2d();
    if (Top_Text_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Text_Raised_Height) top_text_2d();
    if (Bottom_Text_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Text_Raised_Height) bottom_text_2d();
    if (Center_Text_Mode == "Raised")
        translate([0,0,z0]) linear_extrude(height=Text_Raised_Height) center_text_2d();
}

module clock_dial_3d() {
    if (Preview_Colors) {
        color([0.82,0.82,0.82]) base_body_3d();
        color([0.12,0.12,0.12]) raised_features_3d();
    } else {
        base_body_3d();
        raised_features_3d();
    }
}

// -----------------------------------------------------------------------------
// 2D export views
// -----------------------------------------------------------------------------

module export_2d_cut() {
    difference() {
        dial_cut_outline_2d();
        all_cutouts_2d();
    }
}

module export_2d_engrave() {
    if (Engrave_Expansion == 0)
        engraved_geometry_2d();
    else
        offset(delta=Engrave_Expansion) engraved_geometry_2d();
}

module export_2d_marks() { all_marks_2d(); }
module export_2d_text() { all_text_2d(); }

module export_2d_preview() {
    color([0.85,0.85,0.85]) export_2d_cut();
    color([0.15,0.15,0.15]) export_2d_engrave();
    color([0.05,0.25,0.75]) raised_geometry_2d();
}

// -----------------------------------------------------------------------------
// Diagnostics
// -----------------------------------------------------------------------------

echo("Universal Clock Dial Generator — Nightly textmetrics edition");
echo("Output",Output_Mode,"Shape",Dial_Shape);
echo("Center hole",Center_Hole_Enable,Center_Hole_Type,Center_Hole_Diameter);
if (Numbers_Enable && Number_Set != "None") {
    _m12 = textmetrics(text=hour_label(0), size=Number_Size, font=Number_Font,
                       halign="left",valign="baseline",spacing=Number_Spacing);
    echo("12-label textmetrics position",_m12.position,"size",_m12.size,"advance",_m12.advance);
}

// -----------------------------------------------------------------------------
// Main
// -----------------------------------------------------------------------------

if (Output_Mode == "3D")
    clock_dial_3d();
else if (Output_Mode == "2D_CUT")
    export_2d_cut();
else if (Output_Mode == "2D_ENGRAVE")
    export_2d_engrave();
else if (Output_Mode == "2D_MARKS")
    export_2d_marks();
else if (Output_Mode == "2D_TEXT")
    export_2d_text();
else if (Output_Mode == "2D_PREVIEW")
    export_2d_preview();