$fa = 1;
$fs = 0.4;

OVERLAP_FIXER_THING = 0.0008;

// Guide
GUIDE_DEPTH = 17;
GUIDE_WIDTH = 35;
GUIDE_HEIGHT = 10;
// Holder Base
BASE_WIDTH = 35;
BASE_DEPTH = 120;
BASE_HEIGHT = 10;
// Grinding Stone
//24.33
STONE_WIDTH = 24.33;
//101.6
STONE_DEPTH = 101.6;
//6.95
STONE_HEIGHT = 6.95;


module Handle(length, diameter) {
 
    translate([0,length/2,0]){
        sphere(d=diameter);
    }
    intersection(){
        resize([diameter, length, diameter]){
            sphere(d=diameter);
        }
        translate([0, length/4 + diameter/4, 0]) {
            cube([diameter, length/2 + diameter/2, diameter], true);
        }
    }
}

module GuideRail(length) {
    rotate([90, 0, 0]) 
    linear_extrude(height = length, center = true, convexity = 10, twist = 0)
        polygon(points=[[0 - OVERLAP_FIXER_THING,0 - OVERLAP_FIXER_THING],[BASE_HEIGHT,0],[0,BASE_HEIGHT]], center=true);
}

module BaseBody() {
    cube([BASE_WIDTH, BASE_DEPTH, BASE_HEIGHT], true);
}

module Stone() {
    cube([STONE_WIDTH, STONE_DEPTH, STONE_HEIGHT + OVERLAP_FIXER_THING], true);
}

module Base() {
    difference(){
        translate([0, 0, BASE_HEIGHT/2]){
            BaseBody();
            translate([0, BASE_DEPTH/2, 0]){
                Handle(BASE_DEPTH, 8); 
            }
            rotate([0, 0, 180]) {
                translate([0, BASE_DEPTH/2, 0]){
                    Handle(BASE_DEPTH, 8); 
                }
            }
            
        }
        translate([BASE_WIDTH/2, 0, 0])
        rotate([0,270,0])
            GuideRail(BASE_DEPTH + OVERLAP_FIXER_THING);  
        translate([-BASE_WIDTH/2 - OVERLAP_FIXER_THING, 0, 0])
            GuideRail(BASE_DEPTH + OVERLAP_FIXER_THING);
        translate([0, 0, BASE_HEIGHT])
            Stone();
    }
}


module GuideIndent(args) {
        cube([STONE_WIDTH, GUIDE_DEPTH + OVERLAP_FIXER_THING, STONE_HEIGHT + OVERLAP_FIXER_THING], true);
}

module GuideSlant() {
    translate([0, -GUIDE_DEPTH/2, GUIDE_HEIGHT]) {     
        rotate([90, 90, 90]){
            linear_extrude(height = GUIDE_WIDTH * 3, center = true, convexity = 10, twist = 0){
                polygon(points=[[0 - OVERLAP_FIXER_THING,0 - OVERLAP_FIXER_THING],[GUIDE_HEIGHT,0],[0,GUIDE_DEPTH]], center=true);
            }
        }
    }
}

module GuideBody(){
    cube([GUIDE_WIDTH, GUIDE_DEPTH, GUIDE_HEIGHT], true);
}

module GuideSide() {
    translate([-BASE_WIDTH/2, 0, -GUIDE_HEIGHT]) {
        rotate([0, -90, 180]) {
            GuideRail(GUIDE_DEPTH);
        }
    }
    translate([-BASE_WIDTH/2, 0, 0]) {
        rotate([0, 90, 180]) {
            GuideRail(GUIDE_DEPTH);
        }
    }
    rotate([0, 0, 180]) {
        translate([BASE_WIDTH/2, 0, 0]) {
            GuideRail(GUIDE_DEPTH);
        }
    } 
}

module Guide() {
    difference() {
        union() {
            GuideSide();
            rotate([0, 0, 180]) {
                GuideSide();
            } 
            translate([0, 0, 5]){
                GuideBody();
            }
            translate([-BASE_WIDTH/2, 4.5, -4.5]) {
                rotate([0, 0, 90]) {
                    Handle(GUIDE_WIDTH*3, 8);
                }                  
            }
            translate([BASE_WIDTH/2, 4.5, -4.5]) {
                rotate([0, 0, -90]) {
                    Handle(GUIDE_WIDTH*3, 8);
                }                  
            }
        }
        GuideSlant();
        GuideIndent();
    }
}

// Handle(20,5);
translate([0, 0, GUIDE_HEIGHT]) {
    Guide();
}
Base();


