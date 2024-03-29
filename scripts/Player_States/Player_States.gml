/// @desc Manage All Player States

function player_state_free(){
	// update _image
	if (sprite_idle				!= spr_player_idle1)			{ sprite_idle				= spr_player_idle1;				}
	if (sprite_walk				!= spr_player_walk)				{ sprite_walk				= spr_player_walk;				}
	if (sprite_run				!= spr_player_run)				{ sprite_run				= spr_player_run;				}
	if (sprite_pace_backwards	!= spr_player_pace_backwards)	{ sprite_pace_backwards		= spr_player_pace_backwards;	}
	if (sprite_death			!= spr_player_death)			{ sprite_death				= spr_player_death;				}
	
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
		if (pace_backwards) {
			if (image_speed != -1) { image_speed = -1; }
			if (sprite_index != sprite_walk) { sprite_index = sprite_walk; }
		} else {
			if (image_speed != 1) { image_speed = 1; }
			if (sprite_index != sprite_run) { sprite_index = sprite_run; }
		}
	} else { 
		if (image_speed != 0) { image_speed = 0; }
		if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
	}
	
	player_flip_image();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// Update Move direction
	player_update_move_direction();
	
	// Update Pace Backwards
	player_update_pace_backwards();
	
	// Update Jump
	player_jump();
	
	// Update Attack
	player_attack();
	
	// Update _interact
	player__interact();
}

function player_state_attack() {
	if (alarm[1] == -1 && alarm[2] == -1) {
		x_speed = 0;
		y_speed = 0;
		if (sprite_index != sprite_attack) { sprite_index = sprite_attack; }
		image_speed = 0;
		image_index = 0;
		alarm[1] = FPS*.1;
	}
	if (alarm[1] == 0) {
		image_index = 1;
		//var _damage = instance_create_layer(x + lengthdir_x(16,face_direction), y+z_bottom + lengthdir_y(16, face_direction), "_instances", obj_damage);
		var _damage = instance_create_depth(x + lengthdir_x(16,face_direction), y+z_bottom + lengthdir_y(16, face_direction), depth, obj_damage);
		
		alarm[2] = FPS*.5;
		player_flip_image();
	}
	
	if (alarm[2] == 0) {
		state = player_state_free;
	}
	
	// TO DO
	/*
	transfer currently equ_ipped weapon data to the damage object
	apply necessary weapon data to the powerup and cooldown t_imes
	*/
}

function player_state__interact() {

}

function player_state_jump() {
	// update _image
	if (sprite_index != sprite_jump) { sprite_index = sprite_jump; }
	player_flip_image();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// Update Move direction
	player_update_move_direction();
	
	// Update Pace Backwards
	player_update_pace_backwards();
	
}

function player_state_fall() {
	// update _image
	if (sprite_index != sprite_fall) { sprite_index = sprite_fall; }
	player_flip_image();
	
	// Update Move direction
	player_update_move_direction();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// Update Pace Backwards
	player_update_pace_backwards();
}

function player_state_climb() {
	// Update _image
	if (sprite_index != sprite_climb) { sprite_index = sprite_climb; }
	if (x_speed != 0 || y_speed != 0) { image_speed = 1; } else { image_speed = 0; }
	
	// Update Movement
	if (x_speed != 0) { x_speed = 0; }
	player_update_y_speed();
	
	// Update Move direction
	player_update_move_direction();
	
}

function player_state_wade() {
	show_debug_message("player_state_wade");
	// set spr_ites
	if (sprite_idle				!= spr_player_wade_idle)			{ sprite_idle			= spr_player_wade_idle;				}
	if (sprite_walk				!= spr_player_wade_walk)			{ sprite_walk			= spr_player_wade_walk;				}
	if (sprite_run				!= spr_player_wade_walk)			{ sprite_run			= spr_player_wade_walk;				}
	if (sprite_pace_backwards	!= spr_player_wade_pace_backwards)	{ sprite_pace_backwards	= spr_player_wade_pace_backwards;	}
	if (sprite_death			!= spr_player_drown)				{ sprite_death			= spr_player_drown;					}
	// update spr_ites
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
		if (pace_backwards) { 
			if (sprite_index != sprite_pace_backwards) { sprite_index = sprite_pace_backwards; }
		} else {
			if (sprite_index != sprite_run) { sprite_index = sprite_run; }
		}
	} else { 
		if (image_speed != 0) { image_speed = 0; }
		if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
	}
	
	player_flip_image();
	
	player_update_move_direction();
	
	player_update_x_speed();
	player_update_y_speed();
	
	player_update_pace_backwards();
}

function player_state_p_itfall() {
	if (sprite_index != sprite_pitfall) {
		sprite_index = sprite_pitfall;
		x_speed = 0;
		y_speed = 0;
		image_index = 0;
		image_speed = max(z_speed,2);
	}
}

function player_state_drown() {
	if (sprite_index != sprite_drown) {
		sprite_index = sprite_drown;
		x_speed = 0;
		y_speed = 0;
		image_index = 0;
	}
}

function player_state_death() {
	if (alarm[0] == -1) { alarm[0] = FPS*2;}
	if (sprite_index != sprite_death) {
		sprite_index = sprite_death;	
		image_index = 0;
	}
}

function player_state_respawn() {
	show_debug_message("runn_ing respawn");
	move_direction = -1;
	face_direction = point_direction(x,y,mouse_x,mouse_y);
	pace_backwards = false; // turn on when player _is pac_ing backwards
	x = last_safe_x;
	y = last_safe_y;
	image_alpha = 1;
	state = player_state_free;
}