/// @desc

// Inherit the parent event
event_inherited();

nest_state_wait = function() {
	// wait is almost identical to idle, but wait will cancel
	// state change checks like aggro range and attack range
	// so the enemy is forced to wait, inline idle
	if (image_speed != 1) image_speed = 1;
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * choose(1,2);
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		choose_state();
	}
}

nest_state_idle = function() {
	if (image_speed != 1) image_speed = 1;
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * choose(1,2);
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		nest_state = nest_state_wander;
	}
}

nest_state_wander = function() {
	
	// set image
	if (image_speed != 1) image_speed = 1;
	
	// begin wander
	if (alarm[ALARM.STATE] == -1) {
		direction = choose (0,90,180,270);
		move_speed = choose(walk_speed, run_speed);
		//x_speed = lengthdir_x(move_speed, direction);
		//y_speed = lengthdir_y(move_speed, direction);
		alarm[ALARM.STATE] = FPS*(choose(1,2));
	}
	
	// TODO - avoid water, pitfalls, and walls
	
	// end wander
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		nest_state = nest_state_idle;
	}
}

nest_state_hurt = function() {
	if (knockback_check()) { exit; }
	nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
}

nest_state_death_normal = function() {
	
	// stop animation on end
	if (image_index >= image_number -1) {
		image_speed = 0;
		image_index = image_number -1;	
	}
}

// SET STARTING STATES
main_state = main_state_unaware;
nest_state = nest_state_idle;
