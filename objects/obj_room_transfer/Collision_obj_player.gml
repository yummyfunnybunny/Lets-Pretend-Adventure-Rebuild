/// @desc
if (global.camera.transitioning) { exit; }
//if (global.camera.transitioning == false) {
	global.camera.transition_type = transition_type;
	global.camera.transfer_room = transfer_room;
	global.camera.transfer_x = transfer_x;
	global.camera.transfer_y = transfer_y;
	global.camera.transitioning = true; 
//}