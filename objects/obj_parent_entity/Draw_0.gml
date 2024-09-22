// == draw self ==



// DRAW SHADOW
if (shadow_index != -1) {
	//if (on_ground && !shadow_always){ exit; }
	//if (terrain_state == TERRAIN_TYPE.PITFALL) { exit; }
	//if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { exit; }
	//if (terrain_state == TERRAIN_TYPE.DEEP_WATER) { exit; }
	
	//if (!on_ground && shadow_always) {
	if (terrain_state != TERRAIN_TYPE.PITFALL) {
	if (terrain_state != TERRAIN_TYPE.SHALLOW_WATER) {
	if (terrain_state != TERRAIN_TYPE.DEEP_WATER) {
		draw_sprite_ext(spr_shadow,shadow_index,x,y+z_floor,1,1,0,c_white,image_alpha);
	}}}
}

// DRAW SELF
y+=z_bottom;
draw_self();
y-=z_bottom;



