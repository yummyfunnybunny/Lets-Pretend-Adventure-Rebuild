/// @description Insert description here
// You can write your code in this editor

event_inherited();

// Run Current State
if (global.game_paused == false) { 
	script_execute(state);
}

// update image
enemy_flip_image();
enemy_image_speed();
enemy_update_sprite();

// update knockback
entity_update_knockback();

// update movement
if (move_speed != 0) {
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
}


entity_collision();

if (hp <= 0) {
	state = enemy_state_death;	
}