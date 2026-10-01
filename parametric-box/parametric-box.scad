/*
===============================================================================
 PARAMETRIC BOX GENERATOR v1.0
 Target: OpenSCAD Nightly (kept dependency-free and largely 2021.01 compatible)
 Purpose: Advanced configurable boxes/enclosures for FDM 3D printing.

 Design goals:
 - Clear distinction between internal and external dimensions
 - Independent fit tolerances for lids, sliders, hinges and magnets
 - Multiple lid systems
 - Rounded or chamfered corners
 - Dividers, finger notches, floor patterns, ribs, feet, labels, magnets
 - Print/export layouts and assembled previews
 - Sensible minimum guards and diagnostics
===============================================================================
*/

/* [01 - Output / visning] */
Output = "Both - print layout"; // [Box only,Lid only,Both - print layout,Assembled preview,Exploded preview]
Show_Diagnostics = true;
Preview_Quality = 48; // [12:4:128]
Render_Quality = 96;  // [24:8:256]
Print_Gap = 12;       // [2:1:50]
Explode_Distance = 18; // [5:1:80]

/* [02 - Grundmål] */
Dimension_Mode = "Inside"; // [Inside,Outside]
Box_Width = 100;      // [10:1:400]
Box_Depth = 70;       // [10:1:400]
Box_Height = 40;      // [5:1:250]
Wall_Thickness = 2.4; // [0.8:0.1:10]
Bottom_Thickness = 2.4; // [0.8:0.1:12]

/* [03 - Hjørner og vægge] */
Corner_Style = "Rounded"; // [Rounded,Chamfered,Square]
Corner_Radius = 7;        // [0:0.5:50]
Chamfer_Size = 5;         // [0:0.5:30]
Top_Rim_Thickness = 0;    // [0:0.2:5]
Top_Rim_Height = 0;       // [0:0.2:8]
Outer_Ribs = false;
Rib_Width = 2.0;          // [0.8:0.2:8]
Rib_Depth = 0.8;          // [0.2:0.1:4]
Rib_Spacing = 15;         // [5:1:50]

/* [04 - Bund] */
Floor_Style = "Solid"; // [Solid,Round holes,Hex-ish holes,Slots]
Floor_Hole_Size = 5;   // [1:0.5:20]
Floor_Hole_Spacing = 9;// [3:0.5:30]
Floor_Edge_Margin = 4; // [1:0.5:20]
Feet = "None";        // [None,Four pads,Full perimeter]
Foot_Height = 1.2;     // [0.4:0.2:5]
Foot_Size = 8;         // [3:1:25]

/* [05 - Lågtype] */
Lid_Type = "Inner lip"; // [None,Inner lip,Outer cap,Sliding,Hinged]
Lid_Thickness = 2.4;     // [0.8:0.1:10]
Lid_Clearance = 0.25;    // [0:0.05:1.5]
Lid_Overhang = 0.8;      // [0:0.2:8]
Lip_Height = 5;          // [1:0.5:20]
Lip_Thickness = 1.6;     // [0.8:0.1:5]
Lid_Corner_Radius_Adjust = 0; // [-5:0.5:10]

/* [06 - Skydelåg] */
Slide_Direction = "Width"; // [Width,Depth]
Slide_Clearance = 0.30;     // [0.05:0.05:1.5]
Slide_Rail_Height = 2.2;    // [1:0.2:6]
Slide_Rail_Depth = 1.5;     // [0.8:0.1:5]
Slide_Stop = true;
Slide_Grip = "Finger notch"; // [None,Finger notch,Pull tab]
Slide_Grip_Size = 14;       // [5:1:40]

/* [07 - Hængslet låg] */
Hinge_Knuckles = 5;       // [3:2:9]
Hinge_Outer_Diameter = 6; // [3:0.5:14]
Hinge_Pin_Diameter = 2.0; // [1:0.1:6]
Hinge_Pin_Clearance = 0.25; // [0.05:0.05:1]
Hinge_Gap = 0.35;         // [0.1:0.05:1.5]
Hinge_Axis_Offset = 1.0;  // [-3:0.5:5]
Hinge_Lid_Angle = 110;    // [0:5:180]
Hinge_Add_Pin_Model = true;

