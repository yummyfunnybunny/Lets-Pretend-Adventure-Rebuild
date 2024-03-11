
// === MAIN STATES ===

function enemy_state_unaware() {
	/*
	if (point_distance(x,y,obj_player.x,obj_player.y) <= aggro_range*COL_TILES_SIZE) {
			main_state = enemy_state_aware();
	}
	*/
}

function enemy_state_aware() {
	
}

//==========================================================================

// === NEST STATES ===

// --- misc states ---

function enemy_choose_state() {

}

function enemy_state_wait() {

}

function enemy_state_hurt() {
	
}

function enemy_state_death() {
	// set image
	if (sprite_index != sprite_death) { sprite_index = sprite_death; }
	// begin death
	if (alarm[0] == -1) {
		if (knockback_x != 0 && knockback_y != 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[0] = FPS * 2;
		}
	}
	// end death
	if (alarm[0] == 0) {
		instance_destroy();	
	}
}

function enemy_state_return_origin() {
	// create pather
	if (alarm[1] == -1) {
		pather_create(origin_x,origin_y);
		alarm[1] = -2;
	}
	
	// set move speed
	if (alarm[1] == -2 && pather_object != noone) {
		var _dis = point_distance(x,y,pather_object.x,pather_object.y);
		if (_dis > move_speed) {
			// set direction & speed of the object
			direction = point_direction(x,y,pather_object.x,pather_object.y);
			if (move_speed != run_speed) move_speed = run_speed;
		}else {
			// set move_speed to 0 if object is too close to the pather object
			if (move_speed != 0) move_speed = 0;	
		}
	}
	
	// check if returned to origin
	if (point_distance(x,y,origin_x,origin_y) <= move_speed || point_distance(x,y,origin_x,origin_y) <= 2) {
		pather_delete(pather_object);
		nest_state = enemy_state_wait;
		main_state = enemy_state_unaware;
		alarm[1] = -1;
	}	
}

// ------------------------------------------------------------

// --- unaware states ---

function enemy_state_idle(){

}

function enemy_state_wander() {
	/*
	// set movement
	if (alarm[1] == -1) {
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
		alarm[1] = FPS*2;
	}
	if (alarm[1] == 0) {
		move_speed = 0;
		enemy_choose_state();
	}
	enemy_aggro_range_check();
	enemy_return_origin_check();
	*/
}

function enemy_state_sleep() {
		
}

// ------------------------------------------------------------

// --- aware states ---

function enemy_state_chase() {
	if (!instance_exists(target) || target.state == player_state_death) {
		main_state = enemy_state_unaware;
		nest_state = enemy_choose_state;
	}
}

function enemy_state_attack() {
	
}

function enemy_state_flee() {
	
}

function enemy_state_align() {
	
}

// ------------------------------------------------------------

