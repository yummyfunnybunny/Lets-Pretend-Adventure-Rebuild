
function enemy_flip_image() {
	if (direction >= 270 && direction <= 360 ||
		direction >= 0 && direction < 90) { 
		image_xscale = 1; 
	} else { 
		image_xscale = -1; 
	}
}

function enemy_image_speed() {
	//image_speed = 1;
}

function enemy_update_sprite() {
	var _sprite;
	switch(nest_state) {
		case enemy_state_idle:			_sprite = sprite_idle;		break;
		case enemy_state_wait:			_sprite = sprite_idle;		break;
		case enemy_state_wander:		_sprite = sprite_move;		break;
		case enemy_state_chase:			_sprite = sprite_move;		break;
		case enemy_state_align:			_sprite = sprite_move;		break;
		case enemy_state_return_origin: _sprite = sprite_move;		break;
		case enemy_state_flee:			_sprite = sprite_move;		break;
		case enemy_state_attack:		_sprite = sprite_attack;	break;
		case enemy_state_death:			_sprite = sprite_death;		break;
		default:						_sprite = sprite_idle;		break;
	}
	
	sprite_index = _sprite;
}