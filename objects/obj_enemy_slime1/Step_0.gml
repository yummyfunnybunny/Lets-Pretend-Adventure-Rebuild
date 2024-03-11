///@desc update enemy

// Inherit the parent event
event_inherited();

#region FUNCTIONS

#endregion

#region MAIN STATES



#endregion

#region NEST STATES

if (nest_state = enemy_state_idle) {
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[ALARM.STATE] == -1) {
		alarm[ALARM.STATE] = FPS*(choose(1,2));
	}
	if (alarm[ALARM.STATE] == 0) {
		nest_state = enemy_state_wander;
	}
}

if (nest_state = enemy_state_wander) {
	// set movement
	if (alarm[ALARM.STATE] == -1) {
		direction = choose (0,90,180,270);
		move_speed = choose(walk_speed, run_speed);
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[ALARM.STATE] = FPS*(choose(1,2));
	}
	if (alarm[ALARM.STATE] == 0) {
		x_speed = 0;
		y_speed = 0;
		nest_state = enemy_state_idle;
	}
}

#endregion

