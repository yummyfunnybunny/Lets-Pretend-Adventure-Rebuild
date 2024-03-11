///@desc update enemy

// Inherit the parent event
event_inherited();

/*
if (on_top_of == obj_player && on_ground == true) {
	show_message("ON TOP OF PLAYER");	
}
*/

#region FUNCTIONS

// change altitude
/*
if (z_bottom != z_bottom+(altitude_range*altitude_change_dir)) {
	z_bottom += .01*altitude_change_dir;
} else {
	altitude_change_dir *= -1;	
}
*/

z_bottom = lerp(z_bottom,z_bottom+(altitude_range*altitude_change_dir),.025);
if (z_bottom = z_origin +(altitude_range*altitude_change_dir)) {
	altitude_change_dir *= -1;	
}


#endregion

#region MAIN STATES



#endregion

#region NEST STATES

/*
if (nest_state = enemy_state_idle) {
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[1] == -1) {
		alarm[1] = FPS*(choose(1,2));
	}
	if (alarm[1] == 0) {
		//alarm[1] = -1;
		nest_state = enemy_state_wander;
	}
}
*/

if (nest_state = enemy_state_wander) {
	// set movement
	if (alarm[ALARM.STATE] == -1) {
		direction_change = choose (1,-1);
		move_speed = choose(walk_speed, run_speed);
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[ALARM.STATE] = FPS*(choose(1,2));
	}
	
	// during wander
	if (alarm[ALARM.STATE] > 0) {
		direction += direction_change;	
	}
	if (alarm[ALARM.STATE] == 0) {
		nest_state = enemy_state_wander;
	}
}

if (nest_state = enemy_state_death) {
	image_speed = 0;
	z_gravity = .5;	
	if (on_ground == false) {
		image_index = 0;
	} else {
		image_index = 1;	
	}
	
}

#endregion

