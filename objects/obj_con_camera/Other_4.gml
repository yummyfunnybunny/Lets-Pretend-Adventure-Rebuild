/// @desc

#region END SCREEN TRANSITION

if (transitioning) {
	
	// set camera position to where player will appear
	x = transfer_x;
	y = transfer_y;
	
	// set player position
	if (!instance_exists(obj_player)) {
		instance_create_depth(transfer_x, transfer_y, INSTANCES_1_DEPTH, obj_player);
	} else {
		obj_player.x = transfer_x;
		obj_player.y = transfer_y;
	}
	
	// set variables for in-transition
	transition_percent = 0;
	transition_left = 0;
	transition_top = 0;
	transition_right = global.gui_width;
	transition_bottom = global.gui_height;

	// set in-direction based on previous out-direction
	switch (transition_type) {
		case "out-left":
			transition_type = "in-right";
		break;
		
		case "out-right":
			transition_type = "in-left";
		break;
		
		case "out-up":
			transition_type = "in-down";
		break;
		
		case "out-down":
			transition_type = "in-up";
		break;
		
		case "out-center":
			transition_type = "in-center";
		break;
	}
}

#endregion