/* [08 - Lukning] */
Closure = "None"; // [None,Front snap,Magnets]
Snap_Width = 14;  // [5:1:35]
Snap_Thickness = 1.2; // [0.6:0.1:3]
Snap_Engagement = 0.7; // [0.2:0.1:2]
Snap_Clearance = 0.25; // [0.05:0.05:1]
Magnet_Diameter = 6.2; // [2:0.1:15]
Magnet_Thickness = 2.2;// [1:0.1:8]
Magnet_Clearance = 0.15; // [0:0.05:0.8]
Magnet_Count = 2;      // [1:1:4]
Magnet_Edge_Offset = 10; // [4:1:30]

/* [09 - Rumdelere] */
Dividers = "None"; // [None,Grid X,Grid Y,Grid X+Y]
Divider_Count_X = 2; // [1:1:12]
Divider_Count_Y = 2; // [1:1:12]
Divider_Thickness = 1.6; // [0.8:0.1:5]
Divider_Height = 25;     // [2:1:200]
Divider_Bottom_Gap = 0;  // [0:0.2:5]
Divider_Top_Gap = 2;     // [0:0.5:20]

/* [10 - Fingerudskæringer] */
Finger_Notch = "None"; // [None,Front,Front+Back,All walls]
Finger_Notch_Width = 24; // [6:1:80]
Finger_Notch_Depth = 8;  // [2:1:30]
Finger_Notch_Radius = 10;// [3:1:30]

/* [11 - Label / tekst] */
Label_Mode = "None"; // [None,Embossed lid,Debossed lid,Embossed front,Debossed front]
Label_Text = "BOX";
Label_Font = "Liberation Sans:style=Bold";
Label_Size = 12;    // [3:1:60]
Label_Depth = 0.6;  // [0.2:0.1:3]
Label_Rotation = 0; // [0:90:270]

/* [12 - Generelle printerparametre] */
General_Clearance = 0.25; // [0:0.05:1]
Elephant_Foot_Compensation = 0.20; // [0:0.05:1]
Min_Feature = 0.8; // [0.4:0.1:2]
Epsilon = 0.02;

/* [Hidden] */
$fn = $preview ? Preview_Quality : Render_Quality;

// ---------------------------------------------------------------------------
// Derived dimensions
// ---------------------------------------------------------------------------
IW = Dimension_Mode == "Inside" ? Box_Width : max(Min_Feature, Box_Width - 2*Wall_Thickness);
ID = Dimension_Mode == "Inside" ? Box_Depth : max(Min_Feature, Box_Depth - 2*Wall_Thickness);
IH = Dimension_Mode == "Inside" ? Box_Height : max(Min_Feature, Box_Height - Bottom_Thickness);
OW = Dimension_Mode == "Inside" ? Box_Width + 2*Wall_Thickness : Box_Width;
OD = Dimension_Mode == "Inside" ? Box_Depth + 2*Wall_Thickness : Box_Depth;
OH = Dimension_Mode == "Inside" ? Box_Height + Bottom_Thickness : Box_Height;

OR = Corner_Style == "Rounded" ? min(Corner_Radius, min(OW,OD)/2-Epsilon) : 0;
IR = max(0, OR - Wall_Thickness);
LID_OR = max(0, OR + Lid_Corner_Radius_Adjust);

// ---------------------------------------------------------------------------
// Utility functions/modules
// ---------------------------------------------------------------------------
function clamp(v,lo,hi) = min(max(v,lo),hi);
function bool_has(s, token) = len(search(token,s)) > 0;

module rounded_rect_2d(w,d,r){
    rr = clamp(r,0,min(w,d)/2-Epsilon);
    if(rr <= Epsilon)
        square([w,d],center=true);
    else
        offset(r=rr) square([w-2*rr,d-2*rr],center=true);
}

