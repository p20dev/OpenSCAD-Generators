// USB-A Stick Holder Generator v2.1 - string and wall warning fixes
// OpenSCAD Nightly. All dimensions in millimetres.
// F6 -> File -> Export -> Export as STL.
// Holes accept the metal part of a USB-A male connector, not the plastic body.
// Measure your own connectors. Print the fit test before a large holder.

/* [Holder] */
Holder_Type = "Rectangular"; // [Circular, Rectangular, Wall, Fit Test]
Count = 8; // [1:1:48]
Rows = 2; // [1:1:12]
Columns = 0; // [0:1:48]
Holder_Height = 18; // [6:1:60]
Edge_Margin = 5; // [2:0.5:20]
Hole_Wall = 3; // [1.2:0.2:12]
Outer_Corner_Radius = 5; // [0:0.5:30]

/* [USB-A fit] */
USB_Width = 12.0; // [10:0.1:15]
USB_Thickness = 4.5; // [3:0.1:7]
Clearance_Width = 0.25; // [0:0.05:1.5]
Clearance_Thickness = 0.25; // [0:0.05:1.5]
Hole_Depth = 12; // [3:0.5:40]
Bottom_Thickness = 1.6; // [1:0.2:5]
Hole_Corner_Radius = 0.4; // [0:0.1:2]
Entry_Chamfer = 0.8; // [0:0.1:3]
Entry_Clearance = 0.15; // [0:0.05:0.8]

/* [Stick body spacing] */
Use_Body_Spacing = true;
Body_Width = 20; // [12:0.5:50]
Body_Thickness = 8; // [4:0.5:30]
Body_Gap = 3; // [0:0.5:30]

/* [Circular] */
Circular_Min_Diameter = 45; // [25:1:200]
Circular_Orientation = "Radial"; // [Radial, Tangential, Parallel]
Center_Clearance = 0; // [0:1:100]
Circular_Text_Position = "Center"; // [Center, Ring, Side]
Circular_Ring_Width = 12; // [4:1:40]
Circular_Text_Start_Angle = 180; // [-360:1:360]
Circular_Text_Direction = "CCW"; // [CCW, CW]

/* [Rectangular] */
Rectangular_Orientation = "Horizontal"; // [Horizontal, Vertical]

/* [Wall mounting] */
Wall_Columns = 4; // [1:1:24]
Wall_Plate_Thickness = 6; // [3:0.5:20]
Wall_Margin = 8; // [4:1:30]
Wall_Angle = 15; // [0:1:45]
Screw_Diameter = 4.5; // [2:0.5:8]
Screw_Head_Diameter = 8.5; // [4:0.5:16]
Screw_Head_Depth = 2; // [0:0.5:6]
Screw_Spacing = 0; // [0:1:300]
Screw_Edge_Offset = 10; // [5:1:30]

/* [Text] */
Show_Text = true;
Text = "USB";
Text_Font = "Liberation Sans:style=Bold";
Text_Size = 8; // [3:0.5:30]
Text_Spacing = 1; // [0.5:0.1:2]
Text_Mode = "Engraved"; // [Engraved, Raised]
Text_Depth = 0.6; // [0.2:0.1:3]
Text_Auto_Fit = true;
Text_Allow_Enlarge = false;
Text_Max_Scale = 2; // [1:0.1:5]
Text_Band = 14; // [0:1:40]
Text_Margin = 3; // [0:0.5:10]
Text_Position = "Front"; // [Front, Back]
Text_Rotation = 0; // [-180:1:180]
Text_Offset_X = 0; // [-100:0.5:100]
Text_Offset_Y = 0; // [-100:0.5:100]

/* [Hole numbering] */
Show_Numbers = false;
Number_Start = 1; // [0:1:999]
Number_Font = "Liberation Sans:style=Bold";
Number_Size = 4; // [2:0.5:12]
Number_Position = "Front"; // [Front, Back]
Number_Margin = 1.5; // [0:0.5:5]

/* [Fit Test] */
Test_Count = 5; // [1:1:12]
Test_Clearance_Start = 0.10; // [0:0.05:1]
Test_Clearance_Step = 0.05; // [0:0.01:0.3]
Test_Label = true;

