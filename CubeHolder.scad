




union(){
    translate([0,0,3])
        Net();
    Disk();

}

module Disk() {
    difference() {
        union() {
            DMainDisk();
            DCubeSupport();
            DLipSupport();
        }
        DMaterialReducer();
        DInnerGap();
    }
}

module DCubeSupport() {
    linear_extrude(height=10)
        square(43, center=true);
}

module DMainDisk() {
    difference() {
        linear_extrude(height=3)
            circle(d=87);
        #RingFrom(37, 12)
            translate([0,0,2])
            linear_extrude(height=3)
                circle(d=18);

    }
}

module DInnerGap() {
    linear_extrude(height=10)
            square(40, center=true);
}

module DLipSupport() {
    difference() {
        linear_extrude(height=7)
            circle(d=75.5);
        linear_extrude(height=7)
            circle(d=71.5);
    }

}

module DMaterialReducer() {
    translate([0,0,11])
        RingFrom(34, 12)
            rotate([90,0,0])
            linear_extrude(height=10)
                circle(r=10);
}



module Net() {
    rotate([0,0,45])
        difference() {
            NFrame();
                NOuterGaps(); 
                NCoreGap();
        }
}

module NFrame() {
    linear_extrude(height=42, scale=0.9)
        square(33, center=true);
}

module NCoreGap() {
    union(){
        rotate([0,0,45])
            linear_extrude(height=38, scale=0.9)
                square(40, center=true);
        linear_extrude(height=38, scale=0.9)
            square(29, center=true);
    }
}

module NOuterGaps() {
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