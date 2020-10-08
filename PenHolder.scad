

$fa = 1;
$fs = 0.4;


baseDiameter = 50;
shaftDiameter = 11.36;
protrusionDiameter = shaftDiameter + 2.5;
protrusionHeight = 20;
baseHeight = 20;

difference(){
    Structural();
    translate([0,0,8])
        ShaftGap();
}

module Structural() {
    Base();
    translate([0,0,11])
        ShaftSupport();
    translate([0,0,13])
        Protrusion();
}

module Base(){

    difference(){
        baseBlob();
        baseFloorCutout();
    }

    module baseFloorCutout(){
        translate([0,0,-(baseHeight/2)])
            cylinder(d=baseDiameter, h=baseHeight/2);
    }

    module baseBlob(){
        translate([0,0,baseHeight/5])
        resize([baseDiameter, baseDiameter, baseHeight])
            sphere(d=baseDiameter);
    }
}

module Protrusion() {
    cylinder(d=protrusionDiameter, h=protrusionHeight);
}

module ShaftGap() {
    cylinder(d=shaftDiameter, h=protrusionHeight + 2);
    linear_extrude(height=protrusionHeight * 2, scale=3)
        circle(d=protrusionDiameter / 2);
}

module ShaftSupport() {
    sphere(d=protrusionDiameter * 1.5);
}



// outerDiameter = 40;
// innerDiameter = 11.36;
// mainHeight = 30;

// Holder();

// module Holder() {

//     difference(){
//         Base();
//         translate([0,0,3])
//             OuterReduction();
//         translate([0,0, 7])
//             GuideRidge();
//         translate([0,0,2])
//             InnerVoid();
//     }

// }



// module InnerVoid() {
//     linear_extrude(mainHeight)
//     circle(d=innerDiameter);
// }

// module OuterReduction(){

//     difference() {
//         Outside();
//         Inside();
//     }

//     module Inside() {
//         union(){
//             linear_extrude(mainHeight)
//                 circle(d=innerDiameter + 2);
//             translate([0,0,-15])
//                 Base();
//         }
//     }
//     module Outside() {
//         linear_extrude(mainHeight)
//             circle(d=outerDiameter);
//     }
// }

// module GuideRidge() { 
//     // translate([0,0,mainHeight - 5])
//     // mirror([0,0,1])
//     linear_extrude(height=mainHeight / 2, scale=3)
//         circle(d=innerDiameter / 2);
// }

// module Base() { 
//     linear_extrude(height=mainHeight, scale=0)
//     circle(d=outerDiameter);
// }