
if (global.debugger == true) {
	
	// set state strings
	var _state;
	switch(state) {
		case player_state_free: _state = "Free"; break;
		case player_state_jump: _state = "Jump"; break;
		case player_state_wade: _state = "Wade"; break;
		case player_state_fall: _state = "Fall"; break;
		case player_state_climb: _state = "Cl_imb"; break;
		case player_state_pitfall: _state = "PitFall"; break;
		case player_state_drown: _state = "Drown"; break;
		case player_state_death: _state = "Death"; break;
		case player_state_attack: _state = "Attack"; break;
		case player_state__interact: _state = "_interact"; break;
		case player_state_respawn: _state = "Respawn"; break;
		case player_state_knockback: _state = "Hurt"; break;
		default: _state = "DUNNO"; break;
	}
	
	// set variables to show
	var _debugger = [];
	
	_debugger[0] = "image index: " + string(image_index);
	_debugger[1] = "face dir: " + string(face_direction);
	_debugger[2] = "state: " + string(_state);
	
	
	
	// set font
	draw_set_font(fnt_debugger);
	
	// draw variables
	for (var _i = 0; _i < array_length(_debugger); _i++) {
		draw_text(16, 16*_i,_debugger[_i]);
	}
	
	

	// == DRAW DEBUGG_iNG ==
	//draw_text(16,16*1,"x_speed: " + string(x_speed));
	//draw_text(16,16*2,"moveR_ight: " + string(keyboard_check(right_input)));
	//draw_text(16,16*3,"moveLeft: " + string(keyboard_check(left_input)));

	//draw_text(16,16*2,"y_speed: " + string(y_speed));
	//draw_text(16,16*6,"moveDown: " + string(keyboard_check(down_input)));
	//draw_text(16,16*7,"moveUp: " + string(keyboard_check(up_input)));
	//draw_text(16,16*3,"max_speed: " + string(max_speed));

	//draw_text(16,16*4,"z_speed: " + string(z_speed));
	//draw_text(16,16*5,"z_bottom: " + string(z_bottom));
	//draw_text(16,16*6,"z_top: " + string(z_top));
	//draw_text(16,16*7,"z_floor: " + string(z_floor));
	//draw_text(16,16*8,"z_roof: " + string(z_roof));
	//draw_text(16,16*9,"on_ground: " + string(on_ground));
	//draw_text(16,16*10,"on_top_of: " + string(on_top_of));
	//draw_text(16,16*11,"below_of: " + string(below_of));

	//draw_text(16,16*13,"accel: " + string(acceleration));
	//draw_text(16,16*14,"fr_ic: " + string(friction));

	//draw_text(16,16*16,"Y: " + string(y));
	//draw_text(16,16*17,"y_prev: " + string(yprevious));
	//draw_text(16,16*18,"Depth: " + string(depth));

	//draw_text(16,16*20,"move_direction: " + string(move_direction));
	//draw_text(16,16*21,"face_direction: " + string(face_direction));


	
	//draw_text(16,16*28,"state: " + string(_state));
	//draw_text(16,16*29,"HP: " + string(hp));
	//draw_text(16,16*30,"po_ison alarm " + string(alarm[3]));
	//draw_text(16,16*31,"knockback" + string(knockback_x));
}