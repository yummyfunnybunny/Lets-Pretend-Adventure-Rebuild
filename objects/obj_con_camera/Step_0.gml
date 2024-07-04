
// update camera destination
if (instance_exists(following)) {
	x_to = following.x;
	y_to = following.y;
}

// update object position
x += (x_to - x) / 15;
y += (y_to - y) / 15;

// clamp camera to room bounds
x = clamp(x, view_width_half, room_width-view_width_half);
y = clamp(y, view_height_half, room_height-view_height_half);

// Screen Shake
if (shake_remain != 0) {
	camera_shake_screen();
}

// set camera x,y position
camera_set_view_pos(main_camera,x-view_width_half, y-view_height_half);


#region UPDATE ZOOMING

if (zooming) {
	// increment the percentage of completion
	if (zoom_percent < 1) {
		zoom_percent += 1/120;
		
		
		// set the position on the curve
		var _position = animcurve_channel_evaluate(zoom_curve, zoom_percent);
		
	
		var _new_width = CAMERA_DEFAULT_WIDTH * zoom;
		var _new_height = CAMERA_DEFAULT_HEIGHT * zoom;
	
		var _current_width;
		var _current_height;
	
		switch (zoom_type) {
			case "out":
				_current_width = view_width + _position * (_new_width - view_width);
				_current_height = view_height + _position * (_new_height - view_height);
			break;
		
			case "in":
				_current_width = view_width -  _position * (view_width - CAMERA_DEFAULT_WIDTH);
				_current_height = view_height - _position * (view_height - CAMERA_DEFAULT_HEIGHT);
			break;
		}
		
		
		view_width_half	= _current_width*.5;
		view_height_half = _current_height*.5;
		camera_set_view_size(main_camera, _current_width, _current_height);
	};
	
	if (zoom_percent == 1) {
		zooming				= false;
		zoom_percent		= 0;
		zoom_type			= noone;
		zooming				= false;
		view_width			= camera_get_view_width(main_camera);
		view_height			= camera_get_view_height(main_camera);
		view_width_half		= camera_get_view_width(main_camera)*.5;
		view_height_half	= camera_get_view_height(main_camera)*.5;
	}
}

#endregion


#region UPDATE SCREEN TRANSITION





if (transitioning) {
	
	// increment the percentage of completion
	if (transition_percent < 1) {
		transition_percent += 1/60;	
	};

	// set the position on the curve
	var _position = animcurve_channel_evaluate(transition_curve, transition_percent);

	// set transition drawing bounds based on the transition type
	switch(transition_type) {
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
	
		var _transition = string_split(transition_type, "-");
		// end out transition and transfer to new room
		if (_transition[0] == "out") {
			room_goto(transfer_room);
			
		// end in transition and reset
		} else if (_transition[0] == "in") {
			camera_end_transition();
			
		}
	}
}

#endregion