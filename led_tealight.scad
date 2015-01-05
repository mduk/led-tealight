module header( pin_size, pins ) {
	header_depth = pin_size;
	header_width = header_depth * pins;
	header_height = pin_size * 5;

	translate( [ 0 - ( header_width / 2 ), 0 - ( header_depth / 2 ), 0 ] ) {
		union() {
			cube( [ header_width, header_depth, header_height ] );
			translate( [ 0, 0, (0 - header_depth) ] ) {
				cube( [ header_depth, header_depth, header_depth ] );
			}
			translate( [ ( header_depth * 2 ), 0, ( 0 - header_depth ) ] ) {
				cube( [ header_depth, header_depth, header_depth ] );
			}
		}
	}
}

module surround( pin_size, thickness ) {
	num_pins = 3;

	header_depth = pin_size;
	header_width = header_depth * num_pins;
	header_height = pin_size * 5;

	surround_depth = header_depth + ( thickness * 2 );
	surround_width = header_width + ( thickness * 2 );
	surround_height = 12;

	difference() {
		translate( [ 0 - ( surround_width / 2 ), 0 - ( surround_depth / 2 ), 0] ) {
			cube( [ surround_width, surround_depth, surround_height ] );
		}
		translate( [ 0, 0, thickness ] ) {
			header( pin_size, num_pins );
		}
	}
}

module tealight( radius, height, thickness ) {
	difference() {
		hull() cylinder( r = radius, height, $fn = ( radius * 3 ) );
		cylinder( r = ( radius - thickness ), ( height - thickness ), $fn = ( radius * 3 ) );
	}
}

module escapehole( diameter, length ) {
	radius = diameter / 2;
	faces = diameter * 3;
	union() {
		translate( [ 0, 0, diameter * 1.5 ] ) {
			rotate(90, [0, 1, 0]) {
				cylinder( r = radius, length, $fn = faces );
			};
		}
		translate( [ 0, 0 - radius, 0 ] ) {
			cube( [ length, diameter, diameter * 1.5 ] );
		};
	};
}

module ledtealight() {
	pin_size = 2.54;
	union() {
		difference() {
			tealight( 20, 15, 1 );
			
			translate( [ 0, 0, 10 ] ) {
				header( pin_size, 3 );
			};
			
			rotate( 90 ) {
				escapehole( 4, 20 );
			}
		}
		translate( [ 0, 0, 14 ] ) {
			surround( pin_size, 1 );
		}
	}
}

ledtealight();

