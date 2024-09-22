/// @desc

if (global.debugger == true) {
	// draw x/y marker
	//draw_sprite(spr_marker,0,x,y);

	// draw last safe marker
	//draw_sprite(spr_marker,0,last_safe_x,last_safe_y);
	
	// draw ground border box
	draw_ellipse_color(bbox_left,bbox_top-1,bbox_right,bbox_bottom-1, c_yellow,c_yellow, true);
	
	// draw border box
	draw_ellipse(bbox_left,bbox_top+z_bottom,bbox_right,bbox_bottom+z_bottom, true);
}

// Inherit the parent event
event_inherited();





