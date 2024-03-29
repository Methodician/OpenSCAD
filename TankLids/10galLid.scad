$fa = 1;
// $fs = 0.4;
$fs = .15;

THICKNESS = 2; // see if varying between about 1.5 and 10.0 changes quote much
OVERLAP_FIXER_THING = 0.002;
OVERLAP_FIXER_OFFEST = 0.001;
CUTOUT_THICKNESS = THICKNESS + OVERLAP_FIXER_THING;
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

module WireCutouts() {

    module allWireCutouts() {
        // left cutout
        translate([LIP_DEPTH + WIRE_DIAMETER / 2 - OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2 - ACCESSORY_CUTOUT_GAP, -OVERLAP_FIXER_OFFEST])
            rotate([0, 0, 180])
                wireCutoutBase();
        
        // right cutout
        translate([MAX_WIDTH - LIP_DEPTH - WIRE_DIAMETER / 2 + OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2 + ACCESSORY_CUTOUT_GAP, -OVERLAP_FIXER_OFFEST])
                wireCutoutBase();
    }

    module wireCutoutBase() {
        union() {
            wireCoutoutCircle();
            wireCoutoutSquare();
        }
    }

    module wireCoutoutCircle() {
        cylinder(h=CUTOUT_THICKNESS, d=WIRE_DIAMETER);
    }

    module wireCoutoutSquare() {
        translate([0, -WIRE_DIAMETER / 2, 0])
            cube([WIRE_DIAMETER / 2 + LIP_DEPTH, WIRE_DIAMETER, CUTOUT_THICKNESS]);
    }

    // wireCutoutBase();
    allWireCutouts();
}


module WaterLineCutouts() {

    module allWaterLineCutouts() {
        // left cutout
        translate([LIP_DEPTH + WATER_LINE_DIAMETER / 2 - OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2, -OVERLAP_FIXER_OFFEST])
            rotate([0, 0, 180])
                waterLineBase();

        // right cutout
        translate([MAX_WIDTH - LIP_DEPTH - WATER_LINE_DIAMETER / 2 + OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2, -OVERLAP_FIXER_OFFEST])
                waterLineBase();
    }
    module waterLineBase() {
        union() {
            waterLineCircle();
            waterLineSquare();
        }
    }
    module waterLineCircle() {
        cylinder(h=CUTOUT_THICKNESS, d=WATER_LINE_DIAMETER);
    }
    module waterLineSquare() {
        translate([0, -WATER_LINE_DIAMETER / 2, 0])
            cube([WATER_LINE_DIAMETER / 2 + LIP_DEPTH, WATER_LINE_DIAMETER, CUTOUT_THICKNESS]);
    }

    // waterLineBase();
    allWaterLineCutouts();

}

module AirlineCutouts() {
    module allAirlineCutouts() {
        // left cutout
        translate([LIP_DEPTH + AIR_LINE_DIAMETER / 2 - OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2 + ACCESSORY_CUTOUT_GAP, -OVERLAP_FIXER_OFFEST])
            rotate([0, 0, 180])
                airlineCutoutBase();

        // right cutout
        translate([MAX_WIDTH - LIP_DEPTH - AIR_LINE_DIAMETER / 2 + OVERLAP_FIXER_OFFEST, MAX_DEPTH / 2 - ACCESSORY_CUTOUT_GAP, -OVERLAP_FIXER_OFFEST])
                airlineCutoutBase();
    }
    module airlineCutoutBase() {

        union() {
            airLineCircle();
            airLineSquare();
        }
    }
    module airLineCircle() {
            cylinder(h=CUTOUT_THICKNESS, d=AIR_LINE_DIAMETER);
    }
    module airLineSquare() {
            translate([0, -AIR_LINE_DIAMETER / 2, 0])
                cube([AIR_LINE_DIAMETER / 2 + LIP_DEPTH, AIR_LINE_DIAMETER, CUTOUT_THICKNESS]);
    }

    allAirlineCutouts();
    // airlineCutoutBase();
    
}

module NetCupCutouts() {

    module allNetCupCoutouts() {
        // left cutout
        translate([LIP_DEPTH + 75, LIP_DEPTH + 55, -OVERLAP_FIXER_OFFEST])
            netCupCircle();

