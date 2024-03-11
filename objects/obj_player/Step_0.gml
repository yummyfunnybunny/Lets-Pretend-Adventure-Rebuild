event_inherited();

player_update_input();

player_apply_friction();

// Update Player max_speed
// *do this before updating x_speed/y_speed*
player_update_max_speed();

// Collision Checking
// *must do this AFTER updating max_speed*
entity_collision();

// Run Current State
if (global.game_paused == -1) { 
	script_execute(state);
}

#region COLLISION MAP CHECKS

// Ladder
if (tilemap_get_at_pixel(global.collision_map,x,y) == 4 && on_ground == true) {
	state = player_state_climb;
} else if (state = player_state_climb) { state = player_state_free; }	



// PitFall
if (tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
	if (z_bottom == -1) {
		if (state != player_state_death && state != player_state_pitfall) {
			just_got_damaged = true;
			on_ground = true;
			hp -= 1;
			x_speed = 0;
			y_speed = 0;
			z_speed = 0;
			image_speed = 1;
			image_index = 0;
			state = player_state_pitfall;
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
		if (state = player_state_free) {
			just_got_damaged = true;
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
		last_safe_x = xprevious;
		last_safe_y = yprevious;
}


// Wade (Shallow Water)
if (tilemap_get_at_pixel(global.collision_map,x,y) == 2 && z_bottom == -1) {
	if (state != player_state_wade) { 
		state = player_state_wade; 
	}
} else if (state == player_state_wade) { state = player_state_free; }

#endregion

// Jump & Fall
if (on_ground == false) {
	if (z_speed < 0) {
		if (state != player_state_jump) { state = player_state_jump; }
	} else {
		if (state != player_state_fall) { state = player_state_fall; }
	}
} else if (state == player_state_fall) { state = player_state_free; }



// knockback state check
if (abs(knockback_x) > .5 || abs(knockback_y) > .5) {
	if (state != player_state_knockback) {state = player_state_knockback; }	
} else {
	if (state = player_state_knockback) state = player_state_free;
}

// Death Check
if (hp <= 0 && state = player_state_free) {
	state = player_state_death;
}