THICKNESS = 3; // see if varying between about 1.5 and 10.0 changes quote much
OVERLAP_FIXER_THING = 0.002;
OVERLAP_FIXER_OFFEST = 0.001;
CUTOUT_THICKNESS = THICKNESS + OVERLAP_FIXER_THING;
// tank dimensions
MAX_WIDTH = 495;
MAX_DEPTH = 250;
LIP_DEPTH = 7;

// Accesory dimensions
// existing lamp
LAMP_WIDTH = 265;
LAMP_DEPTH = 55;
LAMP_DEPTH_INSET = 11;
LAMP_WIDTH_INSET_NORTH = 20;
LAMP_WIDTH_INSET_SOUTH = 35;

// filter wood protrusion
WOOD_OPENING_WIDTH_LIMIT = 160;
WOOD_OPENING_DEPTH_LIMIT = 75;

// net cup
NET_CUP_LIP_DIAMETER = 54.4;
NET_CUP_UPPER_DIAMETER = 50;



module LampCutout() {
    translate([MAX_WIDTH / 2 - LAMP_WIDTH / 2, MAX_DEPTH - LAMP_DEPTH - LIP_DEPTH * 2, -OVERLAP_FIXER_OFFEST])
        cube([LAMP_WIDTH, LAMP_DEPTH, CUTOUT_THICKNESS]);
}


module WoodOpeningBase() {
    translate([MAX_WIDTH - WOOD_OPENING_WIDTH_LIMIT - LIP_DEPTH, LIP_DEPTH, 0])
        cube([WOOD_OPENING_WIDTH_LIMIT, WOOD_OPENING_DEPTH_LIMIT, CUTOUT_THICKNESS]);
}
module WoodOpeningRound() {
    translate([MAX_WIDTH - WOOD_OPENING_WIDTH_LIMIT - LIP_DEPTH, WOOD_OPENING_DEPTH_LIMIT / 2 + LIP_DEPTH, 0])
        cylinder(h=CUTOUT_THICKNESS, d=WOOD_OPENING_DEPTH_LIMIT);
}
module WoodCutout() {
    translate([0, 0, -OVERLAP_FIXER_OFFEST])
    union() {
        WoodOpeningBase();
        WoodOpeningRound();
    }
}
module MainSheet() {
    cube([MAX_WIDTH, MAX_DEPTH, THICKNESS]);
}

module TenGallonLid() {
    difference() {
        MainSheet();
        WoodCutout();
        LampCutout();
    }
}

translate([-MAX_WIDTH / 2, -MAX_DEPTH / 2, 0]) {
    TenGallonLid();
}