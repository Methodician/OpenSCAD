outerDiameter = 100;
innerDiameter = 10;
mainHeight = 30;
fn=80;

// linear_extrude(height=50, scale=4)
// circle(d=10);

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
    circle(d=innerDiameter, $fn=fn);
}

module OuterReduction(){

    difference() {
        Outside();
         Inside();
    }

    module Inside() {
        linear_extrude(mainHeight)
        circle(d=innerDiameter + 3, $fn=fn);
    }
    module Outside() {
        linear_extrude(mainHeight)
        circle(d=outerDiameter, $fn=fn);
    }
}

module GuideRidge() { 
    // translate([0,0,mainHeight - 5])
    // mirror([0,0,1])
    linear_extrude(height=mainHeight / 2, scale=3)
        circle(d=innerDiameter / 2, $fn=fn);
}

module Base() { 
    linear_extrude(height=mainHeight, scale=0)
    circle(d=outerDiameter, $fn=fn);
}