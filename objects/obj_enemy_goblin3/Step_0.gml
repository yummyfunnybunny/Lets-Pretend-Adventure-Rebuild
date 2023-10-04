/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (state = enemy_choose_state) {
	//if (image_speed != 1) image_speed = 1;
	//show_debug_message("choose state");
	// Select State
	var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
	// Run selected state
	state = _chosen_state;
}

if (state = enemy_state_idle) {
	if (image_speed != 1) image_speed = 1;
	if (alarm[1] == -1) {
		alarm[1] = FPS*2;
	}
	if (alarm[1] == 0) {
		state = enemy_choose_state;
	}
	
	enemy_aggro_range_check();
}

if (state = enemy_state_wait) {
	if (image_speed != 1) image_speed = 1;
	if (alarm[1] == -2) alarm[1] = -1;
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[1] == -1) alarm[1] = FPS*1;
	if (alarm[1] == 0) state = enemy_choose_state;
}

if (state = enemy_state_wander) {
	if (image_speed != 1) image_speed = 1;
	// set movement
	if (alarm[1] == -1) {
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[1] = FPS*2;
	}
	if (alarm[1] == 0) {
		move_speed = 0;
		state = enemy_choose_state;
	}
	enemy_aggro_range_check();
	enemy_return_origin_check();	
}

if (state = enemy_state_chase) {
	if (image_speed != 1) image_speed = 1;
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	if (move_speed != run_speed) move_speed = run_speed;
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
	
	if (enemey_attack_range_check() == true) {
		//show_message("attacking");
		state = enemy_state_attack;
	}
	enemy_return_origin_check();	
}

if (state = enemy_state_attack) {
		if (alarm[3] == -1 && alarm[4] == -1 && just_got_damaged == false) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		if (sprite_index != sprite_attack) { sprite_index = sprite_attack; }
		image_index = 0;
		image_speed = 0;
		alarm[3] = FPS*.5;
	}
	if (alarm[3] == 0) {
		image_index = 1;
		var _damage = instance_create_layer(x, y+z_bottom-16, global.main_layer, obj_damage);
		with (_damage){
			creator = other.id;
			sprite_index = spr_arrow;
			move_speed = 3;
			aim_direction = point_direction(other.x,other.y,obj_player.x,obj_player.y);
			damage_object_duration = 3;
			damage = other.damage;
			knockback_amount = other.knockback_amount;
			damage_type = "projectile";
		}
		alarm[4] = FPS*.25;
	}
	if (alarm[4] == 0) {
		state = enemy_state_wait;
	}
	
	// update knockback
	entity_update_knockback();
}