/// @desc

if (global.debugger == true) {
	// draw x/y marker
	draw_sprite(spr_marker,0,x,y);

	// draw last safe marker
	draw_sprite(spr_marker,0,last_safe_x,last_safe_y);
	
	// draw border box
	//draw_rectangle(bbox_left,bbox_top+z_bottom,bbox_right,bbox_bottom+z_bottom, true);
	draw_ellipse(bbox_left,bbox_top+z_bottom,bbox_right,bbox_bottom+z_bottom, true);
}

// Inherit the parent event
event_inherited();



