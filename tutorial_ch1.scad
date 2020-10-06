
// $fa = 1;
// $fs = 0.4;
adjoiningTranslateReduction = 0.001;


// translate([0,0,10])
//     cube([40, 30, 20], center=true);

// translate([0,0,20])
//     Roof();

// s = -15;
// e = -20;
// n = 15;
// w = 20;

// module Roof() {
//     polyhedron( 
//         points=[ [w, n, 0 ], [w, s, 0], [e, s, 0], [e, n, 0], [0, 0, 10]],
//         faces=[ [0,1,4], [1,2,4], [2,3,4],[3,0,4], [1,2,3], [1,0,3]]
//     );
// }





baseHeight = 10;
topHeight = 15;
carLength = 60;
carWidth = 20;
wheelWidth = 5;
wheelRadius = 10;
wheelDiameter = wheelRadius * 2;
wheelTurn = 13;
bodyRotation = -2;
axilLength = 30;
axilRadius = 2;

Car();
// Wheel();

module Car() {
    rotate([bodyRotation,0,0])
        CarBody();
    FrontRightWheel();
    FrontLeftWheel();
    BackRightWheel();
    BackLeftWheel();
    FrontAxil();
    RearAxil();
}


module FrontAxil() {
    translate([ -carLength/3, 0, 0])
    Axil();
}

module RearAxil() {
    translate([ carLength/3, 0, 0])
    Axil();
}

module Axil() {
    rotate([90,0,0])
        cylinder(h=axilLength, r=axilRadius, center=true);
}

module CarBody() {
    CarTop();
    CarBase();
}

module CarBase() {
    resize([carLength, carWidth, baseHeight])
        sphere(d=carLength);
    // cube ([carLength,carWidth,baseHeight], center=true);
}

module CarTop() {
    translate([5,0, baseHeight/2  - adjoiningTranslateReduction])
    resize([carLength/2, carWidth, topHeight])
        sphere(d=carLength/2);
    // translate([5,0,(baseHeight+topHeight)/2  - adjoiningTranslateReduction])
    //     cube ([carLength/2,carWidth,topHeight], center=true);
}

module FrontLeftWheel () {
    translate([-carLength/3, -carWidth/2 - wheelWidth/2 - 2, 0])
    rotate([0,0,wheelTurn])
        Wheel();
    // translate([-carLength/3, -carWidth/2 - wheelWidth/2 - 2, 0])
    // rotate([90,0,wheelTurn])
    //     cylinder(h=wheelWidth, r=wheelRadius, center=true);
}
module FrontRightWheel () {
    translate([-carLength/3, carWidth/2 + wheelRadius/2 + 2, 0])
    rotate([0,0,wheelTurn])
        Wheel();
    // translate([-carLength/3, carWidth/2 + wheelWidth/2 + 2, 0])
    // rotate([90,0,wheelTurn])
    //     cylinder(h=wheelWidth, r=wheelRadius, center=true);
}

module BackLeftWheel() {
    translate([carLength/3, -carWidth/2 - wheelWidth/2 - 2, 0])
        Wheel();
    // translate([carLength/3, -carWidth/2 - wheelWidth/2 - 2, 0])
    // rotate([90,0,0])
    //     cylinder(h=wheelWidth, r=wheelRadius, center=true);
}

module BackRightWheel() {
    translate([carLength/3, carWidth/2 + wheelWidth/2 + 2, 0])
        Wheel();
    // translate([carLength/3, carWidth/2 + wheelWidth/2 + 2, 0])
    // rotate([90,0,0])
    //     cylinder(h=wheelWidth, r=wheelRadius, center=true);
}

module Wheel() {
    sideSphereRadius = 50;
    hubGap = 4;
    cylinderHeight = wheelRadius;
    cylinderRadius = 2;
    
    // difference(){
    //     sphere(r=wheelRadius);
    //     translate([0,sideSphereRadius + hubGap/2, 0])
    //         sphere(r=sideSphereRadius);
    //     translate([0,-(sideSphereRadius + hubGap/2), 0])
    //         sphere(r=sideSphereRadius);
    //     translate([-wheelRadius/2,0,0])
    //         WheelHole();
    //     translate([wheelRadius/2,0,0])
    //         WheelHole();
    //     translate([0,0,wheelRadius/2])
    //         WheelHole();
    //     translate([0,0,-wheelRadius/2])
    //         WheelHole();
    // }

    difference() {
        resize([wheelDiameter,wheelWidth,wheelDiameter])
            sphere(r=wheelRadius);
        translate([-wheelRadius/2,0,0])
            WheelHole();
        translate([wheelRadius/2,0,0])
            WheelHole();
        translate([0,0,wheelRadius/2])
            WheelHole();
        translate([0,0,-wheelRadius/2])
            WheelHole();
    }
    
    
    module WheelHole() {
        rotate([90,0,0])
        cylinder(h=cylinderHeight, r=cylinderRadius, center=true);
    }
}



// // intersection(){
// //     cube(size=10, center=true);
// //     rotate([30,30,0])
// //         cube(size=10, center=true);
// //     rotate([0,30,300])
// //         cube(size=10, center=true);
// // }

// intersection(){
//     RingFrom(15, 6) {
//         circle(d=30);
//     }
// }


// // helpers
// module RingFrom(radius, count)
// {
//     for (a = [0 : count - 1]) {
//         angle = a * 360 / count;
//         translate(radius * [sin(angle), -cos(angle), 0])
//             rotate([0, 0, angle])
//                 children();
//     }
// }