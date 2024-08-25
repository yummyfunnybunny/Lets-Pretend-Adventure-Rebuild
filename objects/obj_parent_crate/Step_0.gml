
event_inherited();

if (global.game_paused == true) { exit; }

script_execute(main_state);		// update main state
script_execute(nest_state);		// update nest state
knockback_update();
prop_death_check();
prop_update_terrain_state();
prop_terrain_effect();
entity_collision();				// update collision