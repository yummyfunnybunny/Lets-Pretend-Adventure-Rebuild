event_inherited();

#region SET VARIABLES

open_curve				= animcurve_get_channel(ac_curve_chest_opening,"curve1");

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

#endregion