/* [STL quality] */
Quality = "High"; // [Draft, Normal, High, Ultra, Custom]
Custom_FN = 96; // [12:1:360]
Show_Info = true;
Show_Body_Preview = false;

/* [Hidden] */
$fn = Quality == "Draft" ? 24 : Quality == "Normal" ? 48 : Quality == "High" ? 96 : Quality == "Ultra" ? 180 : Custom_FN;
eps = 0.02;
function clamp(x,a,b) = min(max(x,a),b);
function rr(w,h,r) = clamp(r,0,min(w,h)/2-0.001);
function max2(a,b) = max(a,b);
function ncols(n,rows,cols) = cols > 0 ? min(n,cols) : ceil(n/rows);
function rot_w(w,h,a) = abs(w*cos(a)) + abs(h*sin(a));
function rot_h(w,h,a) = abs(w*sin(a)) + abs(h*cos(a));
function prefix(s,n) = n<=0 ? "" : str(prefix(s,n-1),s[n-1]);
function txt_m(s,size,font,spacing) = textmetrics(text=s,size=size,font=font,spacing=spacing);
function txt_w(s,size,font,spacing) = txt_m(s,size,font,spacing).size.x;
function txt_h(s,size,font,spacing) = txt_m(s,size,font,spacing).size.y;
function fit_factor(w,h,maxw,maxh,allowup,maxscale) = min(allowup ? maxscale : 1, maxw/max(w,0.001), maxh/max(h,0.001));
function txt_fit(s,size,font,spacing,maxw,maxh,angle) = fit_factor(rot_w(txt_w(s,size,font,spacing),txt_h(s,size,font,spacing),angle),rot_h(txt_w(s,size,font,spacing),txt_h(s,size,font,spacing),angle),maxw,maxh,Text_Allow_Enlarge,Text_Max_Scale);
function hw(cw=Clearance_Width) = USB_Width + 2*cw;
function ht(ct=Clearance_Thickness) = USB_Thickness + 2*ct;
function bw(cw=Clearance_Width) = max(Body_Width,hw(cw));
function bt(ct=Clearance_Thickness) = max(Body_Thickness,ht(ct));
function px(cw=Clearance_Width) = Use_Body_Spacing ? max(hw(cw)+Hole_Wall,bw(cw)+Body_Gap) : hw(cw)+Hole_Wall;
function py(ct=Clearance_Thickness) = Use_Body_Spacing ? max(ht(ct)+Hole_Wall,bt(ct)+Body_Gap) : ht(ct)+Hole_Wall;
function depth_for(h) = min(Hole_Depth,h-Bottom_Thickness);
function text_on() = Show_Text && Text != "";
function band_on() = text_on() && Text_Band > 0;
function num_band() = Show_Numbers ? Number_Size*1.5+2*Number_Margin : 0;

