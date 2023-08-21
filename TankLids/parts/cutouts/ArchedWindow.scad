module ArchedWindow(width, depth, roundEnd, extraLength = 0) {
    if (roundEnd != "left" && roundEnd != "right" && roundEnd != "top" && roundEnd != "bottom") {
        echo("roundEnd must be either 'left', 'right', 'top', or 'bottom'");
    } else {
        translateX = roundEnd == "left" ? depth / 2 : 0;
        translateY = roundEnd == "bottom" ? width / 2 : 0;
        translate([translateX, translateY, 0]) {
            union() {
                squarePart();
                circlePart();
            }
        }
    }

    module squarePart() {
        width = roundEnd == "top" || roundEnd == "bottom" ? width : width - depth / 2 + extraLength;
        depth = roundEnd == "left" || roundEnd == "right" ? depth : depth - width / 2 + extraLength;

        square([width, depth]);
    }

    module circlePart() {
        diameter = roundEnd == "top" || roundEnd == "bottom" ? width : depth;

        translateX = 
            roundEnd == "right" ? width - depth / 2 + extraLength :
            roundEnd == "left" ? 0 :
            roundEnd == "top" ? width / 2 :
            roundEnd == "bottom" ? width / 2 :
            "invalid roundEnd";
        translateY =
            roundEnd == "right" ? depth / 2 :
            roundEnd == "left" ? depth / 2 :
            roundEnd == "top" ? depth - width / 2 + extraLength :
            roundEnd == "bottom" ? 0 :
            "invalid roundEnd";

        translate([translateX, translateY, 0])
            circle(d = diameter);
        }
}

%ArchedWindow(20, 10, "right", 30);