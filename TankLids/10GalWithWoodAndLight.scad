use <parts/cutouts/ArchedWindow.scad>
use <parts/cutouts/NicrewSkyCutouts.scad>

$fa = 1;
// $fs = 0.4;
$fs = .15;

// tank dimensions
max_width = 496.5;
max_depth = 248.25;
lip_depth = 7;

// Accesory dimensions
// existing lamp
lamp_rest_width = 315;
lamp_depth = 55;
// lamp_depth_inset = 8;
// lamp_width_inset = 15;
// filter wood protrusion
wood_opening_width_limit = 160;
wood_opening_depth_limit = 75;

// net cup
net_cup_lip_diameter = 54.4;
net_cup_upper_diameter = 50;

// wires and tubes baselines
airline_diemeter = 8;
waterline_diameter = 21;
wire_diameter = 7;



module MainSheet() {
    square([max_width, max_depth]);
}

module WoodCutout() {
    translate([max_width - wood_opening_width_limit - lip_depth - 2, lip_depth + 4, 0])
        ArchedWindow(wood_opening_width_limit, wood_opening_depth_limit, "left");
}

module LeftUtilityCutouts() {
    module wireCutout() {
        translate([0, max_depth / 2 - wire_diameter / 2 - waterline_diameter, 0])
            ArchedWindow(wire_diameter + lip_depth, wire_diameter, "right");
    }

    module airlineCutout() {
        translate([0, max_depth / 2 - airline_diemeter / 2 + waterline_diameter, 0])
            ArchedWindow(airline_diemeter + lip_depth, airline_diemeter, "right");
    }

    module waterlineCutout() {
        translate([0, max_depth / 2 - waterline_diameter / 2, 0])
            ArchedWindow(waterline_diameter + lip_depth, waterline_diameter, "right");
    }
    
    wireCutout();
    airlineCutout();
    waterlineCutout();
}

module RightUtilityCutouts() {
    module wireCutout() {
        translate([max_width - wire_diameter - lip_depth, max_depth / 2 - wire_diameter / 2 - waterline_diameter, 0])
            ArchedWindow(wire_diameter + lip_depth, wire_diameter, "left");
    }

    module airlineCutout() {
        translate([max_width - airline_diemeter - lip_depth, max_depth / 2 - airline_diemeter / 2 + waterline_diameter, 0])
            ArchedWindow(airline_diemeter + lip_depth, airline_diemeter, "left");
    }

    module waterlineCutout() {
        translate([max_width - waterline_diameter - lip_depth, max_depth / 2 - waterline_diameter / 2, 0])
            ArchedWindow(waterline_diameter + lip_depth, waterline_diameter, "left");
    }

    wireCutout();
    airlineCutout();
    waterlineCutout();
}

module LampOpening() {
    translate([max_width - lamp_rest_width - lip_depth - 10, max_depth - lamp_depth - lip_depth - 10, 0])
        NicrewSkyCombinedCutouts(lamp_rest_width);
}

module LidSplitter() {
    // An s-curve shaped line 1 unit thick
    module sCurve() {
        translate([0, 0, 0])
            linear_extrude(height = 1, center = true, convexity = 10)
                bezier_curve([[0, 0], [0, 1], [1, 1], [1, 0]]);
    }

    sCurve();
}

module TenGallonLid() {
    difference() {
        MainSheet();
        WoodCutout();
        LampOpening();
        LeftUtilityCutouts();
        RightUtilityCutouts();
    }
}

%TenGallonLid();
#LidSplitter();
