
// == Update Inputs ==
var _moveRight = keyboard_check(moveRight);
var _moveLeft = keyboard_check(moveLeft);
var _moveDown = keyboard_check(moveDown);
var _moveUp = keyboard_check(moveUp);
var _jump = keyboard_check_pressed(jump);

/*
if (keyboard_check_pressed(_jump)) {
	//show_debug_message("jump key pressed");
}
*/

// == Apply Acceleration ==
// horizontal
if (_moveRight || _moveLeft){
	xSpeed = apply_acceleration(_moveRight,_moveLeft, xSpeed);
}
// vertical
if (_moveDown || _moveUp){
	ySpeed = apply_acceleration(_moveDown,_moveUp, ySpeed);
}

// == Apply Speed ==
// horizontal
 if (xSpeed != 0){
	 xSpeed = xy_collision_check(xSpeed,0);
	 x += xSpeed;
 }
// vertical
 if (ySpeed != 0){
	 ySpeed = xy_collision_check(0,ySpeed);
	 y += ySpeed;
 }

// == Apply Friction ==
// horizontal
if (xSpeed != 0) {
	xSpeed -= apply_friction(_moveRight,_moveLeft,xSpeed);
}
// vertical
if (ySpeed != 0) {
	ySpeed -= apply_friction(_moveDown,_moveUp,ySpeed);
}

// == Z AXIS FUNCTIONS == 
// apply jump
if (_jump == true && zBottom == zFloor){
	//show_message("applying jump");
	zSpeed = -zJumpSpeed;
}

// update z_prev before doing anything else
if (zSpeed != 0) {
	zPrevious = zBottom;
}
// Apply zSpeed
if (zSpeed != 0){
	//zSpeed = set_z_limits(zSpeed);
	zBottom += zSpeed;
}

// Apply Gravity
if (zBottom < zFloor){
	show_debug_message("apply gravity 1");
	if (zSpeed < maxFallSpeed || zSpeed > maxFallSpeed*(-1)){
		show_debug_message("apply gravity 2");
		zSpeed += zGravity;
	}
}

// Prevent Exceeding maxFallSpeed
if (zSpeed > maxFallSpeed){
	zSpeed = maxFallSpeed;
}

// Apply Bounce
if (zBottom >= zFloor){
	
	// checks if its reasonable to have no bounce
	if (zSpeed > 0 && abs(zSpeed) > 1){
		zSpeed = -zSpeed*zBounce;
	}else{
		// dont have a bounce
		zSpeed = 0;
		zBottom = zFloor;	// the extra pixel prevents little move bugs
	}
}

// Prevent Exceeding zRoof
if (zTop < zRoof){
	zSpeed = 0;
	zBottom = zRoof+zHeight;
}
