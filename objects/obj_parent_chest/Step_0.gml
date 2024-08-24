event_inherited();

if (global.game_paused) { exit; }

script_execute(main_state);
chest_interact_set_target();
chest_interact_range_check();