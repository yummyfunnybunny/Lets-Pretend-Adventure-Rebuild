/// @descr update enemy

// Inherit the parent event
event_inherited();

#region FUNCTIONS

function goblin3_choose_state() {
	// Select State
	if (enemy_aggro_range_check() == true) { 
		nest_state = enemy_state_align; 
	} else {
		var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
		// Run selected state
		main_state = enemy_state_unaware;
		nest_state = _chosen_state;
	}
}

#endregion

#region MAIN STATES

if (main_state == enemy_state_unaware) {
	
	if (enemy_aggro_range_check() == true) {
		if (main_state != enemy_state_aware) main_state = enemy_state_aware;	
		if (nest_state != enemy_state_chase) nest_state = enemy_state_align;
	}
	
	if (enemy_return_origin_check() == true) {
		if (nest_state != enemy_state_return_origin) nest_state = enemy_state_return_origin;	
	}
}

if (main_state == enemy_state_aware) {

}


#endregion

#region NEST STATES

if (nest_state = enemy_state_idle) {
	if (image_speed != 1) image_speed = 1;
	if (alarm[ALARM.STATE] == -1) alarm[ALARM.STATE] = FPS*2;
	if (alarm[ALARM.STATE] == 0) goblin3_choose_state();
}

if (nest_state = enemy_state_wait) {
	if (image_speed != 1) image_speed = 1;
	//if (alarm[1] == -2) alarm[1] = -1;
	if (alarm[ALARM.STATE] == -1) {
		alarm[ALARM.STATE] = FPS*1;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
	}
	if (alarm[ALARM.STATE] == 0) goblin3_choose_state();
}

if (nest_state = enemy_state_wander) {
	// set movement
	if (alarm[ALARM.STATE] == -1) {
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[ALARM.STATE] = FPS*2;
	}
	// during wander
	if (alarm[ALARM.STATE] > 0) {
		image_speed = move_speed;
	}
	// end wander
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		goblin3_choose_state();
	}	
}

if (nest_state = enemy_state_align) {
	image_speed = move_speed;
	// begin align
	if (alarm[ALARM.STATE] == -1) {
		var _dir = point_direction(target.x,target.y,x,y);
		align_x = target.x + lengthdir_x(attack_range*COL_TILES_SIZE,_dir);
		align_y = target.y + lengthdir_y(attack_range*COL_TILES_SIZE,_dir);
		var _attack_range = attack_range;
		while (enemy_check_collision_map_xy(align_x,align_y) == false){
			_attack_range --;
			align_x = target.x + lengthdir_x(_attack_range*COL_TILES_SIZE,_dir);
			align_y = target.y + lengthdir_y(_attack_range*COL_TILES_SIZE,_dir);
		}
		pather_create(align_x,align_y);
		alarm[ALARM.STATE] = -2;
	}
	
	// during align
	if (alarm[ALARM.STATE] == -2 && pather_object != noone) {
		var _dis = point_distance(x,y,pather_object.x,pather_object.y);
		if (_dis > move_speed) {
			// set direction & speed of the object
			direction = point_direction(x,y,pather_object.x,pather_object.y);
			if (move_speed != run_speed)  move_speed = run_speed;
		}else {
			// set move_speed to 0 if object is too close to the pather object
			if (move_speed != 0) move_speed = 0;	
		}
	}
	
	// end align
	if (point_distance(x,y,align_x,align_y) <= move_speed || point_distance(x,y,align_x,align_y) <= 2) {
		pather_delete(pather_object);
		align_x = 0;
		align_y = 0;
		nest_state = enemy_state_attack;	
	}	
	
}

if (nest_state = enemy_state_attack) {
	if (alarm[ALARM.ATK_START] == -1 && alarm[ALARM.ATK_END] == -1 && just_got_damaged == false) {
		direction = point_direction(x,y,target.x,target.y);
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		if (sprite_index != sprite_attack) { sprite_index = sprite_attack; }
		image_index = 0;
		image_speed = 0;
		alarm[ALARM.ATK_START] = FPS*.5;
	}
	if (alarm[ALARM.ATK_START] == 0) {
		image_index = 1;
		var _damage = instance_create_layer(x, y+z_bottom-16, global.main_layer, obj_damage_sword, {
			creator: other.id,
			sprite_index: spr_arrow,
			move_speed: 3,
			aim_direction: point_direction(other.x,other.y,obj_player.x,obj_player.y),
			damage_object_duration: 3,
			damage: other.damage,
			knockback_amount: other.knockback_amount,
			damage_type: DAMAGE_TYPE.PIERCE
		});
		with (_damage){
			
		}
		alarm[ALARM.ATK_END] = FPS*.25;
	}
	if (alarm[ALARM.ATK_END] == 0) {
		nest_state = enemy_state_wait;
	}
}

if (nest_state == enemy_state_hurt) {
	if (knockback_check() == true) {
		goblin3_choose_state();	
	}
}

#endregion




