

function apply_acceleration(){
	// right = 1 / left = -1
	var _xSign = keyboard_check(moveRight) - keyboard_check(moveLeft);
	if (!place_meeting(x+_xSign,y,obj_solid)){
		if (abs(xSpeed) < maxSpeed) {
			xSpeed += _xSign*accel;
		}
	}
	// prevent exceeding maxSpeed
	if (abs(xSpeed) > maxSpeed){
		xSpeed = maxSpeed;
	}
}