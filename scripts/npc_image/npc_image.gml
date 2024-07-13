
function npc_flip_image() {
	if (direction >= 270 && direction <= 360 ||
		direction >= 0 && direction < 90) { 
		image_xscale = 1; 
	} else { 
		image_xscale = -1; 
	}
}

function npc_update_sprite() {
	var _sprite;
	switch(nest_state) {
		case nest_state_idle:			_sprite = sprite_idle;		break;
		case nest_state_wait:			_sprite = sprite_idle;		break;
		case nest_state_wander:			_sprite = sprite_move;		break;
		case nest_state_patrol:			_sprite = sprite_move;		break;
		case nest_state_interact:		_sprite = sprite_interact;	break;
		case nest_state_chase:			_sprite = sprite_move;		break;
		case nest_state_align:			_sprite = sprite_move;		break;
		case nest_state_return_origin:	_sprite = sprite_move;		break;
		case nest_state_flee:			_sprite = sprite_move;		break;
		case nest_state_attack:			_sprite = sprite_attack;	break;
		case nest_state_death_normal:	_sprite = sprite_death;		break;
		case nest_state_death_drown:	_sprite = spr_splash;		break;
		case nest_state_death_pitfall:	_sprite = spr_pitfall;		break;
		default:						_sprite = sprite_idle;		break;
	}
	
	sprite_index = _sprite;
}