/// @descr update enemy

// Inherit the parent event
event_inherited();

// MAIN STATE
if (main_state == enemy_state_unaware) {
	
	if (enemy_aggro_range_check() == true) {
		if (main_state != enemy_state_aware) main_state = enemy_state_aware;	
		if (nest_state != enemy_state_chase) nest_state = enemy_state_chase;
	}
	
	if (enemy_return_origin_check() == true) {
		if (nest_state != enemy_state_return_origin) nest_state = enemy_state_return_origin;	
	}
}

if (main_state == enemy_state_aware) {
	
	if (enemy_return_origin_check() == true) {
		if (nest_state != enemy_state_return_origin) nest_state = enemy_state_return_origin;	
	}
}

// NEST STATE

if (nest_state = enemy_choose_state) {
	// Select State
	if (enemy_aggro_range_check() == true) { 
		nest_state = enemy_state_chase; 
	} else {
		var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
		main_state = enemy_state_unaware;
		nest_state = _chosen_state;
	}
}

if (nest_state = enemy_state_idle) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// begin state
	if (alarm[ALARM.STATE] == -1) alarm[ALARM.STATE] = FPS*2;
	// end state
	if (alarm[ALARM.STATE] == 0) nest_state = enemy_choose_state;
}

if (nest_state = enemy_state_wait) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// reset state change alarm
	//if (alarm[1] == -2) alarm[1] = -1;
	// begin state
	if (alarm[ALARM.STATE] == -1) {
		alarm[ALARM.STATE] = FPS*1;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
	}
	// end state
	if (alarm[ALARM.STATE] == 0) nest_state = enemy_choose_state;
}

if (nest_state = enemy_state_wander) {
	// set image
	if (image_speed != 1) image_speed = 1;
	// begin state
	if (alarm[ALARM.STATE] == -1) {
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[ALARM.STATE] = FPS*2;
	}
	// end state
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		nest_state = enemy_choose_state;
	}	
}

if (nest_state = enemy_state_chase) {
	// set image
	if (image_speed != 1) image_speed = 1;
	
	// begin chase
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	if (move_speed != run_speed) move_speed = run_speed;
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
	
	// end chase
	if (enemey_attack_range_check() == true) {
		nest_state = enemy_state_attack;
	}
}

if (nest_state = enemy_state_attack) {
	
	// attack powerup
	if (alarm[ALARM.ATK_START] == -1 && alarm[ALARM.ATK_END] == -1 && just_got_damaged == false) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		if (sprite_index != sprite_attack) { sprite_index = sprite_attack; }
		image_index = 0;
		image_speed = 0;
		alarm[ALARM.ATK_START] = FPS*.5;
	}
	// attack
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
			damage_type: DAMAGE_TYPE.SLASH,
		});
		alarm[ALARM.ATK_END] = FPS*.25;
	}
	// attack cooldown
	if (alarm[ALARM.ATK_END] == 0) {
		nest_state = enemy_state_wait;
	}
}