event_inherited();

if (global.game_paused == true) { exit; }

script_execute(main_state);
script_execute(nest_state);

// can kill
//if (can_kill) {
	prop_death_check();
//}

// can interact
//if (can_interact) {
	prop_interact_set_target();
	prop_interact_range_check();
//}

//// can move
//if (can_move) {
	knockback_update();
	prop_update_terrain_state();
	prop_terrain_effect();
	entity_collision();
//}