// Update Pace Backwards
/*
function player_update_pace_backwards() {
	if (x_speed != 0 || y_speed != 0) {
		var _move_dir = move_direction div 45;
		var _face_dir = round(face_direction) div 45;
		switch (_move_dir) {
			case 0: if (_face_dir == 3 || _face_dir == 4) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 1: if (_face_dir == 4 || _face_dir == 5) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 2: if (_face_dir == 5 || _face_dir == 6) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 3: if (_face_dir == 6 || _face_dir == 7) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 4: if (_face_dir == 7 || _face_dir == 0) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 5: if (_face_dir == 0 || _face_dir == 1) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 6: if (_face_dir == 1 || _face_dir == 2) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
			case 7: if (_face_dir == 2 || _face_dir == 3) { if (!pace_backwards) { pace_backwards = true; } } else { if (pace_backwards) { pace_backwards = false; } } break;
		}
	} else {
		if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
	}
}
*/