module chamfer_rect_2d(w,d,c){
    cc=clamp(c,0,min(w,d)/2-Epsilon);
    polygon(points=[
        [-w/2+cc,-d/2], [w/2-cc,-d/2], [w/2,-d/2+cc],
        [w/2,d/2-cc], [w/2-cc,d/2], [-w/2+cc,d/2],
        [-w/2,d/2-cc], [-w/2,-d/2+cc]
    ]);
}

module footprint_2d(w,d,r=OR){
    if(Corner_Style=="Rounded") rounded_rect_2d(w,d,r);
    else if(Corner_Style=="Chamfered") chamfer_rect_2d(w,d,Chamfer_Size);
    else square([w,d],center=true);
}

module prism(w,d,h,r=OR){
    linear_extrude(height=h) footprint_2d(w,d,r);
}

module rounded_prism_custom(w,d,h,r){
    linear_extrude(height=h) rounded_rect_2d(w,d,r);
}

module shell_body(){
    difference(){
        union(){
            prism(OW,OD,OH,OR);
            if(Top_Rim_Thickness>0 && Top_Rim_Height>0)
                translate([0,0,OH-Top_Rim_Height])
                    linear_extrude(Top_Rim_Height)
                        difference(){
                            offset(delta=Top_Rim_Thickness) footprint_2d(OW,OD,OR);
                            footprint_2d(OW,OD,OR);
                        }
        }
        translate([0,0,Bottom_Thickness])
            linear_extrude(OH-Bottom_Thickness+Epsilon)
                if(Corner_Style=="Rounded") rounded_rect_2d(IW,ID,IR);
                else if(Corner_Style=="Chamfered") chamfer_rect_2d(IW,ID,max(0,Chamfer_Size-Wall_Thickness));
                else square([IW,ID],center=true);
        finger_notch_cuts();
        floor_pattern_cuts();
        magnet_body_cuts();
        if(Label_Mode=="Debossed front") front_label(cut=true);
        if(Elephant_Foot_Compensation>0)
            elephant_foot_cut();
    }
}

module elephant_foot_cut(){
    // Tiny 45-ish relief around bottom perimeter; improves first-layer fit/appearance.
    h=min(Elephant_Foot_Compensation,Bottom_Thickness/2);
    if(h>0)
        difference(){
            linear_extrude(h) offset(delta=Epsilon) footprint_2d(OW,OD,OR);
            translate([0,0,-Epsilon])
                linear_extrude(h+2*Epsilon) offset(delta=-Elephant_Foot_Compensation) footprint_2d(OW,OD,OR);
        }
}

module floor_pattern_cuts(){
    if(Floor_Style!="Solid"){
        usable_w=max(0,IW-2*Floor_Edge_Margin);
        usable_d=max(0,ID-2*Floor_Edge_Margin);
        nx=max(1,floor(usable_w/Floor_Hole_Spacing));
        ny=max(1,floor(usable_d/Floor_Hole_Spacing));
        for(ix=[0:nx-1], iy=[0:ny-1]){
            x=(ix-(nx-1)/2)*Floor_Hole_Spacing;
            y=(iy-(ny-1)/2)*Floor_Hole_Spacing;
            stagger = Floor_Style=="Hex-ish holes" && (iy%2==1) ? Floor_Hole_Spacing/2 : 0;
            translate([x+stagger,y,-Epsilon])
                if(Floor_Style=="Slots")
                    linear_extrude(Bottom_Thickness+2*Epsilon)
                        hull(){
                            translate([-Floor_Hole_Size/2,0]) circle(d=Floor_Hole_Size/2);
                            translate([ Floor_Hole_Size/2,0]) circle(d=Floor_Hole_Size/2);
                        }
                else
                    cylinder(h=Bottom_Thickness+2*Epsilon,d=Floor_Hole_Size,$fn=Floor_Style=="Hex-ish holes"?6:$fn);
        }
    }
}

