event_inherited();

#region SET VARIABLES

open_curve				= animcurve_get_channel(ac_curve_chest_opening,"curve1");
open_percent			= 0;
open_change				= 1/60;
image_speed				= 0;
image_index				= 0;

#endregion

#region SET STARTING STATE

main_state = main_state_closed;
nest_state = nest_state_idle;

#endregion

#region CUSTOME HELPERS

prop_interact_input_progression = function() {
	if (can_interact == false) { exit; }
	if (main_state != main_state_closed) { exit; }
	
	if (main_state == main_state_closed) {
		// check if a key is needed
		// - yes -> check if player has key
			// - yes -> open check
			// - no -> don't open chest
		// - no -> open chest
		if (locked == false) {
			main_state = main_state_opening;
		} else {
			// check for the key	
			if (global.player.ammo.keys > 0) {
				locked = false;
				global.player.ammo.keys--;
				main_state = main_state_opening;
			} else {
				// player has no keys
				// - shake the box, play a failed sound, etc...
			}
		}
	}
}


prop_interact_range_check = function() {
	if (can_interact == false) { exit; }
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (main_state != main_state_closed) { exit; }
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
	
	if (interact_target.y > y) {
		if (interact_target.face_direction == 90) {
			if (bbox_left <= interact_target.x && bbox_right >= interact_target.x) {
				interact_target.interact_target = id;
				return;
			}
		}
	}
	if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
}

#endregion