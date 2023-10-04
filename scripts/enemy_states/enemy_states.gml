
// --- MAIN STATES

/*
function enemy_state_unaware() {
	
	if (point_distance(x,y,obj_player.x,obj_player.y) <= aggro_range*COL_TILES_SIZE) {
			state = enemy_state_hostile();
	}
}
*/

// --- NEST STATES

function enemy_choose_state() {
	/*
	// Select State
	var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
	// Run selected state
	state = _chosen_state;
	*/
}

function enemy_state_idle(){
	move_speed = 0;
	/*
	if (alarm[1] == -1) {
		alarm[1] = FPS*2;
	}
	if (alarm[1] == 0) {
		enemy_choose_state();
	}
	
	enemy_aggro_range_check();
	*/
}

function enemy_state_wait() {
	/*
	if (alarm[1] == -2) alarm[1] = -1;
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[1] == -1) alarm[1] = FPS*2;
	if (alarm[1] == 0) enemy_choose_state();
	*/
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

function enemy_state_chase() {
	/*
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	if (move_speed != run_speed) move_speed = run_speed;
	enemy_return_origin_check();
	*/
}

function enemy_state_attack() {
	
}

function enemy_sate_hurt() {
	
}

function enemy_state_flee() {
	
}

function enemy_state_death() {
	if (sprite_index != sprite_death) { sprite_index = sprite_death; }
	if (move_speed != 0) move_speed = 0;
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (alarm[0] == -1) {
		alarm[0] = FPS * 2;	
	}
	
	if (alarm[0] == 0) {
		instance_destroy();	
	}
}

function enemy_state_return_origin() {
	// create pather
	if (alarm[1] == -1) {
		pather_create();
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
			path_delete(pather_object.path);
			instance_destroy(pather_object);
			pather_object = noone;
			state = enemy_state_wait;	
		}	
}