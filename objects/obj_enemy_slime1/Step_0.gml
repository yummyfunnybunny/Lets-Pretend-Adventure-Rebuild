
// Inherit the parent event
event_inherited();

if (state = enemy_state_idle) {
	if (x_speed != 0) x_speed = 0;
	if (y_speed != 0) y_speed = 0;
	if (move_speed != 0) move_speed = 0;
	if (alarm[1] == -1) {
		alarm[1] = FPS*(choose(1,2));
	}
	if (alarm[1] == 0) {
		alarm[1] = -1;
		state = enemy_state_wander;
	}
}

if (state = enemy_state_wander) {
	// set movement
	if (alarm[1] == -1) {
		direction = choose (0,90,180,270);
		move_speed = choose(walk_speed, run_speed);
		x_speed = lengthdir_x(move_speed, direction);
		y_speed = lengthdir_y(move_speed, direction);
		alarm[1] = FPS*(choose(1,2));
	}
	if (alarm[1] == 0) {
		x_speed = 0;
		y_speed = 0;
		state = enemy_state_idle;
	}
}

if (state = enemy_state_death) {
	
	if (alarm[0] == -1) {
		image_index = 0;
		alarm[0] = -2;
	}
	
	if (alarm[0] = -2) {
		if (ev_animation_end) {
			//show_message("animation end -destroy");
			//image_speed = 0;
			//instance_destroy();
		}
	}
}