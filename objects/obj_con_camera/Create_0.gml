// Camera 1 _in_it
/*
enum camera_mode {
	follow_object,
	follow_mouse_drag,
	follow_mouse_border,
	follow_mouse_peek,
	move_to_target,
	move_to_follow_object,
}

main_camera = view_camera[0];
mode = camera_mode.follow_mouse_peek;
following = obj_player;
boundless = false;

target_x = xstart;
target_y = ystart;

v_iew_w = camera_get_view_width(main_camera);
v_iew_h = camera_get_view_height(main_camera);
*/


// Camera 2 _in_it

main_camera = view_camera[0];
following = obj_player;

view_width_half = camera_get_view_width(main_camera)*.5;
view_height_half = camera_get_view_height(main_camera)*.5;
camera_set_view_size(main_camera,640,360);

x_to = xstart; 
y_to = ystart;

// _in_it_ial_ize camera shake var_iables
shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;