module rounded_rect(w,h,r) {
    rad=rr(w,h,r);
    if(rad<=0) square([w,h],center=true);
    else offset(r=rad) square([w-2*rad,h-2*rad],center=true);
}
module plate(w,h,z,r=Outer_Corner_Radius) {
    linear_extrude(height=z) rounded_rect(w,h,r);
}
module usb_cut(depth,cw=Clearance_Width,ct=Clearance_Thickness) {
    w=hw(cw); h=ht(ct); ch=min(Entry_Chamfer,depth/3);
    translate([0,0,-eps]) linear_extrude(height=depth+2*eps) rounded_rect(w,h,Hole_Corner_Radius);
    if(ch>0 && Entry_Clearance>0)
        translate([0,0,depth-ch]) linear_extrude(height=ch+eps,scale=[(w+2*Entry_Clearance)/w,(h+2*Entry_Clearance)/h]) rounded_rect(w,h,Hole_Corner_Radius);
}
// Actual ink bounds, not font advance width. Rotation is included before fitting.
module fitted_text_2d(s,maxw,maxh,size=Text_Size,font=Text_Font,spacing=Text_Spacing,angle=Text_Rotation) {
    if(s!="" && maxw>0 && maxh>0) {
        m=txt_m(s,size,font,spacing);
        f=Text_Auto_Fit ? txt_fit(s,size,font,spacing,maxw,maxh,angle) : 1;
        rotate(angle) scale([f,f]) translate([-m.position.x-m.size.x/2,-m.position.y-m.size.y/2])
            text(s,size=size,font=font,spacing=spacing);
    }
}
module text_solid(s,x,y,z,maxw,maxh,angle=Text_Rotation,size=Text_Size,font=Text_Font,spacing=Text_Spacing,depth=Text_Depth) {
    translate([x+Text_Offset_X,y+Text_Offset_Y,z]) linear_extrude(height=depth+eps)
        fitted_text_2d(s,maxw,maxh,size,font,spacing,angle);
}
module top_text(s,x,y,z,maxw,maxh,angle=Text_Rotation,size=Text_Size,font=Text_Font,spacing=Text_Spacing) {
    text_solid(s,x,y,z+(Text_Mode=="Raised" ? -eps : -Text_Depth),maxw,maxh,angle,size,font,spacing);
}
module number_text(n,x,y,z,maxw,maxh) {
    // Number offsets are independent of the main text offsets.
    translate([x,y,z+(Text_Mode=="Raised" ? -eps : -Text_Depth)]) linear_extrude(height=Text_Depth+eps)
        fitted_text_2d(str(Number_Start+n),maxw,maxh,Number_Size,Number_Font,1,0);
}
module connector_cut(x,y,z,angle=0,depth=depth_for(Holder_Height),cw=Clearance_Width,ct=Clearance_Thickness) {
    translate([x,y,z-depth]) rotate([0,0,angle]) usb_cut(depth,cw,ct);
}

