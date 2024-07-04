/// @desc

#region DRAW SCREEN TRANSITION

if (draw_transition) {
	show_debug_message("draw transition = true");
	switch(global.transition_type){
		
		case "out-center":
			show_debug_message("global.transition_type = true");
			draw_rectangle_color(transition_center_left, transition_top, transition_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_center_top, transition_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_top, transition_center_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_top, transition_right, transition_center_bottom, c_black, c_black, c_black, c_black, false);
		break;
		
		case "in-center":
			draw_rectangle_color(transition_center_left, transition_top, transition_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_center_top, transition_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_top, transition_center_right, transition_bottom, c_black, c_black, c_black, c_black, false);
			draw_rectangle_color(transition_left, transition_top, transition_right, transition_center_bottom, c_black, c_black, c_black, c_black, false);
		break;
		
		default:
			draw_rectangle_color(transition_left, transition_top, transition_right, transition_bottom, c_black, c_black, c_black, c_black, false);
		break;
		
	}
}

#endregion