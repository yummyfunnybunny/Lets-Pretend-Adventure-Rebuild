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
		case nest_state_fall: _nest_state = "Fall"; break;
		case nest_state_climb: _nest_state = "Cl_imb"; break;
		case nest_state_death_pitfall: _nest_state = "PitFall"; break;
		case nest_state_death_drown: _nest_state = "Drown"; break;
		case nest_state_death_normal: _nest_state = "Death"; break;
		case nest_state_attack_sword: _nest_state = "Attack Sword"; break;
		case nest_state_talk: _nest_state = "_interact"; break;
		case nest_state_hurt: _nest_state = "Hurt"; break;
		default: _nest_state = "DUNNO"; break;
	}
	
	// set variables to show
	var _debugger = [];
	_debugger[0] = $"z_bottom: {z_bottom}";
	_debugger[1] = $"z_floor: {z_floor}";
	_debugger[2] = $"on_ground: {on_ground}";
	_debugger[3] = $"on_top_of: {on_top_of}";
	_debugger[4] = $"depth: {depth}";
	_debugger[5] = $"layer: {layer}";
	
	show_debug_message(layer_get_id("instances_1"));
	show_debug_message(layer_get_name(layer));
	
	// set font
	draw_set_font(fnt_text_10);
	
	// draw variables
	for (var _i = 0; _i < array_length(_debugger); _i++) {
		draw_text(16, (16*_i)+64,_debugger[_i]);
	}
	// reset text
	reset_text();
}