// == draw self ==
// Draw Shadow

function draw_shadow() {
	draw_sprite(spr_shadow,entity_shadow,x,y+z_floor);
	/*
	draw_sprite_stretched(
		spr_shadow, 
		entity_shadow, 
		x-((bbox_right-bbox_left)/2), 
		y-((bbox_bottom-bbox_top)/2)+z_floor, 
		(bbox_right-bbox_left), 
		(bbox_bottom-bbox_top)
	);
	*/
}

// make sure entity_shadow is turned on
if (entity_shadow != -1) {
	// make sure entity is off the ground OR has PermaShadow on
	if (z_bottom < z_floor || entity_permashadow){
		// make sure entity is not on a pitfall
		if (tilemap_get_at_pixel(global.collision_map,x,y) != 6) {
			// make sure entity is not wading in water
			if (tilemap_get_at_pixel(global.collision_map,x,y) != 2) {
				// Make sure entity is not in deep water
				if (tilemap_get_at_pixel(global.collision_map,x,y) != 3) {
					draw_shadow();
				} else if (z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
			} else if ( z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
		} else if ( z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
	}
}

//draw self with depth
draw_self_z();

