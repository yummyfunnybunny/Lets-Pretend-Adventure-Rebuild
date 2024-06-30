/// @desc Manage All Player States

function player_state_free(){
	// update _image
	//if (sprite_idle				!= spr_player2_idle1)			{ sprite_idle				= spr_player2_idle1;			}
	//if (sprite_walk				!= spr_player2_walk)			{ sprite_walk				= spr_player2_walk;				}
	//if (sprite_run				!= spr_player2_run)				{ sprite_run				= spr_player2_run;				}
	//if (sprite_death			!= spr_player2_death)			{ sprite_death				= spr_player2_death;			}
	//if (sprite_hurt				!= spr_player2_hurt)			{ sprite_hurt				= spr_player2_hurt;				}
	
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
		player_image_moving();
		//if (sprite_index != sprite_run) { sprite_index = sprite_run; }
	} else { 
		if (image_speed != 0) { image_speed = 0; }
		player_image_idle();
		//if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
	}
	
	//player_flip_image();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// Update Move direction
	player_update_move_direction();
	
	// update face_direction
	player_update_face_direction();
	
	
	// update b input
	player_b_input();

	// Update Jump
	player_jump();
	
	// Update Attack
	player_attack();
	
	// Update _interact
	player__interact();
	
	// update knockback
	entity_update_knockback();
}

function player_state_attack() {
	var _type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE,item_id_used);
	//show_message(_type);
	switch (_type) {
		case "sword":		player_state_attack_sword();	break;
		case "shield":		player_state_attack_sword();	break;
		case "boomstick":	player_state_attack_sword();	break;
		case "flail":		player_state_attack_sword();	break;
		case "crossbow":	player_state_attack_sword();	break;
		case "tomahawk":	player_state_attack_sword();	break;
	}

	
	// update knockback
	entity_update_knockback();
	
	// TO DO
	/*
	apply necessary weapon data to the powerup and cooldown times
	*/
}

function player_state_attack_sword() {
		// begin attack
	if (alarm[P_ALARM.ATK_START] == -1 && alarm[P_ALARM.ATK_END] == -1 && alarm[P_ALARM.DAMAGED] == -1) {
		image_index = 0;
		x_speed = 0;
		y_speed = 0;
		// get weapon type
		var _weapon_type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE, equip_slot_used);
		player_image_attack(_weapon_type);
		alarm[P_ALARM.ATK_START] = -2;
	}
	
	// during attack
	if (alarm[P_ALARM.ATK_START] == -2) {
		
		if (image_index = 3) {
			var _y_offset = 0;
			if (face_direction == 90) _y_offset = -16;
			var _damage = instance_create_layer(x + lengthdir_x(40,face_direction), y+_y_offset+z_bottom + lengthdir_y(24, face_direction), global.main_layer, obj_damage_sword, {
			direction: face_direction,
			faction: faction,
			creator: id,
			damage: 1,
			knockback_amount: 7,
			damage_type: DAMAGE_TYPE.PIERCE,
			});
		}
	}
	
	// end attack
}

function player_state_attack_crossbow() {
	// begin attack
	if (alarm[P_ALARM.ATK_START] == -1 && alarm[P_ALARM.ATK_END] == -1 && alarm[P_ALARM.DAMAGED] == -1) {
		image_index = 0;
		x_speed = 0;
		y_speed = 0;
		// get weapon type
		var _weapon_type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE, equip_slot_used);
		player_image_attack(_weapon_type);
		alarm[P_ALARM.ATK_START] = -2;
	}
	
	// during attack
	
	
	// end attack
	
}

function player_state_attack_shield() {
	// begin attack
	
	
	// during attack
	
	
	// end attack
}

function player_state_attack_boomstick() {
	// begin attack
	
	
	// during attack
	
	
	// end attack
}

function player_state_attack_tomahawk() {
	// begin attack
	
	
	// during attack
	
	
	// end attack
}

function player_state_attack_flail() {
	// begin attack
	
	
	// during attack
	
	
	// end attack
}

function player_state__interact() {
	// begin attack
	
	
	// during attack
	
	
	// end attack
}

function player_state_knockback() {
	
	// update image
	if (sprite_index != sprite_hurt) sprite_index = sprite_hurt;
	
	entity_update_knockback();
}

function player_state_jump() {
	// update _image
	if (sprite_index != sprite_jump) { sprite_index = sprite_jump; }
	//player_flip_image();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// Update Move direction
	player_update_move_direction();
	
	// update face_direction
	player_update_face_direction();
	
	// update knockback
	entity_update_knockback();
	
}

function player_state_fall() {
	// update _image
	if (sprite_index != sprite_fall) { sprite_index = sprite_fall; }
	//player_flip_image();
	
	// Update Move direction
	player_update_move_direction();
	
	// update face_direction
	player_update_face_direction();
	
	// update x_speed and y_speed
	player_update_x_speed();
	player_update_y_speed();
	
	// update knockback
	entity_update_knockback();
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
	
	// update face_direction
	player_update_face_direction();
	
	// update knockback
	entity_update_knockback();
	
}

function player_state_wade() {
	
	// set sprites
	if (sprite_idle	!= spr_player2_wade_idle)			{ sprite_idle = spr_player2_wade_idle;		}
	if (sprite_walk	!= spr_player2_wade_walk)			{ sprite_walk = spr_player2_wade_walk;		}
	if (sprite_run	!= spr_player2_wade_walk)			{ sprite_run = spr_player2_wade_walk;		}
	if (sprite_death != spr_player2_drown)				{ sprite_death = spr_player2_drown;			}
	
	// update sprites
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
		if (sprite_index != sprite_run) { sprite_index = sprite_run; }
	} else { 
		if (image_speed != 0) { image_speed = 0; }
		if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
	}
	
	//player_flip_image();
	
	player_update_move_direction();
	
	player_update_face_direction();
	
	player_update_x_speed();
	player_update_y_speed();
	
	// update knockback
	entity_update_knockback();
}

function player_state_pitfall() {
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
	
	if (knockback_x != 0) knockback_x = 0;
	if (knockback_y != 0) knockback_y = 0;
	
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	
	
	if (alarm[0] == -1) { alarm[0] = FPS*2;}
	if (sprite_index != sprite_death) {
		sprite_index = sprite_death;	
		image_index = 0;
	}
	
	if (alarm[0] == 0) {
		if (hp <= 0) {
			// Game Over
			game_restart();
		} else {
			state = player_state_respawn;
		}
	}
}

function player_state_respawn() {
	move_direction = -1;
	face_direction = point_direction(x,y,mouse_x,mouse_y);
	x = last_safe_x;
	y = last_safe_y;
	image_alpha = 1;
	state = player_state_free;
	alarm[2] = FPS*1;
}