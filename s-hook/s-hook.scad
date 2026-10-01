/*
  PARAMETRIC S-HOOK GENERATOR — reconstructed repository edition
  ---------------------------------------------------------------------------
  This file reconstructs the final corrected S-hook design discussed on
  2026-09-23. The original final source was delivered inline in chat and was
  not preserved as a downloadable artifact.

  The critical geometry correction is preserved:
    - the upper hook joins the neck at the RIGHT side of its ellipse (0 deg)
    - the lower hook joins the neck at the LEFT side of its ellipse (180 deg)
    - the upper arc therefore terminates at 0 deg
    - the lower arc begins at 180 deg

  This removes the earlier 90-degree neck/arc orientation error.

  Units: millimetres.
  Intended for recent OpenSCAD Nightly, but uses conservative syntax.
*/

/* [Hook geometry] */
top_radius = 22; // [5:0.5:80]
bottom_radius = 18; // [5:0.5:80]
top_sweep = 290; // [190:1:340]
bottom_sweep = 290; // [190:1:340]
neck_length = 22; // [0:0.5:100]
neck_curve = 0; // [-20:0.5:20]
overall_scale_x = 1.0; // [0.25:0.05:3]
overall_scale_y = 1.0; // [0.25:0.05:3]

/* [Section] */
profile = "Round"; // [Round,Oval,Flat]
rod_diameter = 5.0; // [1.5:0.1:16]
oval_z_ratio = 0.70; // [0.25:0.05:1.5]
flat_thickness = 4.0; // [0.8:0.1:12]
flat_width = 6.0; // [1.5:0.1:20]

/* [Tips] */
tip_style = "Rounded"; // [Plain,Rounded,Bulb]
tip_bulb_scale = 1.30; // [1:0.05:2]
tip_extension = 0; // [0:0.5:15]

/* [Reinforcement] */
neck_reinforcement = 0; // [0:0.1:5]

/* [Quality] */
quality = 72; // [16:4:180]
path_steps = 72; // [20:2:180]
show_path_markers = false;

$fn = quality;
EPS = 0.01;

function lerp(a,b,t) = a + (b-a)*t;
function bez2(p0,p1,p2,t) =
    let(u=1-t)
    [u*u*p0[0] + 2*u*t*p1[0] + t*t*p2[0],
     u*u*p0[1] + 2*u*t*p1[1] + t*t*p2[1]];

function point_on(center, rx, ry, a) =
    [center[0] + rx*cos(a), center[1] + ry*sin(a)];

top_center = [-top_radius, neck_length/2];
bottom_center = [bottom_radius, -neck_length/2];

top_connection = [0, neck_length/2];
bottom_connection = [0, -neck_length/2];

// A clockwise sweep from top_sweep to 0° approaches the right tangent from
// above, then continues down the neck. The earlier reconstruction used
// 360-top_sweep..360, which put the opening and incoming arc on the wrong side.
top_start_angle = top_sweep;
top_points = [
    for (i=[0:path_steps])
        let(a = lerp(top_start_angle, 0, i/path_steps))
        point_on(top_center, top_radius, top_radius, a)
];

// Neck runs from upper right tangent to lower left tangent.
// A quadratic Bezier allows an optional sideways bow. Larger neck_curve values
// deliberately turn the join tangent while preserving its downward direction.
neck_control = [neck_curve, 0];
neck_points = [
    for (i=[1:path_steps-1])
        bez2(top_connection, neck_control, bottom_connection, i/path_steps)
];

// Lower path deliberately STARTS at 180° (left tangent point).
bottom_points = [
    for (i=[0:path_steps])
        let(a = lerp(180, 180 + bottom_sweep, i/path_steps))
        point_on(bottom_center, bottom_radius, bottom_radius, a)
];

hook_path = concat(top_points, neck_points, bottom_points);

function vsub(a,b) = [a[0]-b[0], a[1]-b[1]];
function vlen(v) = sqrt(v[0]*v[0] + v[1]*v[1]);
function vnorm(v) = let(l=max(EPS,vlen(v))) [v[0]/l,v[1]/l];
function vdot(a,b) = a[0]*b[0] + a[1]*b[1];

