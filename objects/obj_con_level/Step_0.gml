/// @desc

// update game manager inputs
restart_game_input	= keyboard_check_pressed(vk_escape);
toggle_debug_input	= keyboard_check_pressed(vk_f1);
pause_input			= keyboard_check_pressed(ord("P"));

if (restart_game_input) {
	game_restart();
}

if (toggle_debug_input) {
	if (global.debugger == false) { global.debugger = true; } else
	if (global.debugger == true) { global.debugger = false; }
}

if (pause_input) {
	if (global.game_paused == false) { 
		global.game_paused = true;
		level_pause_game();
	} else if (global.game_paused == true) { 
		global.game_paused = false;
		level_resume_game();
	}
}

script_execute(level_update_overlay);

