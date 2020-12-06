
// Apply Acceleration
//var _xSign = keyboard_check(moveRight) - keyboard_check(moveLeft);

// right
if (keyboard_check(moveRight)){
	apply_acceleration();
	/*
	if (!place_meeting(x+_xSign,y,obj_solid)){
		if (abs(xSpeed) < maxSpeed) {
			xSpeed += _xSign*accel;
		}
	}
	*/
}

// left 
if (keyboard_check(moveLeft)){
	apply_acceleration();
	/*
	if (!place_meeting(x+_xSign,y,obj_solid)){
		if (abs(xSpeed) < maxSpeed) {
			xSpeed += _xSign*accel;
		}
	}
	*/
}

// Apply Friction
if (!keyboard_check(moveRight) && !keyboard_check(moveLeft) ||
	keyboard_check(moveRight) && keyboard_check(moveLeft)) {
	if (xSpeed != 0){
		xSpeed -= sign(xSpeed)*fric;
	}
	// prevent xSpeed from getting stuck in fric reduction
	if (abs(xSpeed) > fric){
		xSpeed = 0;
	}
}

// Apply Speed
if (xSpeed != 0) {
	if (!place_meeting(x+xSpeed,y,obj_solid)){
		x += xSpeed;
	}else{
		xSpeed = 0;
	}
}