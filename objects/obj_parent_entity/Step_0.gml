/// @desc Update Entity


#region UPDATE Z-AXIS

// update z_prev and z_top
if (z_prev != z_bottom) {
	z_prev = z_bottom;
	z_top = z_bottom - z_height;
}

// Apply z_speed
if (z_speed != 0){
	z_bottom += z_speed;
}

// Apply Gravity
if (z_bottom < z_floor){
	if (z_gravity != 0) {
		if (z_speed < z_max_fall_speed){
			z_speed += z_gravity;
		}
	}
}

// Prevent Exceeding z_max_fall_speed
if (z_max_fall_speed > 0) {
	if (z_speed >= z_max_fall_speed){
		z_speed = z_max_fall_speed;
	}
}

// Prevent going Above z_roof
if (z_top < z_roof){
	z_speed = 0;
	z_bottom = z_roof + z_height;
	z_top = z_bottom - z_height;
}

// update on_ground
if (z_bottom < z_floor) {
	on_ground = false;	
} else {
	z_bottom = z_floor;
	if (abs(z_speed) > 1) {
		z_speed = -z_speed*z_bounce;	
	} else {
		z_speed = 0;
		on_ground = true;	
	}
}

// set z limits
if (x != xprevious || y != yprevious) {
	set_z_limits();
}

#endregion

