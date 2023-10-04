///@desc 

function player_update_max_speed() {
	switch (state) {
		case player_state_free:
			if (pace_backwards) { 
				if (max_speed != reverse_speed) { 
					max_speed = reverse_speed; 
				} 
			} else { 
				if (max_speed != run_speed) { 
					max_speed = run_speed; 
				} 
			}
		break;
		
		case player_state_wade:
			if (pace_backwards) { 
				if (max_speed != reverse_speed) { 
					max_speed = reverse_speed; 
				} 
			} else { 
				if (max_speed != wade_speed) { 
					max_speed = wade_speed; 
				} 
			}
		break;
		
		case player_state_climb:
			if (max_speed != climb_speed) { 
				max_speed = climb_speed; 
			}
		break;
	}
}

// set move_direction based on player _input
function player_update_move_direction() {
	var _x_spd = right_input - left_input;
	var _y_spd = down_input - up_input;
	if (_x_spd == 1 && _y_spd = 0) { move_direction = 0;  }
	if (_x_spd == 1 && _y_spd = -1) { move_direction = 45; }
	if (_x_spd == 0 && _y_spd = -1) { move_direction = 90; }
	if (_x_spd == -1 && _y_spd = -1) { move_direction = 135; }
	if (_x_spd == -1 && _y_spd = 0) { move_direction = 180; }
	if (_x_spd == -1 && _y_spd = 1) { move_direction = 225; }
	if (_x_spd == 0 && _y_spd = 1) { move_direction = 270; }
	if (_x_spd == 1 && _y_spd = 1) { move_direction = 315; }
	if (_x_spd == 0 && _y_spd = 0) { move_direction = -1; }
}

// set face_direction
function player_update_face_direction() {
	// whichever input is first is whats used and whichever unput is last is than used
	
	// first move input
	if (move_direction == -1) {
		var _move_dir_prev = 0;
		switch(move_direction) {
			case 0: face_direction = 0; _move_dir_prev = 0; break;
			case 45: if (_move_dir_prev == 0) face_direction = 0 else face_direction = 90; break;
			case 90: face_direction = 90; _move_dir_prev = 90; break;
			case 135: if(_move_dir_prev == 180) face_direction = 180 else face_direction = 90; break;
			case 180: face_direction = 180; _move_dir_prev = 180; break;
			case 225: if(_move_dir_prev == 270) face_direction = 270 else face_direction = 180; break;
			case 270: face_direction = 270; _move_dir_prev = 270; break;
			case 315: if(_move_dir_prev == 0) face_direction = 0 else face_direction = 270; break;
		}
	}
	// last move input
	if (move_direction != -1) {
		var _move_dir_prev = 0;
		switch(move_direction) {
			case 0: face_direction = 0; _move_dir_prev = 0; break;
			case 45: if (_move_dir_prev == 0) face_direction = 0 else face_direction = 90; break;
			case 90: face_direction = 90; _move_dir_prev = 90; break;
			case 135: if(_move_dir_prev == 180) face_direction = 180 else face_direction = 90; break;
			case 180: face_direction = 180; _move_dir_prev = 180; break;
			case 225: if(_move_dir_prev == 270) face_direction = 270 else face_direction = 180; break;
			case 270: face_direction = 270; _move_dir_prev = 270; break;
			case 315: if(_move_dir_prev == 0) face_direction = 0 else face_direction = 270; break;
		}
	}
}

function player_update_x_speed() {
	// Set _in_it_ial x_speed based on user _input
	if (move_direction != -1) {
			x_speed += lengthdir_x(acceleration, move_direction);
	}
	
	// Prevent x_speed from exceed_ing max_speed
	if (sign(lengthdir_x(max_speed,move_direction)) == -1) {
		if (x_speed < lengthdir_x(max_speed,move_direction)) {
			x_speed = lengthdir_x(max_speed,move_direction);	
		}
	} else 
	if (sign(lengthdir_x(max_speed, move_direction)) == 1) {
		if (x_speed > lengthdir_x(max_speed,move_direction)) {
			x_speed = lengthdir_x(max_speed,move_direction);	
		}
	}
	
	// keep x_speed rounded to .2 dec_imals
	if (x_speed != 0) x_speed = round(x_speed/.2)*.2;
}

function player_update_y_speed() {
	// Set _in_it_ial y_speed based on user _input
	if (move_direction != -1) {
			y_speed += lengthdir_y(acceleration, move_direction);
	}
	
	// Prevent y_speed from exceed_ing max_speed
	if (sign(lengthdir_y(max_speed,move_direction)) == -1) {
		if (y_speed < lengthdir_y(max_speed,move_direction)) {
			y_speed = lengthdir_y(max_speed,move_direction);	
		}
	} else 
	if (sign(lengthdir_y(max_speed, move_direction)) == 1) {
		if (y_speed > lengthdir_y(max_speed,move_direction)) {
			y_speed = lengthdir_y(max_speed,move_direction);	
		}
	}
	
	// keep y_speed rounded to .2 dec_imals
	if (y_speed != 0) y_speed = round(y_speed/.2)*.2;
}

function player_apply_friction() {
	if (x_speed != 0) {
		if (!right_input && !left_input || right_input && left_input) {
			x_speed -= sign(x_speed)*friction;
		}
	}
	if (y_speed != 0) {
		if (!down_input && !up_input || down_input && up_input) {
			y_speed -= sign(y_speed)*friction;
		}	
	}	
}


// Update Pace Backwards
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
