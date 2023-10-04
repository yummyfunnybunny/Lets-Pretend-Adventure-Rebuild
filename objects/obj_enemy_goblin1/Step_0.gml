/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (state = enemy_choose_state) {
	// Select State
	var _chosen_state = weighted_chance(enemy_state_idle, idle_weight, enemy_state_wander, wander_weight);
	// Run selected state
	state = _chosen_state;
}

if (state = enemy_state_idle) {
	
	if (alarm[1] == -1) {
		alarm[1] = FPS*2;
	}
	if (alarm[1] == 0) {
		state = enemy_choose_state;
	}
	
	enemy_aggro_range_check();
}

if (state = enemy_state_wait) {
	show_debug_message(alarm[1]);
	if (alarm[1] == -2) alarm[1] = -1;
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[1] == -1) alarm[1] = FPS*2;
	if (alarm[1] == 0) state = enemy_choose_state;
}

if (state = enemy_state_wander) {
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
	direction = point_direction(x,y,obj_player.x,obj_player.y);
	if (move_speed != run_speed) move_speed = run_speed;
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
	enemy_return_origin_check();	
}