        // right cutout
        translate([MAX_WIDTH - LIP_DEPTH - 85, MAX_DEPTH - LIP_DEPTH - 100, -OVERLAP_FIXER_OFFEST])
            netCupCircle();
    }

    module netCupCircle() {
        cylinder(h=CUTOUT_THICKNESS, d=NET_CUP_UPPER_DIAMETER);
    }
    
    allNetCupCoutouts();
}


module LampBodyPlaceholder() {
    translate([MAX_WIDTH / 2 - LAMP_WIDTH / 2 + LIP_DEPTH * 2, MAX_DEPTH - LAMP_DEPTH - LIP_DEPTH * 2, 17]) {
        cube([LAMP_WIDTH, LAMP_DEPTH, CUTOUT_THICKNESS]);
    }
}

module LampCutout() {

    module lampCutoutBase() {
        lampOpening();
    }
    module lampRest() {
        module lampRestSquare() {
            translate([0, LAMP_REST_DEPTH, 0])
                cube([LAMP_REST_DEPTH, LAMP_REST_WIDTH - LAMP_REST_DEPTH * 2, CUTOUT_THICKNESS]);
        }
        module lampRestCircle1() {
            translate([LAMP_REST_DEPTH / 2, LAMP_REST_DEPTH, 0])
                cylinder(h=CUTOUT_THICKNESS, d=LAMP_REST_DEPTH);
        }
        module lampRestCircle2() {
            translate([LAMP_REST_DEPTH / 2, LAMP_REST_WIDTH - LAMP_REST_DEPTH, 0])
                cylinder(h=CUTOUT_THICKNESS, d=LAMP_REST_DEPTH);
        }
            lampRestCircle1();
            lampRestCircle2();
            lampRestSquare();
    }

    module lampOpening() {
        translate([LAMP_WIDTH_INSET_NORTH, LAMP_DEPTH_INSET, 0])
            cube([LAMP_WIDTH - LAMP_WIDTH_INSET_NORTH - LAMP_WIDTH_INSET_SOUTH, LAMP_DEPTH - LAMP_DEPTH_INSET * 2, CUTOUT_THICKNESS]);
    }
    
    translate([-OVERLAP_FIXER_THING, MAX_DEPTH - LAMP_DEPTH - LIP_DEPTH * 2, -OVERLAP_FIXER_OFFEST])
        lampRest();

    translate([MAX_WIDTH - LAMP_REST_DEPTH + OVERLAP_FIXER_THING, MAX_DEPTH - LAMP_DEPTH - LIP_DEPTH * 2, -OVERLAP_FIXER_OFFEST])
        lampRest();
        
    translate([MAX_WIDTH / 2 - LAMP_WIDTH / 2 + LIP_DEPTH * 2, MAX_DEPTH - LAMP_DEPTH - LIP_DEPTH * 2, -OVERLAP_FIXER_OFFEST]) {
        lampCutoutBase();
    }
}

module WoodCutout() {
    module woodCutoutBase() {
        union() {
            woodCutoutSquare();
            woodCutoutCircle();
        }
    }

    module woodCutoutSquare() {
        cube([WOOD_OPENING_WIDTH_LIMIT, WOOD_OPENING_DEPTH_LIMIT, CUTOUT_THICKNESS]);
    }

    module woodCutoutCircle() {
        translate([0, WOOD_OPENING_DEPTH_LIMIT / 2, 0])
            cylinder(h=CUTOUT_THICKNESS, d=WOOD_OPENING_DEPTH_LIMIT);
    }

    translate([MAX_WIDTH - WOOD_OPENING_WIDTH_LIMIT - LIP_DEPTH - 2, LIP_DEPTH + 4, -OVERLAP_FIXER_OFFEST])
        woodCutoutBase();
}

module MainSheet() {
    cube([MAX_WIDTH, MAX_DEPTH, THICKNESS]);
}

module TenGallonLid() {
    difference() {
        MainSheet();
        LampCutout();
        WoodCutout();
        NetCupCutouts();
        AirlineCutouts();
        WaterLineCutouts();
        WireCutouts();
    }
    // %LampBodyPlaceholder();
}

// projection() {
//     TenGallonLid();
// }
TenGallonLid();

// AirlineCutouts();

// WaterLineCutouts();

// WireCutouts();