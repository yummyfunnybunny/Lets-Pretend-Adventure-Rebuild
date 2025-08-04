
event_inherited();

#region SET VARIABLES

carry_curve_horizontal				= animcurve_get_channel(ac_cubic_easein,"curve1");
carry_curve_vertical				= animcurve_get_channel(ac_cubic_easeout,"curve1");

#endregion

#region STARTING STATE

main_state = main_state_alive;
nest_state = nest_state_idle;

#endregion

#region CUSTOM HELPERS

prop_interact_input_progression = function() {
	if (can_interact == false) { exit; }
	if (alarm[PROP_ALARM.INTERACT] != -1) { exit; }
	//if (nest_state != nest_state_carry) { exit; }
	
	if (nest_state == nest_state_idle) {
		nest_state = nest_state_carry;
	}
	
	if (nest_state == nest_state_carry) {
		// throw object
		prop_interact_throw();
	}
}

#endregion