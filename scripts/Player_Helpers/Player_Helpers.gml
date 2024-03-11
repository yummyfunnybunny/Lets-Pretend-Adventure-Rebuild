

function player_apply_damage(_amount) {
	hp -= _amount;
}

function player_set_weapon_offset() {
	switch (face_direction) {
		case 90: return 8;	break;
		default: return 0;	break;
	}
}