
function player_update_image(_state_sprite) {
	switch(face_direction) {
		case 0:			sprite_index = asset_get_index(string(_state_sprite) + "_right");	break;
		case 90:		sprite_index = asset_get_index(string(_state_sprite) + "_up");		break;
		case 180:		sprite_index = asset_get_index(string(_state_sprite) + "_left");	break;
		case 270:		sprite_index = asset_get_index(string(_state_sprite) + "_down");	break;
	}
}