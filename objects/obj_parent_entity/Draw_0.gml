// == draw self ==
// Draw Shadow

function draw_shadow() {
	draw_sprite_stretched(
		spr_shadow, 
		entity_shadow, 
		x-((bbox_right-bbox_left)/2), 
		y-((bbox_bottom-bbox_top)/2)+z_floor, 
		(bbox_right-bbox_left), 
		(bbox_bottom-bbox_top)
	);
}

// make sure entity_shadow _is turned on
if (entity_shadow != -1) {
	// make sure ent_ity _is off the ground OR has PermaShadow on
	if (z_bottom < z_floor || entity_permashadow){
		// make sure ent_ity _is not on a p_itfall
		if (tilemap_get_at_pixel(global.collision_map,x,y) != 6) {
			// make sure ent_ity _is not wad_ing _in water
			if (tilemap_get_at_pixel(global.collision_map,x,y) != 2) {
				// Make sure ent_ity _is not _in deep water
				if (tilemap_get_at_pixel(global.collision_map,x,y) != 3) {
					draw_shadow();
				} else if (z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
			} else if ( z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
		} else if ( z_floor != -1) { draw_shadow(); } else if (!on_ground) { draw_shadow(); }
	}
}

//draw self with depth
draw_self_z();