// Discrete direction checks protect the reconstructed 0°/180° joins. The
// vectors need to continue in the same general direction; neck_curve is allowed
// to change the exact tangent as part of its documented shape control.
top_incoming = vsub(top_points[len(top_points)-1], top_points[len(top_points)-2]);
neck_outgoing = vsub(neck_points[0], top_connection);
neck_incoming = vsub(bottom_connection, neck_points[len(neck_points)-1]);
bottom_outgoing = vsub(bottom_points[1], bottom_points[0]);
assert(vlen(vsub(top_points[len(top_points)-1], top_connection)) < EPS,
       "Upper arc must end at the neck connection");
assert(vlen(vsub(bottom_points[0], bottom_connection)) < EPS,
       "Lower arc must start at the neck connection");
assert(vdot(vnorm(top_incoming), vnorm(neck_outgoing)) > 0,
       "Upper arc and neck must continue in the same general direction");
assert(vdot(vnorm(neck_incoming), vnorm(bottom_outgoing)) > 0,
       "Neck and lower arc must continue in the same general direction");

function tip_extended_point(p0,p1,amount) =
    let(v=vnorm(vsub(p0,p1)))
    [p0[0]+v[0]*amount,p0[1]+v[1]*amount];

path_with_tips =
    tip_extension > 0
    ? concat(
        [tip_extended_point(hook_path[0],hook_path[1],tip_extension)],
        hook_path,
        [tip_extended_point(
            hook_path[len(hook_path)-1],
            hook_path[len(hook_path)-2],
            tip_extension
        )]
      )
    : hook_path;

module flat_node(p, d=flat_width) {
    translate([p[0],p[1],0]) circle(d=d);
}

module flat_path(points) {
    linear_extrude(height=flat_thickness)
        union()
            for (i=[0:len(points)-2])
                hull() {
                    flat_node(points[i]);
                    flat_node(points[i+1]);
                }
}

module round_node(p, d=rod_diameter, zratio=1) {
    translate([p[0],p[1],rod_diameter*zratio/2])
        scale([1,1,zratio])
            sphere(d=d);
}

module round_path(points, zratio=1) {
    union()
        for (i=[0:len(points)-2])
            hull() {
                round_node(points[i], rod_diameter, zratio);
                round_node(points[i+1], rod_diameter, zratio);
            }
}

module tip_features(points) {
    if (tip_style == "Bulb") {
        if (profile == "Flat") {
            linear_extrude(height=flat_thickness) {
                translate(points[0]) circle(d=flat_width*tip_bulb_scale);
                translate(points[len(points)-1]) circle(d=flat_width*tip_bulb_scale);
            }
        } else {
            zr = profile == "Oval" ? oval_z_ratio : 1;
            round_node(points[0], rod_diameter*tip_bulb_scale, zr);
            round_node(points[len(points)-1], rod_diameter*tip_bulb_scale, zr);
        }
    } else if (tip_style == "Rounded") {
        // Base path already ends in round nodes/caps.
    }
}

module reinforcement() {
    if (neck_reinforcement > 0) {
        if (profile == "Flat") {
            linear_extrude(height=flat_thickness)
                hull() {
                    translate(top_connection) circle(d=flat_width + 2*neck_reinforcement);
                    translate(bottom_connection) circle(d=flat_width + 2*neck_reinforcement);
                }
        } else {
            zr = profile == "Oval" ? oval_z_ratio : 1;
            for (p=[top_connection,bottom_connection])
                round_node(p,rod_diameter+2*neck_reinforcement,zr);
        }
    }
}

module hook() {
    scale([overall_scale_x,overall_scale_y,1])
    union() {
        if (profile == "Flat")
            flat_path(path_with_tips);
        else if (profile == "Oval")
            round_path(path_with_tips,oval_z_ratio);
        else
            round_path(path_with_tips,1);

        tip_features(path_with_tips);
        reinforcement();
    }
}

module markers() {
    if (show_path_markers)
        color("red")
            for (p=hook_path)
                translate([p[0],p[1],rod_diameter+2])
                    sphere(d=max(0.8,rod_diameter*0.18));
}

echo("S-Hook Generator — reconstructed corrected edition");
echo("Upper connection", top_connection, "upper arc terminates at 0 degrees");
echo("Lower connection", bottom_connection, "lower arc begins at 180 degrees");
echo("Profile", profile, "Top sweep", top_sweep, "Bottom sweep", bottom_sweep);

hook();
markers();
