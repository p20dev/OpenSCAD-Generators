// Generated public single-file edition of the OpenSCAD Collection storage system.
// Canonical files: core.scad + storage.scad. Do not edit this generated copy.
// OpenSCAD Collection: shared dimensions for the storage family.
// All dimensions are millimetres. Clearance is radial/per side.

function storage_inner_x(x, wall) = x - 2 * wall;
function storage_inner_y(y, wall) = y - 2 * wall;
function storage_lid_outer_x(x, lid_wall, fit) = x + 2 * (lid_wall + fit);
function storage_lid_outer_y(y, lid_wall, fit) = y + 2 * (lid_wall + fit);

module storage_validate(x, y, h, wall, floor_thickness, fit, lid_wall, lid_top, skirt, divider_height, divider_floor) {
    assert(x >= 40 && x <= 200, "Outer X must be 40..200 mm");
    assert(y >= 40 && y <= 200, "Outer Y must be 40..200 mm");
    assert(h >= 20 && h <= 150, "Outer height must be 20..150 mm");
    assert(wall >= 1.6 && wall <= 6, "Wall must be 1.6..6 mm");
    assert(floor_thickness >= 1.6 && floor_thickness <= 6, "Floor must be 1.6..6 mm");
    assert(fit >= 0.15 && fit <= 0.8, "Clearance must be 0.15..0.8 mm per side");
    assert(lid_wall >= 1.6 && lid_wall <= 6, "Lid wall must be 1.6..6 mm");
    assert(lid_top >= 1.6 && lid_top <= 6, "Lid top must be 1.6..6 mm");
    assert(skirt >= 3 && skirt <= 20, "Lid skirt must be 3..20 mm");
    assert(divider_floor >= 1.2 && divider_floor <= 5, "Divider floor must be 1.2..5 mm");
    assert(storage_inner_x(x, wall) > 12 && storage_inner_y(y, wall) > 12, "Box interior is too small");
    assert(h > floor_thickness + skirt + 2, "Box is too short for lid skirt");
    assert(divider_height >= divider_floor + 5 && divider_height <= h - floor_thickness - 2,
           "Divider must fit below the box rim");
    children();
}

module storage_box(x, y, h, wall, floor_thickness) {
    difference() {
        cube([x, y, h]);
        translate([wall, wall, floor_thickness])
            cube([storage_inner_x(x, wall), storage_inner_y(y, wall), h - floor_thickness + 0.01]);
    }
}

// Print top face on the bed. Turn the lid over to put it on the box.
module storage_lid(x, y, fit, lid_wall, lid_top, skirt) {
    outer_x = storage_lid_outer_x(x, lid_wall, fit);
    outer_y = storage_lid_outer_y(y, lid_wall, fit);
    difference() {
        cube([outer_x, outer_y, lid_top + skirt]);
        translate([lid_wall, lid_wall, lid_top])
            cube([x + 2 * fit, y + 2 * fit, skirt + 0.01]);
    }
}

// A removable two-compartment insert. Its floor keeps the partition upright.
module storage_divider(x, y, wall, fit, divider_floor, divider_height, divider_wall) {
    insert_x = storage_inner_x(x, wall) - 2 * fit;
    insert_y = storage_inner_y(y, wall) - 2 * fit;
    assert(insert_x > 2 * divider_wall && insert_y > 2 * divider_wall,
           "Divider has no usable compartments");
    union() {
        cube([insert_x, insert_y, divider_floor]);
        translate([0, (insert_y - divider_wall) / 2, divider_floor])
            cube([insert_x, divider_wall, divider_height - divider_floor]);
    }
}

// OpenSCAD Customizer entrypoint. Export each part separately.
// Keep identical settings for box, lid, and divider.

/* [Part] */
part = "box"; // [box, lid, divider]

/* [Outer dimensions, mm] */
outer_x = 120; // [40:1:200]
outer_y = 80;  // [40:1:200]
outer_h = 50;  // [20:1:150]

/* [Print and fit, mm] */
wall = 2.4;             // [1.6:0.2:6]
floor_thickness = 2.4;  // [1.6:0.2:6]
fit_clearance = 0.35;   // [0.15:0.05:0.8] Per side; increase for tight printers.

/* [Lid, mm] */
lid_wall = 2.0; // [1.6:0.2:6]
lid_top = 2.4;  // [1.6:0.2:6]
lid_skirt = 8;  // [3:1:20]

/* [Divider, mm] */
divider_floor = 1.6; // [1.2:0.2:5]
divider_wall = 2.0;  // [1.6:0.2:6]
divider_height = 30; // [7:1:140]
effective_divider_height = min(divider_height, outer_h - floor_thickness - 2);
storage_validate(outer_x, outer_y, outer_h, wall, floor_thickness,
                 fit_clearance, lid_wall, lid_top, lid_skirt,
                 effective_divider_height, divider_floor) {
    if (part == "box")
        storage_box(outer_x, outer_y, outer_h, wall, floor_thickness);
    else if (part == "lid")
        storage_lid(outer_x, outer_y, fit_clearance, lid_wall, lid_top, lid_skirt);
    else if (part == "divider")
        storage_divider(outer_x, outer_y, wall, fit_clearance,
                        divider_floor, effective_divider_height, divider_wall);
    else
        assert(false, str("Unknown part: ", part));
}
