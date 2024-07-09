// == draw self ==

// DRAW SELF
y+=z_bottom;
draw_self();
y-=z_bottom;

// DRAW SHADOW
if (shadow_index != -1) {
	if (on_ground && !shadow_always){ exit; }
	if (tilemap_get_at_pixel(global.collision_map,x,y) = 6) { exit; }
	if (tilemap_get_at_pixel(global.collision_map,x,y) = 2) { exit; }
	if (tilemap_get_at_pixel(global.collision_map,x,y) = 3) { exit; }
	draw_sprite_ext(spr_shadow,shadow_index,x,y+z_floor,1,1,0,c_white,image_alpha);
}

