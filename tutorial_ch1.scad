
// $fa = 1;
// $fs = 0.4;
// adjoiningTranslateReduction = 0.001;


translate([0,0,10])
    cube([40, 30, 20], center=true);

translate([0,0,20])
    Roof();


// Roof();

s = -15;
e = -20;
n = 15;
w = 20;

module Roof() {
    polyhedron( 
        points=[ [w, n, 0 ], [w, s, 0], [e, s, 0], [e, n, 0], [0, 0, 10]],
        faces=[ [0,1,4], [1,2,4], [2,3,4],[3,0,4], [1,2,3], [1,0,3]]
    );
}





// carHeight = 10;
// carLength = 60;
// carWidth = 20;
// wheelWidth = 3;
// axilLength = 30;
// axilRadius = 2;

// CarBody();
// FrontRightWheel();
// FrontLeftWheel();
// BackRightWheel();
// BackLeftWheel();
// FrontAxil();
// RearAxil();

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
    cube ([carLength,carWidth,carHeight], center=true);
    translate([5,0,carHeight  - adjoiningTranslateReduction])
        cube ([carLength/2,carWidth,carHeight], center=true);
}

module BackLeftWheel() {
    mirror([1,0,0])
        mirror([0,1,0])
            FrontRightWheel();
}

module FrontLeftWheel () {
    mirror([0,1,0])
        FrontRightWheel();
}

module BackRightWheel() {
    mirror([1,0,0])
        FrontRightWheel();
}

module FrontRightWheel () {
    translate([-carLength/3, carWidth/2 + wheelWidth/2 + 2, 0])
    rotate([90,0,0])
        cylinder(h=wheelWidth, r=8, center=true);
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