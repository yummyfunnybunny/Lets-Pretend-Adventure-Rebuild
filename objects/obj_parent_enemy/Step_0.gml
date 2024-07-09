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
}

// die when touching shallow water, deep water, and pitfalls
// THIS WILL MOST LIKELY NEED TO BE MOVED/CHANGED
//		certain enemies will be able to go in water and pitfalls
// different enemies will react differently to terrain
//if (tilemap_get_at_pixel(global.collision_map,x,y) == 2 ||
//	tilemap_get_at_pixel(global.collision_map,x,y) == 3 ||
//	tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
//	if (z_bottom == -1) {
//		var _tile = tilemap_get_at_pixel(global.collision_map,x,y);
//		var _death_sprite;
//		switch (_tile) {
//			case 2: _death_sprite = spr_splash;
//			case 3: _death_sprite = spr_splash; break;
//			case 6: _death_sprite = spr_pitfall; break;
//		}
//		//pather_delete(pather_object);
//		instance_destroy();	
//		instance_create_layer(x,y,global.main_layer,obj_object_death, {
//			sprite_index: _death_sprite
//		});
//	}
//}


// 2 = shallow water
// 3 = deep water
// 6 = pitfall