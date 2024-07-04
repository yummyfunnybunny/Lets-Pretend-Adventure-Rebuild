/// @desc

#region DRAW SCREEN TRANSITION

if (draw_transition) {
	switch(transition_type){
		case "out-center":
		case "in-center":
			draw_rectangle_color(transition_center_left, transition_top, transition_right, transition_bottom, transition_color, transition_color, transition_color, transition_color, false);
			draw_rectangle_color(transition_left, transition_center_top, transition_right, transition_bottom, transition_color, transition_color, transition_color, transition_color, false);
			draw_rectangle_color(transition_left, transition_top, transition_center_right, transition_bottom, transition_color, transition_color, transition_color, transition_color, false);
			draw_rectangle_color(transition_left, transition_top, transition_right, transition_center_bottom, transition_color, transition_color, transition_color, transition_color, false);
		break;
		
		default:
			draw_rectangle_color(transition_left, transition_top, transition_right, transition_bottom, transition_color, transition_color, transition_color, transition_color, false);
		break;
	}
}



#endregion