// -------------------- Circular --------------------
// Conservative bounding-circle spacing works for every orientation.
ce=Use_Body_Spacing ? sqrt(bw()*bw()+bt()*bt())+Body_Gap : sqrt(hw()*hw()+ht()*ht())+Hole_Wall;
cr_spacing=Count<=1 ? 0 : ce/(2*sin(180/Count));
cr=max(cr_spacing,Center_Clearance/2+max(hw(),ht())/2+Hole_Wall,0);
cr_ring=cr+max(hw(),ht())/2+Hole_Wall;
number_extra=Show_Numbers ? Number_Size+2*Number_Margin : 0;
ring_extra= (text_on() && Circular_Text_Position=="Ring" ? Circular_Ring_Width : 0)+number_extra;
cr_outer=max(Circular_Min_Diameter/2,cr_ring+ring_extra+Edge_Margin);
cr_center=max(0,cr-sqrt(hw()*hw()+ht()*ht())/2-Hole_Wall);
function circ_angle(i) = 360*i/Count;
function circ_orientation(a) = Circular_Orientation=="Radial" ? a : Circular_Orientation=="Tangential" ? a+90 : 0;
module circular_holes() {
    for(i=[0:Count-1]) let(a=circ_angle(i)) connector_cut(cr*cos(a),cr*sin(a),Holder_Height,circ_orientation(a));
}
module circular_numbers() {
    if(Show_Numbers) for(i=[0:Count-1]) let(a=circ_angle(i),r=cr_ring+Number_Margin+Number_Size/2)
        number_text(i,r*cos(a),r*sin(a),Holder_Height,max(Number_Size*3,ce-Hole_Wall),Number_Size*1.5);
}
// True per-glyph circular text, with measured advance widths and ink centering.
module arc_text(s,r,z,start=180,dir="CCW") {
    m=txt_m(s,Text_Size,Text_Font,Text_Spacing);
    circumference=2*PI*r;
    avail=max(0.001,circumference-2*Text_Margin);
    f=Text_Auto_Fit ? min(Text_Allow_Enlarge ? Text_Max_Scale : 1,avail/max(m.advance.x,0.001),max(Circular_Ring_Width-2*Text_Margin,0.001)/max(m.size.y,0.001)) : 1;
    // textmetrics() per prefix supplies actual advances, including spacing/kerning.
    for(i=[0:len(s)-1]) let(
        before=i==0 ? 0 : txt_m(prefix(s,i),Text_Size,Text_Font,Text_Spacing).advance.x,
        after=txt_m(prefix(s,i+1),Text_Size,Text_Font,Text_Spacing).advance.x,
        a=start+(dir=="CCW" ? 1 : -1)*((before+after)/2-m.advance.x/2)*f*180/(PI*r),
        cm=txt_m(s[i],Text_Size,Text_Font,Text_Spacing)
    )
        translate([r*cos(a),r*sin(a),z+(Text_Mode=="Raised" ? -eps : -Text_Depth)])
            rotate([0,0,a+(dir=="CCW" ? -90 : 90)+Text_Rotation])
                linear_extrude(height=Text_Depth+eps)
                    scale([f,f]) translate([-cm.position.x-cm.size.x/2,-cm.position.y-cm.size.y/2])
                        text(s[i],size=Text_Size,font=Text_Font,spacing=Text_Spacing);
}
module circular_main_text() {
    if(text_on()) {
        if(Circular_Text_Position=="Center") top_text(Text,0,0,Holder_Height,2*max(0,cr_center-Text_Margin),2*max(0,cr_center-Text_Margin));
        else if(Circular_Text_Position=="Ring") arc_text(Text,cr_ring+number_extra+Circular_Ring_Width/2,Holder_Height,Circular_Text_Start_Angle,Circular_Text_Direction);
        else if(Circular_Text_Position=="Side") {
            // Characters follow the cylindrical side, upright in the Z direction.
            m=txt_m(Text,Text_Size,Text_Font,Text_Spacing);
            f=Text_Auto_Fit ? min(Text_Allow_Enlarge ? Text_Max_Scale : 1,(2*PI*cr_outer-2*Text_Margin)/max(m.advance.x,0.001),(Holder_Height-2*Text_Margin)/max(m.size.y,0.001)) : 1;
            for(i=[0:len(Text)-1]) let(
                before=i==0 ? 0 : txt_m(prefix(Text,i),Text_Size,Text_Font,Text_Spacing).advance.x,
                after=txt_m(prefix(Text,i+1),Text_Size,Text_Font,Text_Spacing).advance.x,
                a=Circular_Text_Start_Angle+((before+after)/2-m.advance.x/2)*f*180/(PI*cr_outer),
                cm=txt_m(Text[i],Text_Size,Text_Font,Text_Spacing)
            )
                rotate([0,0,a]) translate([cr_outer-(Text_Mode=="Engraved" ? Text_Depth : 0)-max(0,cr_outer-sqrt(max(0,cr_outer*cr_outer-pow(cm.size.x*f/2,2))))-eps,0,Holder_Height/2]) rotate([90,0,90])
                    linear_extrude(height=Text_Depth+max(0,cr_outer-sqrt(max(0,cr_outer*cr_outer-pow(cm.size.x*f/2,2))))+2*eps)
                        scale([f,f]) translate([-cm.position.x-cm.size.x/2,-cm.position.y-cm.size.y/2])
                            text(Text[i],size=Text_Size,font=Text_Font,spacing=Text_Spacing);
        }
    }
}
module circular_holder() {
    difference() {
        cylinder(h=Holder_Height,r=cr_outer);
        circular_holes();
        if(Text_Mode=="Engraved") { circular_main_text(); circular_numbers(); }
    }
    if(Text_Mode=="Raised") { circular_main_text(); circular_numbers(); }
}

