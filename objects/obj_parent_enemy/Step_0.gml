/// @descr update enemy
event_inherited();

enemy_set_target();

// Run Current State
if (global.game_paused == -1) { 
	script_execute(main_state);
	script_execute(nest_state);
}

// update image
enemy_flip_image();
enemy_update_sprite();

// update collision
entity_collision();

// update knockback
knockback_update();

// update movement
if (move_speed != 0) {
	if (knockback_check()) { exit; }
	//if (knockback_check() == false) {
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
	//}
}

// apply damage
if (apply_damage != 0) {
	enemy_start_damage(damage_script);
}

// check death by 0 HP
if (hp <= 0) {
	main_state = main_state_death;
	nest_state = nest_state_death_normal;	
}

// die when touching shallow water, deep water, and pitfalls
// THIS WILL MOST LIKELY NEED TO BE MOVED/CHANGED
//		certain enemies will be able to go in water and pitfalls
// different enemies will react differently to terrain
if (tilemap_get_at_pixel(global.collision_map,x,y) == 2 ||
	tilemap_get_at_pixel(global.collision_map,x,y) == 3 ||
	tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
	if (z_bottom == -1) {
		var _tile = tilemap_get_at_pixel(global.collision_map,x,y);
		var _death_sprite;
		switch (_tile) {
			case 2: _death_sprite = spr_splash;
			case 3: _death_sprite = spr_splash; break;
			case 6: _death_sprite = spr_pitfall; break;
		}
		pather_delete(pather_object);
		instance_destroy();	
		instance_create_layer(x,y,global.main_layer,obj_object_death, {
			sprite_index: _death_sprite
		});
	}
}


// 2 = shallow water
// 3 = deep water
// 6 = pitfall