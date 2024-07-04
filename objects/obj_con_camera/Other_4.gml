/// @desc

#region END SCREEN TRANSITION

if (global.transitioning) {
	
	// set camera position to where player will appear
	x = global.transfer_x;
	y = global.transfer_y;
	
	// set player position
	if (!instance_exists(obj_player)) {
		instance_create_depth(global.transfer_x, global.transfer_y, INSTANCE_DEPTH, obj_player);
		//obj_player.x = global.transfer_x;
		//obj_player.y = global.transfer_y;
	}
	
	// set variables for in-transition
	transition_percent = 0;
	transition_left = 0;
	transition_top = 0;
	transition_right = global.gui_width;
	transition_bottom = global.gui_height;

	// set in-direction based on previous out-direction
	switch (global.transition_type) {
		case "out-left":
			global.transition_type = "in-right";
		break;
		
		case "out-right":
			global.transition_type = "in-left";
		break;
		
		case "out-up":
			global.transition_type = "in-down";
		break;
		
		case "out-down":
			global.transition_type = "in-up";
		break;
		
		case "out-center":
			global.transition_type = "in-center";
		break;
	}
}

#endregion