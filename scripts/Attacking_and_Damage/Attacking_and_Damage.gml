
function damage_check_modifiers(_damage_type, _element_type, _dmg_array, _elmt_array) {
	
	// check damage type
	if (_damage_type && array_length(_dmg_array) > 0) {
		for (var _i = 0; _i < array_length(_dmg_array); _i++;){
			if (_damage_type == _dmg_array[_i]) {
				return true;	
			}
		}
	}
	// check element type
	if (_element_type && array_length(_elmt_array) > 0) {
		for (var _i = 0; _i < array_length(_elmt_array); _i++;){
			if (_element_type == _elmt_array[_i]) {
				return true;	
			}
		}
	}
	
	// return false if no matches were found
	return false;
}

function damage_check_armor(_damage) {
	while (armor > 0) {
		_damage--;
		armor--;
	}
	return _damage;
}

