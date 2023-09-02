$fa = 1;
// $fs = 0.4;
$fs = .15;

use <parts/cutouts/ArchedWindow.scad>
use <parts/cutouts/NicrewSkyCutouts.scad>
// tank dimensions
max_width = 496.5;
max_depth = 248.25;
lip_depth = 7;

// light dimensions

// module _ExampleLid() {
//     square([max_width, max_depth]);
// }

// difference() {
//     _ExampleLid();
//     translate([max_width / 2, lip_depth + 10, 0])
//         NicrewSkyCombinedCutouts();
//     // ArchedWindow(40, 60, "left", 40);
// }

function s_curve(t) = [t, sin(6 * PI * t)];
    for (t = [0 : 1 : 100]) {
        translate(s_curve(t)) circle(1);
    }