module finger_notch_one(side){
    z0=OH-Finger_Notch_Depth;
    if(side=="front")
        translate([0,-OD/2-Epsilon,z0+Finger_Notch_Radius]) rotate([90,0,0])
            hull(){
                cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius,center=false);
                translate([Finger_Notch_Width/2-Finger_Notch_Radius,0,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([-Finger_Notch_Width/2+Finger_Notch_Radius,0,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
            }
    if(side=="back")
        translate([0,OD/2+Epsilon,z0+Finger_Notch_Radius]) rotate([-90,0,0])
            hull(){
                cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([Finger_Notch_Width/2-Finger_Notch_Radius,0,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([-Finger_Notch_Width/2+Finger_Notch_Radius,0,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
            }
    if(side=="left")
        translate([-OW/2-Epsilon,0,z0+Finger_Notch_Radius]) rotate([0,90,0])
            hull(){
                cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([0,Finger_Notch_Width/2-Finger_Notch_Radius,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([0,-Finger_Notch_Width/2+Finger_Notch_Radius,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
            }
    if(side=="right")
        translate([OW/2+Epsilon,0,z0+Finger_Notch_Radius]) rotate([0,-90,0])
            hull(){
                cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([0,Finger_Notch_Width/2-Finger_Notch_Radius,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
                translate([0,-Finger_Notch_Width/2+Finger_Notch_Radius,0]) cylinder(h=Wall_Thickness+2*Epsilon,r=Finger_Notch_Radius);
            }
}

module finger_notch_cuts(){
    if(Finger_Notch=="Front") finger_notch_one("front");
    if(Finger_Notch=="Front+Back") { finger_notch_one("front"); finger_notch_one("back"); }
    if(Finger_Notch=="All walls") { finger_notch_one("front"); finger_notch_one("back"); finger_notch_one("left"); finger_notch_one("right"); }
}

module divider_geometry(){
    dh=min(Divider_Height,IH-Divider_Top_Gap);
    z0=Bottom_Thickness+Divider_Bottom_Gap;
    if(dh>0){
        if(Dividers=="Grid X" || Dividers=="Grid X+Y")
            for(i=[1:Divider_Count_X]){
                x=-IW/2 + i*IW/(Divider_Count_X+1);
                translate([x,0,z0]) cube([Divider_Thickness,ID,dh],center=false);
            }
        if(Dividers=="Grid Y" || Dividers=="Grid X+Y")
            for(i=[1:Divider_Count_Y]){
                y=-ID/2 + i*ID/(Divider_Count_Y+1);
                translate([-IW/2,y,z0]) cube([IW,Divider_Thickness,dh],center=false);
            }
    }
}

module outer_ribs(){
    if(Outer_Ribs){
        nx=max(1,floor((OW-2*OR)/Rib_Spacing));
        ny=max(1,floor((OD-2*OR)/Rib_Spacing));
        for(i=[0:nx]){
            x=-OW/2+OR+i*(OW-2*OR)/max(1,nx);
            translate([x,-OD/2-Rib_Depth,Bottom_Thickness]) cube([Rib_Width,Rib_Depth,OH-Bottom_Thickness],center=false);
            translate([x,OD/2,Bottom_Thickness]) cube([Rib_Width,Rib_Depth,OH-Bottom_Thickness],center=false);
        }
        for(i=[0:ny]){
            y=-OD/2+OR+i*(OD-2*OR)/max(1,ny);
            translate([-OW/2-Rib_Depth,y,Bottom_Thickness]) cube([Rib_Depth,Rib_Width,OH-Bottom_Thickness],center=false);
            translate([OW/2,y,Bottom_Thickness]) cube([Rib_Depth,Rib_Width,OH-Bottom_Thickness],center=false);
        }
    }
}

module feet(){
    if(Feet=="Four pads"){
        for(x=[-1,1],y=[-1,1])
            translate([x*(OW/2-Foot_Size/2-OR/3),y*(OD/2-Foot_Size/2-OR/3),-Foot_Height])
                rounded_prism_custom(Foot_Size,Foot_Size,Foot_Height,min(Foot_Size/3,OR/2));
    } else if(Feet=="Full perimeter"){
        translate([0,0,-Foot_Height]) linear_extrude(Foot_Height)
            difference(){
                footprint_2d(OW,OD,OR);
                offset(delta=-Foot_Size/2) footprint_2d(OW,OD,OR);
            }
    }
}

module front_label(cut=false){
    d=cut ? Label_Depth+Epsilon : Label_Depth;
    // Text lies on front Y face.
    translate([0,-OD/2-(cut?-Epsilon:d),OH/2]) rotate([90,0,0]) rotate([0,0,Label_Rotation])
        linear_extrude(d+Epsilon)
            text(Label_Text,size=Label_Size,font=Label_Font,halign="center",valign="center");
}

module lid_label(cut=false, top_z=0){
    d=cut ? Label_Depth+Epsilon : Label_Depth;
    translate([0,0,top_z-(cut?Label_Depth:0)]) rotate([0,0,Label_Rotation])
        linear_extrude(d+Epsilon)
            text(Label_Text,size=Label_Size,font=Label_Font,halign="center",valign="center");
}

// ---------------------------------------------------------------------------
// Magnet pockets
// ---------------------------------------------------------------------------
function magnet_x(i,n) = n<=1 ? 0 : -OW/2+Magnet_Edge_Offset + i*(OW-2*Magnet_Edge_Offset)/(n-1);

module magnet_body_cuts(){
    if(Closure=="Magnets" && (Lid_Type=="Inner lip" || Lid_Type=="Outer cap" || Lid_Type=="Hinged"))
        for(i=[0:Magnet_Count-1])
            translate([magnet_x(i,Magnet_Count),-OD/2+Wall_Thickness/2,OH-Magnet_Thickness/2])
                rotate([90,0,0]) cylinder(h=Wall_Thickness+2*Epsilon,d=Magnet_Diameter+2*Magnet_Clearance,center=true);
}

module magnet_lid_cuts(lid_y=-OD/2+Wall_Thickness/2,lid_z=0){
    if(Closure=="Magnets")
        for(i=[0:Magnet_Count-1])
            translate([magnet_x(i,Magnet_Count),lid_y,lid_z])
                rotate([90,0,0]) cylinder(h=max(Lip_Thickness,Wall_Thickness)+2*Epsilon,d=Magnet_Diameter+2*Magnet_Clearance,center=true);
}

// ---------------------------------------------------------------------------
// Box-specific lid interfaces
// ---------------------------------------------------------------------------
module sliding_box_rails(){
    if(Lid_Type=="Sliding"){
        z=OH-Slide_Rail_Height-Lid_Thickness-Slide_Clearance;
        if(Slide_Direction=="Width"){
            // rails on front/back; lid moves in X
            translate([0,-OD/2-Slide_Rail_Depth,z]) cube([OW,Slide_Rail_Depth,Slide_Rail_Height],center=false);
            translate([0, OD/2,z]) cube([OW,Slide_Rail_Depth,Slide_Rail_Height],center=false);
            if(Slide_Stop)
                translate([OW/2-Wall_Thickness,-OD/2-Slide_Rail_Depth,z]) cube([Wall_Thickness,OD+2*Slide_Rail_Depth,Slide_Rail_Height+Lid_Thickness],center=false);
        } else {
            translate([-OW/2-Slide_Rail_Depth,0,z]) cube([Slide_Rail_Depth,OD,Slide_Rail_Height],center=false);
            translate([ OW/2,0,z]) cube([Slide_Rail_Depth,OD,Slide_Rail_Height],center=false);
            if(Slide_Stop)
                translate([-OW/2-Slide_Rail_Depth,OD/2-Wall_Thickness,z]) cube([OW+2*Slide_Rail_Depth,Wall_Thickness,Slide_Rail_Height+Lid_Thickness],center=false);
        }
    }
}

module snap_body_receiver(){
    if(Closure=="Front snap" && Lid_Type!="None" && Lid_Type!="Sliding"){
        // small catch block at front outside
        translate([-Snap_Width/2,-OD/2-Snap_Engagement,OH-Snap_Thickness*2])
            cube([Snap_Width,Snap_Engagement+Wall_Thickness/2,Snap_Thickness],center=false);
    }
}

// ---------------------------------------------------------------------------
// Hinge geometry
// ---------------------------------------------------------------------------
function hinge_total_len() = OW - 2*max(OR,Wall_Thickness*2);
function hinge_seg_len() = (hinge_total_len()-(Hinge_Knuckles-1)*Hinge_Gap)/Hinge_Knuckles;

module hinge_knuckle(x,len,is_lid=false){
    od=Hinge_Outer_Diameter;
    id=Hinge_Pin_Diameter+2*Hinge_Pin_Clearance;
    difference(){
        translate([x,-OD/2-od/2+Hinge_Axis_Offset,OH+od/2-Lid_Thickness]) rotate([0,90,0]) cylinder(h=len,d=od,center=false);
        translate([x-Epsilon,-OD/2-od/2+Hinge_Axis_Offset,OH+od/2-Lid_Thickness]) rotate([0,90,0]) cylinder(h=len+2*Epsilon,d=id,center=false);
    }
}

module box_hinges(){
    if(Lid_Type=="Hinged"){
        seg=hinge_seg_len();
        start=-hinge_total_len()/2;
        for(i=[0:Hinge_Knuckles-1]) if(i%2==0)
            hinge_knuckle(start+i*(seg+Hinge_Gap),seg,false);
    }
}

module lid_hinges_local(){
    if(Lid_Type=="Hinged"){
        seg=hinge_seg_len();
        start=-hinge_total_len()/2;
        od=Hinge_Outer_Diameter;
        id=Hinge_Pin_Diameter+2*Hinge_Pin_Clearance;
        for(i=[0:Hinge_Knuckles-1]) if(i%2==1)
            difference(){
                translate([start+i*(seg+Hinge_Gap),-OD/2-od/2+Hinge_Axis_Offset,od/2]) rotate([0,90,0]) cylinder(h=seg,d=od);
                translate([start+i*(seg+Hinge_Gap)-Epsilon,-OD/2-od/2+Hinge_Axis_Offset,od/2]) rotate([0,90,0]) cylinder(h=seg+2*Epsilon,d=id);
            }
    }
}

module hinge_pin(){
    if(Hinge_Add_Pin_Model && Lid_Type=="Hinged")
        rotate([0,90,0]) cylinder(h=hinge_total_len()+4,d=Hinge_Pin_Diameter,center=true);
}

// ---------------------------------------------------------------------------
// Lid modules
// ---------------------------------------------------------------------------
module lid_panel(w=OW,d=OD,r=LID_OR){
    difference(){
        rounded_prism_custom(w,d,Lid_Thickness,r);
        if(Label_Mode=="Debossed lid") lid_label(cut=true,top_z=Lid_Thickness+Epsilon);
    }
    if(Label_Mode=="Embossed lid") lid_label(cut=false,top_z=Lid_Thickness);
}

module inner_lip_lid(){
    lip_w=IW-2*Lid_Clearance;
    lip_d=ID-2*Lid_Clearance;
    panel_w=OW+2*Lid_Overhang;
    panel_d=OD+2*Lid_Overhang;
    difference(){
        union(){
            lid_panel(panel_w,panel_d,LID_OR+Lid_Overhang);
            translate([0,0,-Lip_Height])
                linear_extrude(Lip_Height)
                    difference(){
                        rounded_rect_2d(lip_w,lip_d,max(0,IR-Lid_Clearance));
                        rounded_rect_2d(max(Min_Feature,lip_w-2*Lip_Thickness),max(Min_Feature,lip_d-2*Lip_Thickness),max(0,IR-Lid_Clearance-Lip_Thickness));
                    }
            if(Closure=="Front snap") lid_snap_local();
        }
        magnet_lid_cuts(-lip_d/2+Lip_Thickness/2,-Lip_Height/2);
    }
}

module outer_cap_lid(){
    inner_w=OW+2*Lid_Clearance;
    inner_d=OD+2*Lid_Clearance;
    outer_w=inner_w+2*Lip_Thickness;
    outer_d=inner_d+2*Lip_Thickness;
    difference(){
        union(){
            lid_panel(outer_w,outer_d,LID_OR+Lip_Thickness+Lid_Clearance);
            translate([0,0,-Lip_Height])
                linear_extrude(Lip_Height)
                    difference(){
                        rounded_rect_2d(outer_w,outer_d,LID_OR+Lip_Thickness+Lid_Clearance);
                        rounded_rect_2d(inner_w,inner_d,LID_OR+Lid_Clearance);
                    }
            if(Closure=="Front snap") lid_snap_local(y=-outer_d/2);
        }
        magnet_lid_cuts(-inner_d/2-Lip_Thickness/2,-Lip_Height/2);
    }
}

module lid_snap_local(y=-OD/2){
    translate([-Snap_Width/2,y-Snap_Thickness,-Lip_Height+Snap_Clearance])
        cube([Snap_Width,Snap_Thickness,Lip_Height-Snap_Clearance],center=false);
    translate([-Snap_Width/2,y-Snap_Thickness-Snap_Engagement,-Lip_Height+Snap_Clearance])
        cube([Snap_Width,Snap_Engagement,Snap_Thickness],center=false);
}

module sliding_lid(){
    if(Slide_Direction=="Width"){
        w=OW-(Slide_Stop?Wall_Thickness:0)-2*Slide_Clearance;
        d=OD+2*Slide_Rail_Depth-2*Slide_Clearance;
        difference(){
            lid_panel(w,d,max(0,LID_OR));
            if(Slide_Grip=="Finger notch")
                translate([-w/2,0,-Epsilon]) cylinder(h=Lid_Thickness+2*Epsilon,d=Slide_Grip_Size);
        }
        if(Slide_Grip=="Pull tab")
            translate([-w/2-Slide_Grip_Size/2,0,0]) rounded_prism_custom(Slide_Grip_Size,Slide_Grip_Size,Lid_Thickness,min(3,Slide_Grip_Size/4));
    } else {
        w=OW+2*Slide_Rail_Depth-2*Slide_Clearance;
        d=OD-(Slide_Stop?Wall_Thickness:0)-2*Slide_Clearance;
        difference(){
            lid_panel(w,d,max(0,LID_OR));
            if(Slide_Grip=="Finger notch")
                translate([0,-d/2,-Epsilon]) cylinder(h=Lid_Thickness+2*Epsilon,d=Slide_Grip_Size);
        }
        if(Slide_Grip=="Pull tab")
            translate([0,-d/2-Slide_Grip_Size/2,0]) rounded_prism_custom(Slide_Grip_Size,Slide_Grip_Size,Lid_Thickness,min(3,Slide_Grip_Size/4));
    }
}

module hinged_lid(){
    // flat-ish lid with shallow locating lip, plus alternating hinge knuckles
    union(){
        difference(){
            union(){
                lid_panel(OW+2*Lid_Overhang,OD+2*Lid_Overhang,LID_OR+Lid_Overhang);
                translate([0,0,-min(Lip_Height,3)])
                    linear_extrude(min(Lip_Height,3))
                        difference(){
                            rounded_rect_2d(IW-2*Lid_Clearance,ID-2*Lid_Clearance,max(0,IR-Lid_Clearance));
                            rounded_rect_2d(IW-2*Lid_Clearance-2*Lip_Thickness,ID-2*Lid_Clearance-2*Lip_Thickness,max(0,IR-Lid_Clearance-Lip_Thickness));
                        }
                lid_hinges_local();
                if(Closure=="Front snap") lid_snap_local();
            }
            magnet_lid_cuts(-ID/2+Lip_Thickness/2,-min(Lip_Height,3)/2);
        }
    }
}

module lid_model(){
    if(Lid_Type=="Inner lip") inner_lip_lid();
    else if(Lid_Type=="Outer cap") outer_cap_lid();
    else if(Lid_Type=="Sliding") sliding_lid();
    else if(Lid_Type=="Hinged") hinged_lid();
}

// ---------------------------------------------------------------------------
// Full box assembly
// ---------------------------------------------------------------------------
module box_model(){
    union(){
        shell_body();
        intersection(){
            divider_geometry();
            translate([0,0,Bottom_Thickness])
                linear_extrude(max(0,IH))
                    if(Corner_Style=="Rounded") rounded_rect_2d(IW,ID,IR);
                    else if(Corner_Style=="Chamfered") chamfer_rect_2d(IW,ID,max(0,Chamfer_Size-Wall_Thickness));
                    else square([IW,ID],center=true);
        }
        outer_ribs();
        feet();
        sliding_box_rails();
        box_hinges();
        snap_body_receiver();
        if(Label_Mode=="Embossed front") front_label(cut=false);
    }
}

// ---------------------------------------------------------------------------
// Layout / preview
// ---------------------------------------------------------------------------
module lid_print_oriented(){
    // Lid top face down for common FDM-friendly print orientation where practical.
    if(Lid_Type=="Inner lip" || Lid_Type=="Outer cap" || Lid_Type=="Hinged")
        translate([0,0,Lid_Thickness]) rotate([180,0,0]) lid_model();
    else lid_model();
}

module assembled(){
    box_model();
    if(Lid_Type=="Inner lip" || Lid_Type=="Outer cap")
        translate([0,0,OH+Lip_Height]) lid_model();
    else if(Lid_Type=="Sliding")
        translate([0,0,OH-Lid_Thickness-Slide_Clearance]) lid_model();
    else if(Lid_Type=="Hinged"){
        // approximate visual rotation about rear hinge axis
        axis_y=-OD/2-Hinge_Outer_Diameter/2+Hinge_Axis_Offset;
        axis_z=OH+Hinge_Outer_Diameter/2-Lid_Thickness;
        translate([0,axis_y,axis_z]) rotate([Hinge_Lid_Angle,0,0]) translate([0,-axis_y,-Hinge_Outer_Diameter/2]) hinged_lid();
    }
}

module exploded(){
    box_model();
    if(Lid_Type!="None") translate([0,0,OH+Explode_Distance]) lid_model();
}

module print_layout(){
    box_model();
    if(Lid_Type!="None")
        translate([OW/2 + max(OW,OD)/2 + Print_Gap,0,0]) lid_print_oriented();
    if(Lid_Type=="Hinged" && Hinge_Add_Pin_Model)
        translate([0,-OD/2-Hinge_Outer_Diameter-Print_Gap, Hinge_Pin_Diameter/2]) hinge_pin();
}

// ---------------------------------------------------------------------------
// Diagnostics
// ---------------------------------------------------------------------------
module diagnostics(){
    if(Show_Diagnostics){
        echo("=== PARAMETRIC BOX GENERATOR ===");
        echo("Dimension mode:",Dimension_Mode);
        echo("Inside W/D/H:",IW,ID,IH);
        echo("Outside W/D/H:",OW,OD,OH);
        echo("Wall / bottom:",Wall_Thickness,Bottom_Thickness);
        echo("Lid:",Lid_Type," clearance=",Lid_Clearance);
        if(Lid_Type=="Sliding") echo("Slide clearance:",Slide_Clearance);
        if(Lid_Type=="Hinged") echo("Hinge pin / hole:",Hinge_Pin_Diameter,Hinge_Pin_Diameter+2*Hinge_Pin_Clearance);
        if(Closure=="Magnets") echo("Magnet pocket diameter:",Magnet_Diameter+2*Magnet_Clearance," depth:",Magnet_Thickness);
        if(Wall_Thickness<Min_Feature) echo("WARNING: Wall thickness below Min_Feature");
        if(Bottom_Thickness<Min_Feature) echo("WARNING: Bottom thickness below Min_Feature");
        if(Lip_Thickness<Min_Feature && Lid_Type!="None" && Lid_Type!="Sliding") echo("WARNING: Lid lip thinner than Min_Feature");
        if(Divider_Thickness<Min_Feature && Dividers!="None") echo("WARNING: Divider thinner than Min_Feature");
        if(IW<=2*Lid_Clearance || ID<=2*Lid_Clearance) echo("WARNING: Lid clearance too large for opening");
    }
}

diagnostics();

if(Output=="Box only") box_model();
else if(Output=="Lid only" && Lid_Type!="None") lid_print_oriented();
else if(Output=="Both - print layout") print_layout();
else if(Output=="Assembled preview") assembled();
else if(Output=="Exploded preview") exploded();
else box_model();