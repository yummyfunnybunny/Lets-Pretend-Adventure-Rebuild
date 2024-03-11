/// @desc ???


// fl_ip _image to xScale
/*
function player_flip_image() {
	if (face_direction >= 270 && face_direction <= 360 ||
		face_direction >= 0 && face_direction < 90) { 
		image_xscale = 1; 
	} else { 
		image_xscale = -1; 
	}
}
*/

function player_image_control() {
	
	// idle state
	//if (state = player_state_
}

function player_image_moving() {
	switch(face_direction) {
		case 0:		sprite_index = spr_player_move_right;		break;
		case 90:	sprite_index = spr_player_move_up;			break;
		case 180:	sprite_index = spr_player_move_left;		break;
		case 270:	sprite_index = spr_player_move_down;		break;
	}
}

function player_image_idle() {
	switch(face_direction) {
		case 0:		sprite_index = spr_player_idle_right;		break;
		case 90:	sprite_index = spr_player_idle_up;			break;
		case 180:	sprite_index = spr_player_idle_left;		break;
		case 270:	sprite_index = spr_player_idle_down;		break;
	}
}

function player_image_attack(_weapon_type) {
	var _face_dir = "";
	switch(face_direction) {
		case 0:		_face_dir = "right";	break;
		case 90:	_face_dir = "up";		break;
		case 180:	_face_dir = "left";		break;
		case 270:	_face_dir = "down";		break;	
	}
	
	//show_message("spr_player_atk_" + string(_weapon_type) + "_" + string(_face_dir));
	sprite_index = asset_get_index("spr_player_atk_" + string(_weapon_type) + "_" + string(_face_dir));
	image_speed = 1;
}