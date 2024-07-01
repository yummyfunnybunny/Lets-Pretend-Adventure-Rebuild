
main_camera = view_camera[0];
view_width_half = camera_get_view_width(main_camera)*.5;
view_height_half = camera_get_view_height(main_camera)*.5;
camera_set_view_size(main_camera,320,180);

if (instance_exists(obj_player)) {
	following = obj_player;
}



x_to = xstart;
y_to = ystart;

/*
if (instance_exists(following)) {
	show_debug_message("setting camera to positin over player");
	x = following.x - global.camera_width_half;
	y = following.y - global.camera_height_half;
}
*/

// _in_it_ial_ize camera shake var_iables
shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;