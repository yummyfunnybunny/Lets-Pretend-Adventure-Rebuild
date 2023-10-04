
function enemy_apply_damage_to_player(_amount) {
	other.hp -= _amount;	
}

// aggro range check
function enemy_aggro_range_check(){
	if (point_distance(x,y,obj_player.x,obj_player.y) <= 100) {
		if (state != enemy_state_chase) state = enemy_state_chase;
	}
}

// return origin check
function enemy_return_origin_check() {
	if (point_distance(x,y,origin_x,origin_y) >= origin_range*COL_TILES_SIZE) {
			if (state != enemy_state_return_origin) state = enemy_state_return_origin;
	}
}

function enemey_attack_range_check() {
	var _dis = point_distance(x,y,obj_player.x,obj_player.y);
	
	if (_dis <= attack_range) { return true; } else { return false; }
}