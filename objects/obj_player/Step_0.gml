
// == Update Inputs ==
var _moveRight = keyboard_check(moveRight);
var _moveLeft = keyboard_check(moveLeft);
var _moveDown = keyboard_check(moveDown);
var _moveUp = keyboard_check(moveUp);
var _jump = keyboard_check_pressed(jump);
var _restart = keyboard_check_pressed(restart);

// == Restart Game ==
if (_restart){
	game_restart();
}

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
	 //show_debug_message("xSpeed: " +string(xSpeed));
	 x += xSpeed;
 }
// vertical
if (ySpeed != 0){
	ySpeed = xy_collision_check(0,ySpeed);
	//show_debug_message("ySpeed: " +string(ySpeed));
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
	zSpeed = -zJumpSpeed;
}

// update z_prev and zTop
if (zPrevious != zBottom) {
	zPrevious = zBottom;
	zTop = zBottom - zHeight;
}
// Apply zSpeed
if (zSpeed != 0){
	zBottom += zSpeed;
}

// Apply Gravity
if (zBottom < zFloor){
	if (zSpeed < maxFallSpeed || zSpeed > maxFallSpeed*(-1)){
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
		// dont have a bounce, stay on ground
		zSpeed = 0;
		zBottom = zFloor;	// the extra pixel prevents little move bugs
	}
}

// Prevent Exceeding zRoof
if (zTop < zRoof){
	zSpeed = 0;
	zBottom = zRoof+zHeight;
}

// update onGround
if (zBottom = zFloor){
	onGround = true;
}else if (zBottom < zFloor){
	onGround = false;
}

// set z limits
if (x != xprevious || y != yprevious) {
	set_z_limits();
	
}
