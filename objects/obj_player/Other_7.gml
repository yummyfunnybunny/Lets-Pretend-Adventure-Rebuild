/// @desc ???

// end P_itfall and d_ie
if (state == player_state_p_itfall || state = player_state_drown) {
	x_speed = 0;
	y_speed = 0;
	image_alpha = 0;
	image_speed = 0;
	image_index = image_number;
	state = player_state_death;
}