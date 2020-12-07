
function apply_acceleration(input1, input2, _speed) {
	// get the direction of current movement
	var _sign = input1 - input2;
	
	// apply acceleration if speed is not at maxSpeed
	if (abs(_sign*_speed) <= abs(_sign*maxSpeed)) {
		_speed += _sign*accel;
	}
	// prevent exceeding maxSpeed
	if (abs(_speed) > maxSpeed){
		_speed = _sign*maxSpeed;
	}
	// return the speed
	return _speed;
}

/*
function apply_speed(_speed) {
	// check if there is any speed to apply
	if (_speed != 0){
		return _speed;
	}else{
		return 0;
	}
}