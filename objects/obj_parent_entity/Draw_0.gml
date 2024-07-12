// == draw self ==



// DRAW SHADOW
if (shadow_index != -1) {
	if (on_ground && !shadow_always){ exit; }
	if (terrain_state != TERRAIN.PITFALL && terrain_state != TERRAIN.SHALLOW_WATER && terrain_state != TERRAIN.DEEP_WATER) {
		draw_sprite_ext(spr_shadow,shadow_index,x,y+z_floor,1,1,0,c_white,image_alpha);
	}
	//if (tilemap_get_at_pixel(global.collision_map,x,y) = 6) { exit; }
	//if (tilemap_get_at_pixel(global.collision_map,x,y) = 2) { exit; }
	//if (tilemap_get_at_pixel(global.collision_map,x,y) = 3) { exit; }
	
}

// DRAW SELF
y+=z_bottom;
draw_self();
y-=z_bottom;