// -------------------- Rectangular --------------------
rc=ncols(Count,Rows,Columns); rrn=ceil(Count/rc);
vertical=Rectangular_Orientation=="Vertical";
rhw=vertical ? ht() : hw(); rht=vertical ? hw() : ht();
rpx=vertical ? py() : px(); rpy=(vertical ? px() : py())+num_band();
rfieldw=(rc-1)*rpx+rhw; rfieldh=(rrn-1)*rpy+rht;
rnw=num_band();
rtext=band_on() ? Text_Band : 0;
rw=rfieldw+2*Edge_Margin;
rh=rfieldh+2*Edge_Margin+rnw+rtext;
rfieldy=(Text_Position=="Front" ? rtext/2 : -rtext/2)+(Number_Position=="Front" ? rnw/2 : -rnw/2);
function rx(i)=(i%rc-(rc-1)/2)*rpx;
function ry(i)=(floor(i/rc)-(rrn-1)/2)*rpy+rfieldy;
module rectangular_holes() {
    for(i=[0:Count-1]) connector_cut(rx(i),ry(i),Holder_Height,vertical ? 90 : 0);
}
module rectangular_numbers() {
    if(Show_Numbers) for(i=[0:Count-1])
        number_text(i,rx(i),ry(i)+(Number_Position=="Front" ? -1 : 1)*(rht/2+Number_Margin+Number_Size/2),Holder_Height,rpx-Hole_Wall,Number_Size*1.5);
}
module rectangular_main_text() {
    if(band_on()) top_text(Text,0,(Text_Position=="Front" ? -1 : 1)*(rh/2-Text_Band/2),Holder_Height,rw-2*Text_Margin,Text_Band-2*Text_Margin);
}
module rectangular_holder() {
    difference() {
        plate(rw,rh,Holder_Height);
        rectangular_holes();
        if(Text_Mode=="Engraved") { rectangular_main_text(); rectangular_numbers(); }
    }
    if(Text_Mode=="Raised") { rectangular_main_text(); rectangular_numbers(); }
}

// -------------------- Wall --------------------
// Print flat with the back on the build plate. The upper rail contains screws.
wc=min(Wall_Columns,Count); wr=ceil(Count/wc);
wn=num_band();
wpy=py()+wn;
wf_w=(wc-1)*px()+hw(); wf_h=(wr-1)*wpy+ht();
wt=band_on() ? Text_Band : 0;
screw_r=max(Screw_Diameter,Screw_Head_Diameter)/2;
ws= Screw_Spacing>0 ? Screw_Spacing : max(wf_w-2*Screw_Edge_Offset,2*screw_r+Hole_Wall);
ww=max(wf_w+2*Wall_Margin,ws+2*screw_r+2*Wall_Margin);
rail=max(2*screw_r+2*Wall_Margin,12);
// Inclined holes sweep in Y. Reserve their full projected envelope.
sweep=Hole_Depth*sin(Wall_Angle)+ht()*cos(Wall_Angle)+2*Entry_Clearance;
wh=wf_h+max(0,sweep-ht())+2*Wall_Margin+rail+wn+wt;
wth=max(Wall_Plate_Thickness,Hole_Depth*cos(Wall_Angle)+ht()*sin(Wall_Angle)/2+Bottom_Thickness);
wd=min(Hole_Depth,(wth-Bottom_Thickness-ht()*sin(Wall_Angle)/2)/max(cos(Wall_Angle),0.001));
wfieldy= -rail/2+wt/2+(wn>0 ? wn/2 : 0);
wscrewy=wh/2-rail/2;
function wx(i)=(i%wc-(wc-1)/2)*px();
function wy(i)=(floor(i/wc)-(wr-1)/2)*wpy+wfieldy;
module wall_holes() {
    for(i=[0:Count-1]) translate([wx(i),wy(i),wth]) rotate([Wall_Angle,0,0]) translate([0,0,-wd]) usb_cut(wd);
}
module wall_screws() {
    for(x=[-ws/2,ws/2]) translate([x,wscrewy,-eps]) {
        cylinder(h=wth+2*eps,d=Screw_Diameter);
        if(Screw_Head_Depth>0) translate([0,0,wth-min(Screw_Head_Depth,wth-Bottom_Thickness)])
            cylinder(h=min(Screw_Head_Depth,wth-Bottom_Thickness)+eps,d1=Screw_Diameter,d2=Screw_Head_Diameter);
    }
}
module wall_numbers() {
    if(Show_Numbers) for(i=[0:Count-1]) number_text(i,wx(i),wy(i)+(Number_Position=="Front" ? -1 : 1)*(ht()/2+Number_Margin+Number_Size/2),wth,px()-Hole_Wall,Number_Size*1.5);
}
module wall_main_text() {
    if(band_on()) top_text(Text,0,-wh/2+Text_Band/2,wth,ww-2*Text_Margin,Text_Band-2*Text_Margin);
}
module wall_holder() {
    difference() {
        plate(ww,wh,wth);
        wall_holes(); wall_screws();
        if(Text_Mode=="Engraved") { wall_main_text(); wall_numbers(); }
    }
    if(Text_Mode=="Raised") { wall_main_text(); wall_numbers(); }
}

