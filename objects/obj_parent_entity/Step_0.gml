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
if (z_bottom > z_floor){
	z_bottom = z_floor;
	// check if entity is currently on a pitfall
	if (tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
		// entity is on a pitfall
		on_ground = false;
	} else {
		// entity is on ground
		on_ground = true;
		z_speed = 0;
	}
} else if (z_bottom < z_floor){
	on_ground = false;
}

// set z limits
if (x != xprevious || y != yprevious) {
	set_z_limits();
}

// update Depth if necessary
/*
if (y != yprevious || z_bottom != z_prev) {
	set_depth();
}
*/

#endregion

