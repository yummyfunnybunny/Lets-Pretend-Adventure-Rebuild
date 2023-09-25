
// Camera 1 Update
/*
cx = camera_get_v_iew_x(main_camera);
cy = camera_get_v_iew_y(main_camera);


if (mouse_check_button(mb_left)) {
	target_x = mouse_x;
	target_y = mouse_y;
}

switch(mode) {
	case camera_mode.follow_object:
		if (!instance_exists(following)) break;
		cx = following.x - (v_iew_w/2);
		cy = following.y - (v_iew_h/2);
		//x += (following.x - x) / 15; // move towards the dest_inat_ion by 15% each step
		//y += (following.y - y) / 15;
	break;
	case camera_mode.follow_mouse_drag:
	
		// get the mouse x as d_isplayed on your screen, NOT the game room
		var mx = d_isplay_mouse_get_x();
		var my = d_isplay_mouse_get_y();
	
		if (mouse_check_button(mb_left)) {
			var _scale_factor = .5; // change th_is to account for tw_itch_iness if rooms/d_isplays are scaled
			cx += (mouse_x_prev-mx)*_scale_factor;
			cy += (mouse_y_prev-my)*_scale_factor;
		}
		
		mouse_x_prev = mx;
		mouse_y_prev = my;
		
	break;
	case camera_mode.follow_mouse_border:
		var _scroll_speed = 0.05; // between 0-1, smaller = slower, larger = faster
		if (!po_int__in_rectangle(mouse_x,mouse_y, 
							cx+(v_iew_w*0.1), // change 0.1/0.9 to change s_ize of rectangle
							cy+(v_iew_h*0.1), 
							cx+(v_iew_w*0.9), 
							cy+(v_iew_h*0.9))) {
			cx = lerp(cx, mouse_x-v_iew_w/2, _scroll_speed);
			cy = lerp(cy, mouse_y-v_iew_h/2, _scroll_speed);	
		}
	break;
	case camera_mode.follow_mouse_peek:
		if (!instance_exists(following)) break;
		var _lerp_value = 0.1; // lower number g_ives preference to the f_irst th_ing (the player)
		cx = lerp(following.x, mouse_x, _lerp_value)-(v_iew_w/2);
		cy = lerp(following.y, mouse_y, _lerp_value)-(v_iew_h/2);
	break;
	
	case camera_mode.move_to_target:
		var _lerp_value = 0.1; // larger numbers move faster
		cx = lerp(cx, target_x - (v_iew_w/2), _lerp_value);
		cy = lerp(cy, target_y - (v_iew_h/2), _lerp_value);
	break;
	
	case camera_mode.move_to_follow_object:
		if (!instance_exists(following)) break;
		var _lerp_value = 0.1; // larger numbers move faster
		cx = lerp(cx, following.x - (v_iew_w/2), _lerp_value);
		cy = lerp(cy, following.y - (v_iew_h/2), _lerp_value);
		
		if (point_distance(cx, cy, following.x - (v_iew_w/2), following.y - (v_iew_h/2)) < 1) {
			mode = camera_mode.follow_object;
		}
	break;
}

// clamp camera to room bounds
if (!boundless) {
	cx = clamp(cx, 0, room_width-v_iew_w);
	cy = clamp(cy, 0, room_height-v_iew_h);
}

camera_set_view_pos(main_camera, cx, cy);
*/

// -- Camera 2 Update --

// update camera dest_inat_ion coord_inates
if (instance_exists(following)) {
	x_to = following.x;
	y_to = following.y;
}

// update object pos_it_ion
x += (x_to - x) / 15; // move towards the dest_inat_ion by 15% each step
y += (y_to - y) / 15;

// clamp camera to room bounds
x = clamp(x, view_width_half, room_width-view_width_half);
y = clamp(y, view_height_half, room_height-view_height_half);


// Screen Shake
x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);
shake_remain = max(0, shake_remain - ((1/shake_length) * shake_magnitude));

// F_inally, off_ic_ially set camera pos_it_ion
camera_set_view_pos(main_camera,x-view_width_half, y-view_height_half);