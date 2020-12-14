// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_movement(_maxSpeed){
	xSpeed = 0;
	ySpeed = 0;
	maxSpeed = _maxSpeed;
	
	// set acceleration with default option
	if (argument_count<2){
		accel = 0.2;	
	}else {
		accel = argument[1];
	}
	
	if (argument_count <3){
		fric = 0.1;
	}else {
		fric = argument[2];
	}
	
}