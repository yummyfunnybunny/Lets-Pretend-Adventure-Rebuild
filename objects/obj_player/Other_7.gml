/// @desc pitfall & drown

// end Pitfall and drown
if (state == player_state_pitfall || state = player_state_drown) {
	x_speed = 0;
	y_speed = 0;
	image_alpha = 0;
	image_speed = 0;
	image_index = image_number;
	state = player_state_death;
}

if (state == player_state_attack) {
	alarm[P_ALARM.ATK_START] = -1;
	state = player_state_free;	
}