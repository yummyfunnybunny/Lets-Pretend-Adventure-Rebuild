
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
	
	// set nest state to pushing
	//if (nest_state != nest_state_push) {
	//	interact_prev_state = nest_state;
	//	nest_state = nest_state_push;
	//} else {
	//	switch(interact_type) {
	//		case INTERACT_TYPE.OPEN:
			
	//		break;
			
	//		case INTERACT_TYPE.PUSH:

	//		break;
	//	}
	//}
	
}

prop_interact_range_check = function() {
	if (can_interact == false) { exit; }
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	//if (main_state != main_state_closed) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.layer != layer) { exit; }
	
	var _dis = point_distance(x,y,interact_target.x,interact_target.y);
	if (_dis <= interact_range*COL_TILES_SIZE) {
		prop_check_target_infront();
	} else {
		if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
	}
}

prop_check_target_infront = function() {
	if (can_interact == false) { exit; }
	//if (interact_target.on_top_of == id) { exit; }
	if (interact_target.on_ground == false) { exit; }
	
	if (interact_target.y > y) {
		if (interact_target.face_direction == 90) {
			if (bounding_box_overlap_check("y", id, interact_target) == true) {
				interact_target.interact_target = id;
				return;
			}
		}
	}
	if (interact_target.y < y) {
		if (interact_target.face_direction == 270) {
			if (bounding_box_overlap_check("y", id, interact_target) == true) {
				interact_target.interact_target = id;
				return;
			}
		}
	}
	if (interact_target.x > x) {
		if (interact_target.face_direction == 180) {
			if (bounding_box_overlap_check("x", id, interact_target) == true) {
				interact_target.interact_target = id;
				return;
			}
		}
	}
	if (interact_target.x < x) {
		if (interact_target.face_direction == 0) {
			if (bounding_box_overlap_check("x", id, interact_target) == true) {
				interact_target.interact_target = id;
				return;
			}
		}
	}
	
	if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
}

#endregion