if (global.game_paused) { exit; }

script_execute(main_state);

if (!place_meeting(x,y,obj_parent_player)) {
	main_state = main_state_hidden;
}