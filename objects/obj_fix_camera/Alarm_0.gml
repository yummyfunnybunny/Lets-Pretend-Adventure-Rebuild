/// @desc

global.camera.following = obj_player;
global.camera.zoom = 1;
global.camera.zoom_type = "in";
global.camera.zooming = true;
// TODO - re-enable player input

if (delete_on_end) {
	instance_destroy();
}