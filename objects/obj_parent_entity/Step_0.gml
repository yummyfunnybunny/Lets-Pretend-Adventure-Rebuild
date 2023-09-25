/// @desc Update Entity

// update Depth if necessary
if (y != y_prev || z_bottom != z_prev) {
	set_depth();
}
// update x_prev & y_prev
if (x != x_prev) x_prev = x;
if (y != y_prev) y_prev = y;

// update z_prev and z_top
if (z_prev != z_bottom) {
	z_prev = z_bottom;
	z_top = z_bottom - z_height;
}

// Apply z_speed
if (z_speed != 0){
	z_bottom += z_speed;
}

// Apply Grav_ity
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
	// check if ent_ity _is currently on a p_itfall
	if (tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
		// ent_ity _is on a p_itfall
		on_ground = false;
	} else {
		// ent_ity _is on ground
		on_ground = true;
		z_speed = 0;
	}
} else if (z_bottom < z_floor){
	on_ground = false;
}


// set z l_im_its
if (x != x_prev || y != y_prev) {
	set_z_limits();
}