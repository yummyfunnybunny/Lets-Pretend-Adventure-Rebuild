
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