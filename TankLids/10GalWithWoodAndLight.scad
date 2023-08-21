use <parts/cutouts/GothicWindow.scad>

$fa = 1;
// $fs = 0.4;
$fs = .15;

// tank dimensions
MAX_WIDTH = 496.5;
MAX_DEPTH = 248.25;
LIP_DEPTH = 7;

// Accesory dimensions
// existing lamp
LAMP_WIDTH = 265;
LAMP_DEPTH = 55;
LAMP_DEPTH_INSET = 11 / 2;
LAMP_WIDTH_INSET_NORTH = 20 / 2;
LAMP_WIDTH_INSET_SOUTH = 35 / 2;
LAMP_REST_DEPTH = 3.1;
LAMP_REST_WIDTH = 54;

// filter wood protrusion
WOOD_OPENING_WIDTH_LIMIT = 160;
WOOD_OPENING_DEPTH_LIMIT = 75;

// net cup
NET_CUP_LIP_DIAMETER = 54.4;
NET_CUP_UPPER_DIAMETER = 50;

// wires and tubes baselines
AIR_LINE_DIAMETER = 8;
WATER_LINE_DIAMETER = 21;
WIRE_DIAMETER = 7;

ACCESSORY_CUTOUT_GAP = 23;


module MainSheet() {
    square([MAX_WIDTH, MAX_DEPTH]);
}

module WoodCutout() {
    rotate([0, 90, 0])
    // translate([MAX_WIDTH - WOOD_OPENING_WIDTH_LIMIT - LIP_DEPTH - 2, LIP_DEPTH + 4, 0])
        #GothicWindow(WOOD_OPENING_DEPTH_LIMIT, WOOD_OPENING_WIDTH_LIMIT);
}

module TenGallonLid() {
    difference() {
        MainSheet();
        WoodCutout();
    }
}

// TenGallonLid();

// RoundedCutout(40, 60);
// MainSheet();
rotate([45, 0, 0])
GothicWindow(40, 60);