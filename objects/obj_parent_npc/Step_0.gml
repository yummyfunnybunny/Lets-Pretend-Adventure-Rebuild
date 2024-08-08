event_inherited();

if (!global.game_paused) {
	script_execute(main_state);		// update main state
	script_execute(nest_state);		// update nest state
	entity_collision();				// update collision
	knockback_update();				// update knockback
	npc_flip_image();				// update flip image
	npc_update_sprite();			// update sprite
	npc_update_movement();			// update movement
	npc_death_check();				// check death by 0 HP
	npc_update_terrain_state();		// update terrain state
	npc_terrain_effect();			// run terrain effect
	npc_set_enemy_target();
	npc_interact_set_target();
	npc_interact_check_interact_range();
	if (quest && quest.update_script != noone) { script_execute(quest.update_script); }
}