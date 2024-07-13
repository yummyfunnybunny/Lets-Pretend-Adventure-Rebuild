/// @desc

// Inherit the parent event
event_inherited();

#region CUSTOME MAIN STATES

main_state_unaware = function() {
	enemy_aggro_range_check();
	enemy_origin_distance_check();
}

main_state_aware = function() {
	enemey_attack_range_check();
	enemy_origin_distance_check();
}

#endregion

#region CUSTOME NEST STATES

nest_state_wait = function() {
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}

nest_state_idle = function() {
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}

nest_state_wander = function() {
	
	// begin wander
	if (alarm[ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		alarm[ALARM.STATE] = FPS * 2;
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
	}
	
	// TODO - avoid water, pitfalls, and walls
	
	// end wander
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}

nest_state_chase = function() {
	if (!instance_exists(target)) { exit; }
	direction = point_direction(x,y,target.x,target.y);
	if (move_speed != run_speed) move_speed = run_speed;
}

nest_state_hurt = function() {
	if (knockback_check()) { exit; }
	nest_state = nest_state_wait;
}

nest_state_flee = function() {
	// run away from target
	// search for hiding spots?
	// run towards allied units
		// once allied units are found, attack player again
}

#endregion

#region CUSTOME HELPERS



#endregion

#region SET STARTING STATES

main_state = main_state_unaware;
nest_state = nest_state_idle;

#endregion