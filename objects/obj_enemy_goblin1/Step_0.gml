/// @descr update enemy

// Inherit the parent event
event_inherited();

#region FUNCTIONS

function goblin1_choose_state() {
	// Select State
	if (enemy_aggro_range_check() == true) { 
		nest_state = enemy_state_chase; 
	} else {
	var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
	// Run selected state
	main_state = enemy_state_unaware;
	nest_state = _chosen_state;
	}
}

#endregion

#region MAIN STATES

if (main_state == enemy_state_unaware) {
	
	if (enemy_aggro_range_check() == true) {
		if (main_state != enemy_state_aware) main_state = enemy_state_aware;	
		if (nest_state != enemy_state_chase) nest_state = enemy_state_chase;
	}
	
	if (enemy_return_origin_check() == true) {
		if (nest_state != enemy_state_return_origin) nest_state = enemy_state_return_origin;	
	}
}

if (main_state == enemy_state_aware) {
	
	if (enemy_return_origin_check() == true) {
		if (nest_state != enemy_state_return_origin) nest_state = enemy_state_return_origin;	
	}
}

#endregion

#region NEST STATES

if (nest_state == enemy_state_idle) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// begin idle
	if (alarm[1] == -1) alarm[1] = FPS*2;
	// end idle
	if (alarm[1] == 0) goblin1_choose_state();
}

if (nest_state == enemy_state_wait) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// reset state change alarm
	//if (alarm[1] == -2) alarm[1] = -1;
	// begin wait
	if (alarm[1] == -1) {
		alarm[1] = FPS*1;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
	}
	// end wait
	if (alarm[1] == 0) goblin1_choose_state();
}

if (nest_state == enemy_state_wander) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// begin wander
	if (alarm[1] == -1) {
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
		alarm[1] = FPS*2;
	}
	// end wander
	if (alarm[1] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		goblin1_choose_state();
	}	
}

if (nest_state == enemy_state_chase) {
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	if (move_speed != run_speed) move_speed = run_speed;
}

if (nest_state == enemy_state_hurt) {
	if (check_knockback_is_0() == true) {
		goblin1_choose_state();	
	}
}

if (nest_state == enemy_state_flee) {
	
}

#endregion
