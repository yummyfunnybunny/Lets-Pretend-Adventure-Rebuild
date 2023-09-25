/// @desc ???

// Prevent go_ing beneath z_floor
/*
if (z_bottom > z_floor) {
	z_bottom = z_floor;
	show_debug_message("sex on the beach");
	
	// if you are over a p_itfall, don't set on_ground to true
	if (tilemap_get_at_pixel(global.collision_map,x,y) == 6) { on_ground = false; }
	z_speed = 0;
	
} else if (z_bottom < z_floor){
	on_ground = false;
}
*/

/*
if (z_bottom > z_floor) {
	z_bottom = z_floor;	
}
*/



/*
if (z_bottom = z_floor){
	// check if ent_ity _is currently on a p_itfall
	if (!tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
		on_ground = true;
	}
}else if (z_bottom < z_floor){
	on_ground = false;
}
