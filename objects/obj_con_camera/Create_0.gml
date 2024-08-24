// INITIALIZE VARIABLES

// main
#macro CAMERA_DEFAULT_WIDTH 384
#macro CAMERA_DEFAULT_HEIGHT 216
main_camera					= view_camera[0];
camera_set_view_size(main_camera,CAMERA_DEFAULT_WIDTH,CAMERA_DEFAULT_HEIGHT);
view_width					= camera_get_view_width(main_camera);
view_height					= camera_get_view_height(main_camera);
view_width_half				= view_width*.5;
view_height_half			= view_height*.5;
x_to						= xstart;
y_to						= ystart;
following					= noone;

	
// screen shake
shake_length				= 0;
shake_magnitude				= 0;
shake_remain				= 0;
	
// Transition
transitioning				= false;
transition_type				= noone;
transfer_room				= noone;
transfer_x					= 0;
transfer_y					= 0;
transition_curve			= animcurve_get_channel(ac_curve_room_transition,"curve1");
transition_percent			= 0;
transition_left				= 0;
transition_top				= 0;
transition_right			= global.gui_width;
transition_bottom			= global.gui_height;
transition_center_left		= 0;
transition_center_top		= 0;
transition_center_right		= global.gui_width;
transition_center_bottom	= global.gui_height;
draw_transition				= false;
draw_gui_x					= 0;
draw_gui_y					= 0;
transition_color			= c_black;

// Zooming
zoom						= 1;		// 1 = normal
zooming						= false;
zoom_percent				= 0;
zoom_type					= noone;
zoom_curve			= animcurve_get_channel(ac_curve_camera_zoom,"curve1");

	
// INITIALIZE METHODS
function camera_follow_target(_id) {
	if (instance_exists(_id)) {
		following = _id;
	}
}

function camera_fixed_position(_x, _y) {
	following = noone;
	x_to = _x;
	y_to = _y;
}

//function camera_zoom(_zoom) {
//	camera_set_size(CAMERA_DEFAULT_WIDTH * _zoom,CAMERA_DEFAULT_HEIGHT * _zoom);
//}

//function camera_set_size(_length, _height) {	
////set_camera_size: function(_length, _height) {
//	camera_set_view_size(main_camera,_length,_height);
//}

function camera_shake_screen(){	
//shake_screen: function() {
	x += random_range(-shake_remain, shake_remain);
	y += random_range(-shake_remain, shake_remain);
	shake_remain = max(0, shake_remain - ((1/shake_length) * shake_magnitude));	
}

function camera_to_gui() {	
//camera_to_gui: function() {
	// set player
	var _player;
	if (instance_exists(obj_player)) { _player = obj_player; }
	
	// get the top-left position of the camera
	var _cam_x = camera_get_view_x(view_camera[0]);
	var _cam_y = camera_get_view_y(view_camera[0]);
       
	var _offset_x = _player.x - _cam_x // x is the normal x position
	var _offset_y = _player.y - _cam_y // y is the normal y position

	// convert to gui
	var _offset_x_percent = _offset_x / camera_get_view_width(view_camera[0]);
	var _offset_y_percent = _offset_y / camera_get_view_height(view_camera[0]);

	var _gui_x = _offset_x_percent * display_get_gui_width();
	var _gui_y = _offset_y_percent * display_get_gui_height();
	
	return {
		_x: _gui_x,
		_y: _gui_y,
	}	
}

function camera_end_transition() {	
//end_transition: function() {
	transitioning = false;
	transition_type = noone;
	transfer_room = noone;
	transfer_x = 0;
	transfer_y = 0;
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
}


// RUN INIT FUNCTIONS



camera_follow_target(obj_player);
