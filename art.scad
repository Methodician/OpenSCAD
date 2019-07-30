
// The idea is to twist a translated circle:
// -
/*
	linear_extrude(height = 10, twist = 360, scale = 0)
	translate([1,0])
	circle(r = 1);
*/

module horn(height = 10, radius = 3, 
			twist = 720, $fn = 50) 
{
	// A centered circle translated by 1xR and 
	// twisted by 360° degrees, covers a 2x(2xR) space.
	// -
	radius = radius/4;
	// De-translate.
	// -
	translate([-radius,0])
	// The actual code.
	// -
	linear_extrude(height = height, twist = twist, 
				   scale=0, $fn = $fn)
	translate([radius,0])
	circle(r=radius);
}

// translate([3,0])
// mirror(0)
// horn(50, 15);

// translate([-3,0])
// horn(50, 15);

// RingFrom(48,12)
//     dodechaSnowman(5);

module dodechaSnowman(scale) {
    translate([0, 0, scale*4+scale*2]) {
        dodechaTrio(scale);
    }
}

//create a dodecahedron by intersecting 6 boxes
module dodecahedron(height) 
{
	scale([height,height,height]) //scale by height parameter
	{
		intersection(){
			//make a cube
			cube([2,2,1], center = true); 
			intersection_for(i=[0:4]) //loop i from 0 to 4, and intersect results
			{ 
				//make a cube, rotate it 116.565 degrees around the X axis,
				//then 72*i around the Z axis
				rotate([0,0,72*i])
					rotate([116.565,0,0])
					cube([2,2,1], center = true); 
			}
		}
	}
}

module dodechaTrio(scale) {
    //create 3 stacked dodecahedra 
    //call the module with a height of 1 and move up 2
    translate([0,0,scale*2])dodecahedron(scale); 
    //call the module with a height of 2
    dodecahedron(scale*2); 
    //call the module with a height of 4 and move down 4
    translate([0,0,-scale*4])dodecahedron(scale*4);
}

// helpers
module RingFrom(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}