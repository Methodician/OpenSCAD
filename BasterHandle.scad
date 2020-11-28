$fa = 1;
$fs = 0.4;

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
// rubber lip diameter seam sides: 33.65
// rubber lip diameter print sides: 32.3
// bubble height: 50
// bubble diameter: 64

CLAMPER_HEIGHT = 5;
CLAMPER_THICKNESS = 3;

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

    difference(){
        OuterCircle();
        InnerCircle();
        translate([0, TOP_PRINT_DIA*.45, 0]) {
            CircleGap();
        }
    }
}

HANDLE_ATTCHMENT_THICKNESS = 5;
module Handle() {
    cube(size=[HANDLE_ATTCHMENT_THICKNESS, HANDLE_ATTCHMENT_THICKNESS, HANDLE_ATTCHMENT_THICKNESS], center=true);
}


// ClamperRing();



// FOR DISPLAY AND WORKING

ClamperRing();
translate([0, -(TOP_PRINT_DIA/2 + HANDLE_ATTCHMENT_THICKNESS/2), 0]) {
    Handle();
}
// translate([0, 0, GUIDE_HEIGHT]) {
//     Guide();
// }
// translate([0, 0, BASE_HEIGHT/2]) {
//     Base();
// }
// GuideSide();

// FOR PRINTING
// translate([0, 0, GUIDE_DEPTH/2]) {
//     rotate([-90, 0, 0]) {
//         Guide(); 
//     }
// }
// translate([0, 0, BASE_HEIGHT/2]) {
//     Base();
// }