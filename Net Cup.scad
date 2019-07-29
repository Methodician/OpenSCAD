

difference() {
    union() {
        Lip();
        Outer();
        // Floor();
    }
    Inner();
}




// structural
module OuterGaps() {
    rotate([0,0,4])
    RingFrom(33,12)
        translate([0,0,3])
        rotate([-12,0,0])
        linear_extrude(height=28)
            square(7);
}

module Outer() {
    difference(){
        linear_extrude(height = 30, scale = 0.8)
            circle(31);
        OuterGaps();
    }
    
}

module Inner() {
    translate([0, 0, -1])
        linear_extrude(height = 31, scale = 0.8)
            circle(29);
}

module Lip() {
    Panel(34);
}

module Floor() {
    union(){
        difference() {
            Panel(9,30);
            Panel(7,30);
        }
        difference() {
            Panel(25, 30);
            translate([0, 0, 30])
            linear_extrude(height = 1)
                offset(1)
                    Star(24 ,[7,22,22,7]);
            translate([0,0,30]) rotate(23)
            linear_extrude(height = 1)
                RingFrom(21, 6)
                offset(2)
                    polygon(points = [[-4,0],[4,0],[0,8]]);
        }
    }
}


// flexible
module Panel(radius, zAxis=0) {
    translate([0, 0, zAxis])
        cylinder(h=1, r=radius);
}

module Star(num, radii) {
  function r(a) = (floor(a / 10) % 2) ? 10 : 8;
  polygon([for (i=[0:num-1], a=i*360/num, r=radii[i%len(radii)]) [ r*cos(a), r*sin(a) ]]);
}

module RingFrom(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}

module Triangle(size=7, zAxis=0) {
    translate([0, 0, zAxis])
    polygon(points = [[-size,0],[size,0],[0,size]]);
}