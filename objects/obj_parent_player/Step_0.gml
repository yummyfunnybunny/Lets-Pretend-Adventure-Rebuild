event_inherited();

player_update_input();										// 1 - update player input
player_apply_friction();									// 2 - update player friction
player_update_max_speed();									// 3 - Update Player max_speed - *do this before updating x_speed/y_speed*
entity_collision();											// 4 - Collision Checking - *must do this AFTER updating max_speed*
player_update_image();
if (global.game_paused == -1) { 
	script_execute(main_state);
	script_execute(nest_state);
	}														// 5 - Run Current State
player_set_last_safe_coordinates();							// 6 - Set Last Safe Coordinates
player_on_ground_check();
player_jump_check();
player_fall_check();
player_knockback_check();									// 8 - knockback state check
player_death_check();										// 9 - Death Check
player_terrain_checks();									// 10 - check terrain

