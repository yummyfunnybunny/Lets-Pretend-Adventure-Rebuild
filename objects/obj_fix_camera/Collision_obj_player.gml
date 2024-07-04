/// @desc

if (alarm[0] == -1) {
	alarm[0] = game_get_speed(gamespeed_fps)* timer;
	global.camera.following = noone;
	global.camera.x_to = x_to;
	global.camera.y_to = y_to;
	if (zoom > 1) {
		global.camera.zoom = zoom;
		global.camera.zoom_type = "out";
		global.camera.zooming = true;
	}
	// TODO - need to disable player input and stop player from moving
}