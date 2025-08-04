
event_inherited();

#region STARTING STATE

main_state = main_state_alive;
nest_state = nest_state_idle;

count = 0;

#endregion

#region CUSTOM HELPERS

prop_interact_input_progression = function() {
	if (can_interact == false) { exit; }
	if (alarm[PROP_ALARM.INTERACT] != -1) { exit; }
	//if (main_state != main_state_closed) { exit; }
	
	// set x,y locking & enter push state
	if (nest_state != nest_state_push) {
		var _dis = point_distance(x,y,interact_target.x,interact_target.y);
		var _dir = point_direction(x,y,interact_target.x,interact_target.y);
		pushing.x_lock = lengthdir_x(_dis,_dir);
		pushing.y_lock = lengthdir_y(_dis,_dir);
		interact_prev_state = nest_state;
		nest_state = nest_state_push;
	}
}

#endregion