// -------------------- Fit test --------------------
tc=Test_Count;
tmax=Test_Clearance_Start+(tc-1)*Test_Clearance_Step;
tw=USB_Width+2*tmax+2*Edge_Margin;
tpitch=tw+Hole_Wall;
th=USB_Thickness+2*tmax+2*Edge_Margin+10;
theight=max(8,min(Holder_Height,Hole_Depth+Bottom_Thickness));
module fit_test() {
    difference() {
        plate(tc*tpitch-Hole_Wall,th,theight);
        for(i=[0:tc-1]) let(c=Test_Clearance_Start+i*Test_Clearance_Step)
            translate([(i-(tc-1)/2)*tpitch,3,theight-min(Hole_Depth,theight-Bottom_Thickness)])
                usb_cut(min(Hole_Depth,theight-Bottom_Thickness),c,c);
        if(Test_Label) for(i=[0:tc-1]) let(c=Test_Clearance_Start+i*Test_Clearance_Step)
            translate([(i-(tc-1)/2)*tpitch,-th/2+5,theight-0.5])
                linear_extrude(height=0.5+eps)
                    fitted_text_2d(str(c),tw-2,5,4,Text_Font,1,0);
    }
}

// -------------------- Validation --------------------
assert(Count>=1 && Count<=48,"Count must be 1..48");
assert(Rows>=1 && Holder_Height>Bottom_Thickness,"Invalid holder height or rows");
assert(USB_Width>0 && USB_Thickness>0 && Hole_Wall>0,"Invalid USB dimensions");
assert(Hole_Depth>0 && Bottom_Thickness>=1,"Invalid hole depth or bottom thickness");
assert(Clearance_Width>=0 && Clearance_Thickness>=0,"Clearances must be nonnegative");
assert(Text_Depth>0 && Text_Depth<Holder_Height-Bottom_Thickness,"Text depth is too large");
assert(!Show_Numbers || !band_on() || Number_Position!=Text_Position || Text_Band>2*Text_Margin,"Invalid text band");
assert(!text_on() || Text_Band==0 || Text_Band>2*Text_Margin,"Text band is too narrow");
assert(!Show_Numbers || Number_Size>0,"Invalid numbering size");
assert(Screw_Head_Depth>=0 && Screw_Diameter>0 && Screw_Head_Diameter>=Screw_Diameter,"Invalid screw dimensions");
assert(Outer_Corner_Radius>=0 && Edge_Margin>=0 && Body_Gap>=0,"Invalid spacing or corner radius");
assert(Text_Max_Scale>0 && Text_Size>0 && Text_Margin>=0,"Invalid text parameters");
assert(Wall_Angle>=0 && Wall_Angle<=45,"Wall angle must be 0..45 degrees");
assert(Test_Count>=1 && Test_Clearance_Start>=0 && Test_Clearance_Step>=0,"Invalid fit test");
if(Show_Info) {
    echo("USB-A Holder Generator v2",Holder_Type);
    echo("Hole",hw(),ht(),"depth",depth_for(Holder_Height));
    echo("Body pitch",px(),py(),"quality",$fn);
    if(Holder_Type=="Circular") echo("Diameter",2*cr_outer);
    if(Holder_Type=="Rectangular") echo("Dimensions",rw,rh,Holder_Height);
    if(Holder_Type=="Wall") echo("Dimensions",ww,wh,wth,"screw spacing",ws);
    if(Holder_Type=="Fit Test") echo("Test clearances",Test_Clearance_Start,Test_Clearance_Step,Test_Count);
}
if(Holder_Type=="Circular") circular_holder();
else if(Holder_Type=="Rectangular") rectangular_holder();
else if(Holder_Type=="Wall") wall_holder();
else if(Holder_Type=="Fit Test") fit_test();
