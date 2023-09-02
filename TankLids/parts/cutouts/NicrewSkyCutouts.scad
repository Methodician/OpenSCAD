// $fa = 1;
// // $fs = 0.4;
// $fs = .15;

// tank dimensions
max_width = 496.5;
max_depth = 248.25;
lip_depth = 7;

// lamp dimensions
lamp_width = 265;
lamp_depth = 55;
lamp_thckness = 11;
lamp_inset_depth = 11 / 2;
lamp_inset_width_left = 20 / 2;
lamp_inset_width_rigth = 35 / 2;
lamp_rest_depth = 3.1;
lamp_rest_width = 54;
lamp_base_height = 19.5;
lamp_rest_min_width = 303;
lamp_rest_max_width = 494;



module NicrewSkySupportGap() {
    union() {
        translate([lamp_rest_depth / 2, 0, 0])
            square([lamp_rest_width - lamp_rest_depth, lamp_rest_depth]);
        translate([lamp_rest_depth / 2, lamp_rest_depth / 2, 0])
            circle(d = lamp_rest_depth);
        translate([lamp_rest_width - lamp_rest_depth / 2, lamp_rest_depth / 2, 0])
            circle(d = lamp_rest_depth);
    }
}

module _ExampleLid() {
    square([max_width, max_depth]);
}

module LampBodyPlaceholder() {
    %cube([lamp_width, lamp_depth, lamp_thckness]);
}

module AdjustableWdithNicrewSupportGaps(width) {
    if (width == undef) {
        echo("width is undefined");
    } else if (width < lamp_rest_min_width) {
        echo("Width too small. Setting to minimum width");
    } else if (width > lamp_rest_max_width) {
        echo("Width too large. Setting to maximum width");
    }

    _width =  width == undef || width < lamp_rest_min_width ? lamp_rest_min_width : width > lamp_rest_max_width ? lamp_rest_max_width : width;
    
    module leftSupportGap() {
        rotate([180, 0, 90])
            NicrewSkySupportGap();
    }

    module rightSupportGap() {
        translate([_width - lamp_rest_depth, 0, 0])
            rotate([180, 0, 90])
                NicrewSkySupportGap();
    }

    leftSupportGap();
    rightSupportGap();
}

module LampLightCutout() {
    translate([lamp_inset_width_left, lamp_inset_depth, 0])
        square([lamp_width - lamp_inset_width_left - lamp_inset_width_rigth, lamp_depth - lamp_inset_depth * 2]);
}

module NicrewSkyCombinedCutouts(lampRestWidth) {
    if (lampRestWidth == undef) {
        echo("width is undefined");
    } else if (lampRestWidth < lamp_rest_min_width) {
        echo("Width too small. Setting to minimum width");
    } else if (lampRestWidth > lamp_rest_max_width) {
        echo("Width too large. Setting to maximum width");
    }

    _width =  lampRestWidth == undef || lampRestWidth < lamp_rest_min_width ? lamp_rest_min_width : lampRestWidth > lamp_rest_max_width ? lamp_rest_max_width : lampRestWidth;
    
    translate([_width / 2 - lamp_width / 2, 0]) {
        LampLightCutout();
        translate([0, 0, lamp_base_height])
            LampBodyPlaceholder();
    }
    AdjustableWdithNicrewSupportGaps(width = _width);
}



difference() {
    _ExampleLid();
    translate([max_width / 2 - 315 / 2, max_depth / 2 - lamp_depth / 2, 0]) {
        NicrewSkyCombinedCutouts(lampRestWidth = 315);
    }
}
