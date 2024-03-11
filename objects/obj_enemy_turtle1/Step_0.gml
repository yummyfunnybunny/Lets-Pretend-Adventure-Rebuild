// Inherit the parent event
event_inherited();

#region FUNCTIONS

function turtle1_choose_state() {
	// Select State
	if (has_shell == false && shell_id != noone) {
		// update shell location
		if (instance_exists(shell_id)) {
			if (origin_x != shell_id.x) origin_x = shell_id.x;
			if (origin_y != shell_id.y) origin_y = shell_id.y;
			nest_state = enemy_state_return_origin;
		} else { 
			shell_id = noone; 
		}
	}else {
		var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
		// Run selected state
		main_state = enemy_state_unaware;
		nest_state = _chosen_state;
	}
}

#endregion

#region MAIN STATE

// MAIN STATE
if (main_state == enemy_state_unaware) {
	
	if (enemy_aggro_range_check() == true && has_shell == true) {
		main_state = enemy_state_aware;
		nest_state = enemy_state_flee;
	}
}

if (main_state == enemy_state_aware) {

}

#endregion

#region NEST STATE

if (nest_state = enemy_state_idle) {
	if (image_speed != 1) image_speed = 1;
	if (alarm[ALARM.STATE] == -1) alarm[ALARM.STATE] = FPS*1;
	if (alarm[ALARM.STATE] == 0) turtle1_choose_state();
}

if (nest_state = enemy_state_wait) {
	if (image_speed != 1) image_speed = 1;
	if (alarm[ALARM.STATE] == -1) {
		alarm[ALARM.STATE] = FPS*1;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
	}
	if (alarm[ALARM.STATE] == 0) turtle1_choose_state();
}

if (nest_state = enemy_state_wander) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// set movement
	if (alarm[ALARM.STATE] == -1) {
		direction = choose(45,135,225,315);
		move_speed = walk_speed;
		alarm[ALARM.STATE] = FPS*1;
	}
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		turtle1_choose_state();
	}	
}

if (nest_state = enemy_state_flee) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// begin flee
	if (alarm[ALARM.STATE] == -1) {
	direction = point_direction(target.x,target.y,x,y);
	move_speed = run_speed;
	alarm[ALARM.STATE] = FPS*2;
	}
	
	if (alarm[ALARM.STATE] == 0) {
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
		nest_state = enemy_state_wait;
		main_state = enemy_state_unaware;
	}
}

if (nest_state == enemy_state_hurt) {
	if (check_knockback_is_0() == true) {
		nest_state = enemy_state_wait;
	}
}

#endregion

