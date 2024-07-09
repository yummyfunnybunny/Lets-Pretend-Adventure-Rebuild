/// @desc

if (global.debugger == true) {
	
	// set main state text
	var _main_state;
	switch (main_state) {
		case main_state_alive: _main_state = "alive"; break;	
		case main_state_death: _main_state = "death"; break;	
	}
	// set nest_state text
	var _nest_state;
	switch(nest_state) {
		case nest_state_free: _nest_state = "Free"; break;
		case nest_state_jump: _nest_state = "Jump"; break;
		//case nest_state_wade: _nest_state = "Wade"; break;
		case nest_state_fall: _nest_state = "Fall"; break;
		case nest_state_climb: _nest_state = "Cl_imb"; break;
		case nest_state_death_pitfall: _nest_state = "PitFall"; break;
		case nest_state_death_drown: _nest_state = "Drown"; break;
		case nest_state_death_normal: _nest_state = "Death"; break;
		case nest_state_attack_sword: _nest_state = "Attack Sword"; break;
		case nest_state_talk: _nest_state = "_interact"; break;
		//case nest_state_respawn: _state_text = "Respawn"; break;
		case nest_state_hurt: _nest_state = "Hurt"; break;
		default: _nest_state = "DUNNO"; break;
	}
	
	// set variables to show
	var _debugger = [];
	
	//_debugger[0] = "image index: " + string(image_index);
	_debugger[1] = "main state: " + string(_main_state);
	_debugger[2] = "nest state: " + string(_nest_state);
	_debugger[3] = "knockback_x: " + string(knockback_x);
	_debugger[4] = "knockback_y: " + string(knockback_y);
	_debugger[5] = "just got damaged: " + string(just_got_damaged);
	
	
	
	// set font
	draw_set_font(fnt_debugger);
	
	// draw variables
	for (var _i = 0; _i < array_length(_debugger); _i++) {
		draw_text(16, (16*_i)+64,_debugger[_i]);
	}
	
	

	// == DRAW DEBUGG_iNG ==
	//draw_text(16,16*3,"x_speed: " + string(x_speed));
	//draw_text(16,16*2,"moveR_ight: " + string(keyboard_check(right_input)));
	//draw_text(16,16*3,"moveLeft: " + string(keyboard_check(left_input)));

	//draw_text(16,16*4,"y_speed: " + string(y_speed));
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


	
	//draw_text(16,16*28,"state: " + string(_state_text));
	//draw_text(16,16*29,"HP: " + string(hp));
	//draw_text(16,16*30,"po_ison alarm " + string(alarm[3]));
	//draw_text(16,16*31,"knockback" + string(knockback_x));
}