
function player_update_max_speed() {
	switch(terrain_state) {
		case TERRAIN_TYPE.NONE:				if (max_speed != run_speed)		max_speed = run_speed;		break;
		case TERRAIN_TYPE.SHALLOW_WATER:	if (max_speed != wade_speed)	max_speed = wade_speed;		break;
		case TERRAIN_TYPE.TALL_GRASS:		if (max_speed != wade_speed)	max_speed = wade_speed;		break;
		case TERRAIN_TYPE.LADDER:			if (max_speed != climb_speed)	max_speed = climb_speed;	break;
		default:							if (max_speed != run_speed)		max_speed = run_speed;	 	break;
	}
	
	switch(nest_state) {
		case nest_state_push:
			if (max_speed != push_speed) { max_speed = push_speed; }
		break;
	}
	
}

function player_update_move_direction() {
	if (instance_exists(obj_con_textbox)) { exit; }

	var _x_spd = right_input - left_input;
	var _y_spd = down_input - up_input;
	if (_x_spd == 1 && _y_spd = 0)		{ move_direction = 0; }
	if (_x_spd == 1 && _y_spd = -1)		{ move_direction = 45; }
	if (_x_spd == 0 && _y_spd = -1)		{ move_direction = 90; }
	if (_x_spd == -1 && _y_spd = -1)	{ move_direction = 135; }
	if (_x_spd == -1 && _y_spd = 0)		{ move_direction = 180; }
	if (_x_spd == -1 && _y_spd = 1)		{ move_direction = 225; }
	if (_x_spd == 0 && _y_spd = 1)		{ move_direction = 270; }
	if (_x_spd == 1 && _y_spd = 1)		{ move_direction = 315; }
	if (_x_spd == 0 && _y_spd = 0)		{ move_direction = -1; }
}

function player_update_face_direction() {
	// whichever input is first is whats used and whichever unput is last is than used
	if (item_used != noone) { exit; }
	if (nest_state = nest_state_push) { exit; }
	
	// first move input
	if (move_direction == -1) {
		var _move_dir_prev = 0;
		switch(move_direction) {
			case 0: 
				face_direction = 0;
				_move_dir_prev = 0;
			break;
			
			case 45:
				if (_move_dir_prev == 0) {
					face_direction = 0;
				} else {
					face_direction = 90;
				} 
			break;
			
			case 90: 
				face_direction = 90; 
				_move_dir_prev = 90; 
			break;
			
			case 135: 
				if (_move_dir_prev == 180) { 
					face_direction = 180; 
				} else {
					face_direction = 90; 
				} 
			break;
			
			case 180: 
				face_direction = 180; 
				_move_dir_prev = 180; 
			break;
			
			case 225: 
				if (_move_dir_prev == 270) { 
					face_direction = 270; 
				} else {
					face_direction = 180; 
				} 
			break;
			
			case 270: 
				face_direction = 270; 
				_move_dir_prev = 270; 
			break;
			
			case 315: 
				if (_move_dir_prev == 0) { 
					face_direction = 0; 
				} else { 
					face_direction = 270;
				} 
			break;
		}
	}
	// last move input
	if (move_direction != -1) {
		var _move_dir_prev = 0;
		switch(move_direction) {
			case 0: 
				face_direction = 0; 
				_move_dir_prev = 0; 
			break;
			
			case 45: 
				if (_move_dir_prev == 0) {
					face_direction = 0;
				} else {
					face_direction = 90;
				}
			break;
			
			case 90: 
				face_direction = 90; 
				_move_dir_prev = 90; 
			break;
			
			case 135: 
				if(_move_dir_prev == 180) {
					face_direction = 180; 
				} else {
					face_direction = 90;
				}
			break;
			
			case 180: 
				face_direction = 180; 
				_move_dir_prev = 180; 
			break;
			
			case 225: 
				if(_move_dir_prev == 270) {
					face_direction = 270;
				} else {
					face_direction = 180;
				}
			break;
			
			case 270: 
				face_direction = 270; 
				_move_dir_prev = 270; 
			break;
			
			case 315: 
				if(_move_dir_prev == 0) {
					face_direction = 0;
				} else {
					face_direction = 270;
				}
			break;
		}
	}
}

function player_update_x_speed() {
	if (nest_state == nest_state_attack_sword) { exit; }
	if (knockback_check()) { exit; }
	
	// Set initial x_speed based on user input
	if (move_direction != -1) {
			x_speed += lengthdir_x(acceleration, move_direction);
	}
	
	// Prevent x_speed from exceeding max_speed
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
		
	// set x_speed to 0 if no input and x_speed is low enough
	if (!left_input && !right_input) {
		if (abs(x_speed <= .2)) x_speed = 0;
	}
	
	// check pushing/carrying objects for stoppage
	if (nest_state == nest_state_push || nest_state == nest_state_carry) {
			
	}
}

function player_update_y_speed() {
	if (nest_state == nest_state_attack_sword) { exit; }
	if (knockback_check()) { exit; }
	
	// Set initial y_speed based on user input
	if (move_direction != -1) {
			y_speed += lengthdir_y(acceleration, move_direction);
	}
	
	// Prevent y_speed from exceeding max_speed
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
		
	// set y_speed to 0 if no input and y_speed is low enough
	if (!up_input && !down_input) {
		if (abs(y_speed <= .2)) y_speed = 0;
	}
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


