function attack_check_immunities(_dmg_type, _obj) {
	for (var _i = 0; _i < array_length(_obj.immune_array); _i++;){
		if (_dmg_type == _obj.immune_array[_i]) {
			return true;	
		}else {
			return false;	
		}
	}
}

function attack_check_vulnerabilities(_dmg_type, _obj) {
	for (var _i = 0; _i < array_length(_obj.vulnerable_array); _i++;){
		if (_dmg_type == _obj.vulnerable_array[_i]) {
			return true;	
		}else {
			return false;	
		}
	}
}

function damage_modifier(_dmg_type, _obj, _modifier_array) {
	for (var _i = 0; _i < array_length(_modifier_array); _i++;){
		if (_dmg_type == _modifier_array[_i]) {
			return true;	
		}else {
			return false;
		}
	}
}

