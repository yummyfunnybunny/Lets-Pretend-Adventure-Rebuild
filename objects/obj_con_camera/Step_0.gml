
// update camera destination coordinates
if (instance_exists(following)) {
	//show_debug_message(following.x);
	x_to = following.x;
	y_to = following.y;
	//if (following.x != following.xprevious) { x_to = following.x; }
	//if (following.y != following.yprevious) { y_to = following.y; }
}

// update object position
x += (x_to - x) / 15;
y += (y_to - y) / 15;
//if (x_to != x) { x += (x_to - x) / 15; }
//if (y_to != y) { y += (y_to - y) / 15; }

//show_debug_message(x_to);

// clamp camera to room bounds
x = clamp(x, view_width_half, room_width-view_width_half);
y = clamp(y, view_height_half, room_height-view_height_half);


// Screen Shake
if (shake_remain != 0) {
	x += random_range(-shake_remain, shake_remain);
	y += random_range(-shake_remain, shake_remain);
	shake_remain = max(0, shake_remain - ((1/shake_length) * shake_magnitude));
}

// Finally, officially set camera position
camera_set_view_pos(main_camera,x-view_width_half, y-view_height_half);

#region UPDATE SCREEN TRANSITION

if (global.transitioning) {
	
	
	// increment the percentage of completion
	if (transition_percent < 1) {
		transition_percent += 1/60;	
	};

	// set the position on the curve
	var _position = animcurve_channel_evaluate(transition_curve, transition_percent);
	show_debug_message(draw_transition);

	// set transition drawing bounds based on the transition type
	switch(global.transition_type) {
		case "out-left":
			transition_left = global.gui_width - (_position * global.gui_width);
		break;
	
		case "out-right":
			transition_right = _position * global.gui_width;
		break;
	
		case "out-up":
			transition_top = global.gui_height - (_position * global.gui_height);
		break;
	
		case "out-down":
			transition_bottom = _position * global.gui_height;
		break;
		
		case "out-center":
		
			var _gui = camera_to_gui();
			transition_center_left = global.gui_width - (_position * (global.gui_width - _gui._x));
			transition_center_right = _position * (_gui._x);
			transition_center_top = global.gui_height - (_position * (global.gui_height - _gui._y));
			transition_center_bottom = _position * _gui._y;
			
		break;
	
		case "in-left":
			transition_left = _position * global.gui_width;
		break;
	
		case "in-right":
			transition_right = global.gui_width - (_position * global.gui_width);
		break;
	
		case "in-up":
			transition_top = _position * global.gui_height;
		break;
	
		case "in-down":
			transition_bottom = global.gui_height - (_position * global.gui_height);
		break;
		
		case "in-center":
			
			var _gui = camera_to_gui();
			transition_center_left = _gui._x + (_position * (global.gui_width - _gui._x));
			transition_center_right = _gui._x - (_position * _gui._x);
			transition_center_top = _gui._y + (_position * (global.gui_height - _gui._y));
			transition_center_bottom = _gui._y - (_position * _gui._y);	
		break;
	}
	
	// start drawing transition
	draw_transition = true;

	

	// perform transition end for out/in
	if (transition_percent == 1) {
	
		var _transition = string_split(global.transition_type, "-");
		// end out transition and transfer to new room
		if (_transition[0] == "out") {
			room_goto(global.transfer_room);
			
		// end in transition and reset
		} else if (_transition[0] == "in") {
			global.transitioning = false;
			global.transition_type = noone;
			global.transfer_room = noone;
			global.transfer_x = 86;
			global.transfer_y = 500;
			transition_percent = 0;
			transition_left = 0;
			transition_top = 0;
			transition_right = global.gui_width;
			transition_bottom = global.gui_height;
			draw_transition = false;
		}
	}
}

function camera_to_gui() {
	
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

#endregion