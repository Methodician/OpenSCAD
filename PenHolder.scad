outerDiameter = 100;
innerDiameter = 10;
mainHeight = 30;


$fa = 1;
$fs = 0.4;

Holder();

module Holder() {

    difference(){
        Base();
        translate([0,0,2])
            OuterReduction();
        translate([0,0, mainHeight / 2])
            GuideRidge();
        InnerVoid();
    }

}



module InnerVoid() {
    linear_extrude(mainHeight)
    circle(d=innerDiameter);
}

module OuterReduction(){

    difference() {
        Outside();
         Inside();
    }

    module Inside() {
        linear_extrude(mainHeight)
        circle(d=innerDiameter + 3);
    }
    module Outside() {
        linear_extrude(mainHeight)
        circle(d=outerDiameter);
    }
}

module GuideRidge() { 
    // translate([0,0,mainHeight - 5])
    // mirror([0,0,1])
    linear_extrude(height=mainHeight / 2, scale=3)
        circle(d=innerDiameter / 2);
}

module Base() { 
    linear_extrude(height=mainHeight, scale=0)
    circle(d=outerDiameter);
}