/// @descr update enemy
event_inherited();

if (!global.game_paused) {
	enemy_set_target();				// set target
	script_execute(main_state);		// update main state
	script_execute(nest_state);		// update nest state
	enemy_flip_image();				// update flip image
	enemy_update_sprite();			// update sprite
	entity_collision();				// update collision
	knockback_update();				// update knockback
	enemy_update_movement();		// update movement
	enemy_death_check();			// check death by 0 HP
	enemy_update_terrain_state();	// update terrain state
	enemy_terrain_effect();			// run terrain effect
}