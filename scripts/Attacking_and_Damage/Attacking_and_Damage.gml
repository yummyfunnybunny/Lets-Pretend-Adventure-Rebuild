
function damage_check_modifiers(_damage_type, _element_type, _array) {
	
	// check that the array has anything in it
	if (array_length(_array) == 0) { return false; }
	
	// check damage type
	if (_damage_type && _array) {
		for (var _i = 0; _i < array_length(_array); _i++;){
			if (_damage_type == _array[_i]) {
				return true;	
			}
		}
	}
	// check element type
	if (_element_type) {
		for (var _i = 0; _i < array_length(_array); _i++;){
			if (_element_type == _array[_i]) {
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

