
function enemy_apply_damage_to_player(_amount) {
	other.hp -= _amount;
}

function enemy_start_damage() {
	// set additional damage function
	var _function = undefined;
	if (argument_count > 0) {
		_function = argument[0];
	}
	// run additional damage function
	if (_function != undefined) {
		script_execute(_function);
	} else {
	// finalize damage
		var _damage = enemy_modify_damage(apply_damage.damage);
		enemy_end_damage(_damage);
	}
}

function enemy_modify_damage(_damage) {
	// apply vulnerabilities
	if (damage_modifier(apply_damage.damage_type, id, vulnerable_array) == true) { _damage *= round(_damage*2); }
	// apply resistances
	if (damage_modifier(apply_damage.damage_type, id, resistance_array) == true) {	_damage /= round(_damage*2); }
	// apply immunities
	if (damage_modifier(apply_damage.damage_type, id, immune_array) == true) { _damage = 0; }
	return _damage;
}

function enemy_end_damage(_damage) {
	// apply knockback
	var _knockback_direction = point_direction(target.x,target.y,x,y);
	apply_knockback(id, apply_damage.knockback_amount, knockback_reduction, _knockback_direction);
	
	// finalize
	hp -= _damage;
	just_got_damaged = true;
	alarm[2] = FPS*0.5;
	nest_state = enemy_state_hurt;
	if (alarm[3] > -1) alarm[3] = -1;
	if (alarm[4] > -1) alarm[4] = -1;
	apply_damage = 0;
}

// aggro range check
function enemy_aggro_range_check(){
	if (target != noone) {
		if (point_distance(x,y,target.x,target.y) <= aggro_range*COL_TILES_SIZE) return true;
	}
}

// return origin check
function enemy_return_origin_check() {
	if (point_distance(x,y,origin_x,origin_y) >= origin_range*COL_TILES_SIZE) return true;
}

function enemey_attack_range_check() {
	if (target != noone) {
		var _dis = point_distance(x,y,target.x,target.y);
		if (_dis <= attack_range*COL_TILES_SIZE) { return true; } else { return false; }
	}
}

function enemy_set_target() {
	if (!instance_exists(target)) {
		if (instance_exists(obj_player)){
			target = instance_nearest(x,y,obj_player);	
		} else if (target != noone) target = noone;
	}
	
	if (instance_exists(target)) {
		if (target.state == player_state_death) {
			if (target != noone) target = noone;	
		}
	}
	
}

function enemy_quadrant_check(_target) {
	// _obj = the object you are trying to check the quadrant you are in
	
	// grid legend
	//      13     16     6
	//        . 12 |  5 .     
	//          .  |  .   4    
	//     11     .|.         
	// 14 --------17----------  7
	//           . | .        
	//      8  .   |   .  1    
	//       .  9  |  2  .    
	//    10       15      3       

	var _delta_x = x - _target.x;
	var _delta_y = y - _target.y;
	var _delta_dif = abs(_delta_x) - abs(_delta_y);
	
	switch(sign(_delta_x)){
		// 1 = you are on the right side of the target on the x-axis
		case 1:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1:
					if (_delta_dif > 0) return 1; else
					if (_delta_dif < 0) return 2; else
					if (_delta_dif = 0) return 3; break;
				// -1 = you are above the target on the y-axis
				case -1:
					if (_delta_dif > 0) return 4; else
					if (_delta_dif < 0) return 5; else
					if (_delta_dif = 0) return 6; break;
				case 0: return 7; break;
			}
		break;
		//------------------------------------------------------------
		// -1 = you are on the left side of the target on the x-axis
		case -1:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1:
					if (_delta_dif > 0) return 8; else
					if (_delta_dif < 0) return 9; else
					if (_delta_dif = 0) return 10; break;
				// -1 = you are above the target on the y-axis
				case -1:
					if (_delta_dif > 0) return 11; else
					if (_delta_dif < 0) return 12; else
					if (_delta_dif = 0) return 13; break;
				case 0: return 14; break;
			}
		break;
		//------------------------------------------------------------
		// 0 = you are aligned to the target on the x-axis
		case 0:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1: return 15; break;
				// -1 = you are above the target on the y-axis
				case -1: return 16; break;
				// 0 = you are aligned with the target on the y-axis
				case 0: return 17; break;
			}
		break;
	}
}

