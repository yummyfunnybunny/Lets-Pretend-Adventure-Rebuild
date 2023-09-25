event_inherited();

// Update All _input
player_update_input();
player_reset();

// update face direction
face_direction = point_direction(x,y,mouse_x,mouse_y);



player_apply_friction();



// Update Player max_speed
// do th_is before updat_ing x_speed/y_speed
player_update_max_speed();



// Run Current State
if (global.game_paused == false) { 
	script_execute(state);
	//_invulnerable = max(_invulnerable-1,0);
	//flash = max(flash-0.05,0);
}

// Ladder
if (tilemap_get_at_pixel(global.collision_map,x,y) == 4 && on_ground == true) {
	state = player_state_climb;
} else if (state = player_state_climb) { state = player_state_free; }	



// PitFall
if (tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
	if (z_bottom == -1) {
		if (state != player_state_death && state != player_state_p_itfall) {
			show_debug_message("enter_ing P_iTFALLs");
			on_ground = true;
			hp -= 1;
			x_speed = 0;
			y_speed = 0;
			z_speed = 0;
			image_speed = 1;
			image_index = 0;
			state = player_state_p_itfall;
		}
	}
}

// Pitfall edges
if (tilemap_get_at_pixel(global.collision_map,x,y) == 12) {
	x_speed += .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 13) {
	x_speed -= .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 14) {
	y_speed += .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 15) {
	y_speed -= .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 16) {
	x_speed -= .1;
	y_speed -= .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 17) {
	x_speed -= .1;
	y_speed += .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 18) {
	x_speed += .1;
	y_speed += .1;
}
if (tilemap_get_at_pixel(global.collision_map,x,y) == 19) {
	x_speed += .1;
	y_speed -= .1;
}

// Deep Water
if (tilemap_get_at_pixel(global.collision_map,x,y) == 3) {
	if (on_ground == true && z_bottom == -1) {
		if (state != player_state_death && state != player_state_drown) {
			hp -= 1;
			x_speed = 0;
			y_speed = 0;
			image_speed = 1;
			image_index = 0;
			state = player_state_drown;
		}
	}
}

// Set Last Safe Coord_inates
if (on_ground == true && 
	z_bottom == -1 &&
	tilemap_get_at_pixel(global.collision_map,x,y) == 0) {
		last_safe_x = x_prev;
		last_safe_y = y_prev;
}


// Wade (Shallow Water)
if (tilemap_get_at_pixel(global.collision_map,x,y) == 2 && z_bottom == -1) {
	if (state != player_state_wade) { 
		
		state = player_state_wade; 
	}
} else if (state == player_state_wade) { state = player_state_free; }



// Jump & Fall
if (on_ground == false) {
	if (z_speed < 0) {
		if (state != player_state_jump) { state = player_state_jump; }
	} else {
		if (state != player_state_fall) { show_debug_message("entering FALL"); state = player_state_fall; }
	}
} else if (state == player_state_fall) { show_debug_message("entering FREE"); state = player_state_free; }



// Coll_is_ion Check_ing
player_collision();

tile = tilemap_get_at_pixel(global.collision_map,x,y);


// Death Check
if (hp <= 0) {
	/*
	if (alarm[0] ==-1) { 
		alarm[0] = FPS*2;	
	}
	*/
	state = player_state_death;
}