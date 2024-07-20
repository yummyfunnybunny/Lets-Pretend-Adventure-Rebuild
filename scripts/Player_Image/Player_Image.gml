
function player_update_image() {
	
	// 1 - determine nest_state
	var _state = player_image_state();
	
	// 2 - determine current speed
	var _speed = player_image_speed(_state);
	
	// 3 - determine terrain state
	var _terrain = player_image_terrain(_state, _speed);
	
	// 4 - determine face direction
	var _face_dir = player_image_face_dir(_state, _speed, _terrain);
	
	// 5 - set the sprite
	sprite_index = asset_get_index($"spr_player{_state}{_speed}{_terrain}{_face_dir}");
}

function player_image_state() {
	var _state;
	switch(nest_state) {
		case nest_state_free:				_state = "";					break;
		case nest_state_jump:				_state = "_jump";				break;
		case nest_state_fall:				_state = "_fall";				break;
		case nest_state_hurt:				_state = "_hurt";				break;
		case nest_state_climb:				_state = "_climb";				break;
		case nest_state_carry:				_state = "_carry";				break;
		case nest_state_push:				_state = "_push";				break;
		case nest_state_pull:				_state = "_pull";				break;
		case nest_state_death_drown:		_state = "_death_drown";		break;
		case nest_state_death_normal:		_state = "_death_normal";		break;
		case nest_state_death_pitfall:		_state = "_death_pitfall";		break;
		case nest_state_attack_sword:		_state = "_attack_sword";		break;
		case nest_state_attack_crossbow:	_state = "_attack_crossbow";	break;
		case nest_state_attack_shield:		_state = "_attack_shield";		break;
		case nest_state_attack_boomstick:	_state = "_attack_boomstick";	break;
		case nest_state_attack_flial:		_state = "_attack_flail";		break;
		case nest_state_attack_tomahawk:	_state = "_attack_tomahawk";	break;
	}
	return _state;
}

function player_image_speed(_state) {
	var _speed = "";
	
	// skip for instances where move and idle are the same for the given state
	if (_state != "" && _state != "_carry" && _state != "_push" && _state != "_pull") { return _speed; }
	
	if (x_speed != 0 || y_speed != 0) {
		return "_move";
	} else {
		return "_idle";
	}
}

function player_image_terrain(_state, _speed) {
	var _terrain;
	switch(terrain_state){
		case TERRAIN_TYPE.NONE:			_terrain = "";		break;
		case TERRAIN_TYPE.WALL:			_terrain = "";		break;
		case TERRAIN_TYPE.SHALLOW_WATER:	_terrain = "_wade";	break;
		case TERRAIN_TYPE.DEEP_WATER:	_terrain = "";		break;
		case TERRAIN_TYPE.LADDER:		_terrain = "";		break;
		case TERRAIN_TYPE.TALL_GRASS:	_terrain = "_wade";	break;
		case TERRAIN_TYPE.PITFALL:		_terrain = "";		break;
	}
	return _terrain;
}

function player_image_face_dir(_state, _speed, _terrain) {
	var _face_dir;
	switch (face_direction) {
		case 0:			_face_dir = "_right"	break;
		case 90:		_face_dir = "_up"		break;	
		case 180:		_face_dir = "_left"		break;	
		case 270:		_face_dir = "_down"		break;	
	}
	return _face_dir;
}


