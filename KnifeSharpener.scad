$fa = 1;
$fs = 0.4;

OVERLAP_FIXER_THING = 0.0008;

// Holder Base
GUIDE_WIDTH = 10;
BASE_WIDTH = 15;
BASE_DEPTH = 40;
BASE_HEIGHT = 5;
// Grinding Stone
STONE_WIDTH = 10;
STONE_DEPTH = 30;
STONE_HEIGHT = 3;


module BaseBody() {
    cube([BASE_WIDTH, BASE_DEPTH, BASE_HEIGHT], true);
}

module GuideRail(length) {
    rotate([90, 0, 0]) 
    linear_extrude(height = length, center = true, convexity = 10, twist = 0)
        polygon(points=[[0 - OVERLAP_FIXER_THING,0 - OVERLAP_FIXER_THING],[BASE_HEIGHT,0],[0,BASE_HEIGHT]], center=true);
}

module BaseIndent() {
    cube([STONE_WIDTH, STONE_DEPTH, STONE_HEIGHT + OVERLAP_FIXER_THING], true);
}

module BaseHandle() {
    translate([0,-73,0])
        sphere(d=BASE_HEIGHT);
    translate([0,73,0])
        sphere(d=BASE_HEIGHT);
    scale([1, 30, 1])
        sphere(d=BASE_HEIGHT);
}

module Base() {
    difference(){
        translate([0, 0, BASE_HEIGHT/2]){
            BaseBody();
            BaseHandle(); 
        }
        translate([BASE_WIDTH/2, 0, 0])
        rotate([0,270,0])
            GuideRail(BASE_DEPTH + OVERLAP_FIXER_THING);  
        translate([-BASE_WIDTH/2 - OVERLAP_FIXER_THING, 0, 0])
            GuideRail(BASE_DEPTH + OVERLAP_FIXER_THING);
        translate([0, 0, BASE_HEIGHT])
            BaseIndent();
    }
}


module GuideIndent(args) {
        cube([STONE_WIDTH, GUIDE_WIDTH + OVERLAP_FIXER_THING, STONE_HEIGHT + OVERLAP_FIXER_THING], true);
}

module GuideSlant() {
    translate([0, -BASE_WIDTH/3, BASE_HEIGHT]) {     
        rotate([90, 90, 90]){
            linear_extrude(height = BASE_WIDTH + GUIDE_WIDTH, center = true, convexity = 10, twist = 0){
                polygon(points=[[0 - OVERLAP_FIXER_THING,0 - OVERLAP_FIXER_THING],[BASE_HEIGHT,0],[0,GUIDE_WIDTH]], center=true);
            }
        }
    }
}

module GuideBody(){
    cube([BASE_WIDTH, GUIDE_WIDTH, BASE_HEIGHT], true);
}

module GuideSide() {
    translate([-BASE_WIDTH/2, 0, -BASE_HEIGHT]) {
        rotate([0, -90, 180]) {
            GuideRail(GUIDE_WIDTH);
        }
    }
    translate([-BASE_WIDTH/2, 0, 0]) {
        rotate([0, 90, 180]) {
            GuideRail(GUIDE_WIDTH);
        }
    }
    rotate([0, 0, 180]) {
        translate([BASE_WIDTH/2, 0, 0]) {
            GuideRail(GUIDE_WIDTH);
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
            translate([0, 0, BASE_HEIGHT/2]){
                GuideBody();
            }
        }
        GuideSlant();
        #GuideIndent();
    }
}

translate([0, 0, BASE_HEIGHT]) {
    Guide();
}
Base();

