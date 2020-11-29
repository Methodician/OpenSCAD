$fa = 1;
// $fs = 0.4;
$fs = .15;

OVERLAP_FIXER_THING = 0.0008;

// measures in mm:
// top diameter seam sides: 25.6
TOP_SEAM_DIA = 25.7;
// top diameter print sides: 24.3
TOP_PRINT_DIA = 24.4;
// print width: < 19
PRINT_WIDTH = 19.3;
// bubble starts above rim: ~23
// rim diameter seam sides: 30.5
// rim diameter print side: 29
// rubber lip starts above rim buttom: 6
// rubber lip height: 17.8
// rubber lip diameter seam sides: 33.65
// rubber lip diameter print sides: 32.3
// bubble height: 50
// bubble diameter: 64

RUBBER_LIP_HEIGHT = 17.8;
RUBBER_LIP_DIAMETER = 33;
RUBBER_LIP_STARTS_UP = 6;
BUBBLE_HEIGHT = 50;
BUBBLE_DIAMETER = 64;
BUBBLE_STARTS_UP = 23;


CLAMPER_HEIGHT = 5;
CLAMPER_THICKNESS = 3;
HANDLE_ATTCHMENT_THICKNESS = RUBBER_LIP_DIAMETER - TOP_PRINT_DIA + 2;
HANDLE_ATTCHMENT_WIDTH = 12;
HANDLE_SHAFT_THICKNESS = 4;
HANDLE_SHAFT_WIDTH = 7;
HANDLE_PROTRUSION_LENGTH = 40;

module HandleShaft() {
    cube(size=[HANDLE_SHAFT_WIDTH, HANDLE_SHAFT_THICKNESS, CLAMPER_HEIGHT + OVERLAP_FIXER_THING], center=true);
}

module ClamperRing() {
    module InnerCircle() {
        linear_extrude(height = CLAMPER_HEIGHT + OVERLAP_FIXER_THING, center=true, convexity=10, twist=0) {
            resize([TOP_SEAM_DIA, TOP_PRINT_DIA, 0], true){
                circle(d=25);
            }
        }
    }

    module OuterCircle() {
        linear_extrude(height=CLAMPER_HEIGHT, center=true, convexity=10, twist=0) {
            resize([TOP_SEAM_DIA + CLAMPER_THICKNESS*2, TOP_PRINT_DIA + CLAMPER_THICKNESS*2, 0], true){
                circle(d=25);
            }
        }
    }

    module CircleGap() {
        cube(size=[PRINT_WIDTH, TOP_SEAM_DIA*.2 + CLAMPER_THICKNESS*2, CLAMPER_HEIGHT + OVERLAP_FIXER_THING], center=true);
    }

    module HandleAttachment() {
        difference() {
            cube(size=[HANDLE_ATTCHMENT_WIDTH, HANDLE_ATTCHMENT_THICKNESS, CLAMPER_HEIGHT], center=true);
            translate([0, -HANDLE_SHAFT_THICKNESS/3, 0]) {
                HandleShaft();
                // cube(size=[HANDLE_SHAFT_WIDTH, HANDLE_SHAFT_THICKNESS, CLAMPER_HEIGHT + OVERLAP_FIXER_THING], center=true);
            }
        }  
    }

    difference(){
        OuterCircle();
        InnerCircle();
        translate([0, TOP_PRINT_DIA*.45, 0]) {
            CircleGap();
        }
    }
    translate([0, -(TOP_PRINT_DIA/2 + HANDLE_ATTCHMENT_THICKNESS/2 + CLAMPER_THICKNESS - 1), 0]) {
        HandleAttachment();
    }
}



module Handle() {

    HandleShaft();
    translate([0, 0, RUBBER_LIP_HEIGHT/2 + 2.5 + CLAMPER_HEIGHT/2]) {
        // cube(size=[10, 7.5, RUBBER_LIP_HEIGHT], center=true);
        roundedcube(size = [HANDLE_ATTCHMENT_WIDTH, 7.5, RUBBER_LIP_HEIGHT + 5.5], center = true, radius = 1.3);
    }
    translate([0, -HANDLE_PROTRUSION_LENGTH * .4, RUBBER_LIP_HEIGHT + CLAMPER_HEIGHT/2 - 3]) {
        rotate([15, 0, 0]) {
            roundedcube(size = [HANDLE_ATTCHMENT_WIDTH, HANDLE_PROTRUSION_LENGTH, 7.5], center=true, radius = 1.3);
        }
    }
}


// ClamperRing();



// FOR DISPLAY AND WORKING

module Rubber() {
    cylinder(d=RUBBER_LIP_DIAMETER, h=RUBBER_LIP_HEIGHT, center=true);
    translate([0, 0, RUBBER_LIP_HEIGHT/2 + BUBBLE_HEIGHT/2 - 3]) {
        resize([BUBBLE_DIAMETER, BUBBLE_DIAMETER, BUBBLE_HEIGHT], true){
            sphere(d=BUBBLE_DIAMETER);
        }
    }
}

// translate([0, 0, RUBBER_LIP_HEIGHT/2 + RUBBER_LIP_STARTS_UP]) {
//     #Rubber();
// }

// ClamperRing();
// translate([0, -(TOP_PRINT_DIA/2 + HANDLE_ATTCHMENT_THICKNESS/2 + CLAMPER_THICKNESS + HANDLE_SHAFT_THICKNESS/3 - 1), 0]) {
//     Handle();
// }


// FOR PRINTING
// difference(){
//     translate([0, 0, 24.57]) {
//         rotate([165, 0, 0]) {
//             Handle();
//         }
//     }
//     translate([0, 0, -2.5]) {
//         cube(size=[70, 70, 5], center=true);
//     }
// }

translate([0, 0, CLAMPER_HEIGHT/2]) {
    ClamperRing();
}





// externals
// More information: https://danielupshaw.com/openscad-rounded-corners/
// License 2020-08-13: The only three people in this world who are allowed to use roundedcube.scad are named Dan Upshaw, Dan Fandrich, and @drohhyn

// Set to 0.01 for higher definition curves (renders slower)
// $fs = 0.15;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}