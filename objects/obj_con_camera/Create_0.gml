
main_camera = view_camera[0];
view_width_half = camera_get_view_width(main_camera)*.5;
view_height_half = camera_get_view_height(main_camera)*.5;
camera_set_view_size(main_camera,320,180);

if (instance_exists(obj_player)) {
	following = obj_player;
}



x_to = xstart;
y_to = ystart;

// _in_it_ial_ize camera shake var_iables
shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;

#region INITIALIZE SCREEN TRANSITION

	global.transitioning = false;
	global.transition_type = noone;
	global.transfer_room = noone;
	global.transfer_x = 0;
	global.transfer_y = 0;
	transition_curve = animcurve_get_channel(ac_curve_room_transition,"curve1");
	transition_percent = 0;
	transition_left = 0;
	transition_top = 0;
	transition_right = global.gui_width;
	transition_bottom = global.gui_height;
	transition_center_left = 0;
	transition_center_top = 0;
	transition_center_right = global.gui_width;
	transition_center_bottom = global.gui_height;
	draw_transition = false;
	draw_gui_x = 0;
	draw_gui_y = 0;

#endregion