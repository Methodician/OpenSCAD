




module Ring() {
    difference() {
        union() {
            MainDisk();
            InnerSupport();
            OuterRing();
        }
        MaterialReducer();
        InnerGap();
    }

module InnerGap() {
    linear_extrude(height=10)
            square(40, center=true);
}
    
module InnerSupport() {
    linear_extrude(height=10)
        square(43, center=true);
}

module MainDisk() {
    difference() {
        linear_extrude(height=4)
            circle(d=87);
        RingFrom(35, 12)
            translate([0,0,1])
            linear_extrude(height=3)
                circle(d=15);

    }
}

module OuterRing() {
    difference() {
        linear_extrude(height=7)
            circle(d=91);
        linear_extrude(height=7)
            circle(d=87);
    }

}
module MaterialReducer() {
    translate([0,0,11])
        RingFrom(36, 12)
            rotate([90,0,0])
            linear_extrude(height=10)
                circle(r=10);
}

}

union(){
    translate([0,0,3])
        Net();
    Ring();

}



module Net() {
    rotate([0,0,45])
        difference() {
            Frame();
                OuterGaps(); 
                CoreGap();
        }
}

module Frame() {
    linear_extrude(height=42, scale=0.9)
        square(33, center=true);
}

module CoreGap() {
    union(){
        rotate([0,0,45])
            linear_extrude(height=38, scale=0.9)
                square(40, center=true);
        linear_extrude(height=38, scale=0.9)
            square(29, center=true);
    }
}

module OuterGaps() {
    RingFrom(24, 4)
        rotate([0,0,45])
            linear_extrude(height=42)
                square(31, center=true);
}


// flexible/helpers
module RingFrom(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}