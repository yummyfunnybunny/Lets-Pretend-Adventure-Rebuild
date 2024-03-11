
// == Draw Self with Delpth == 
function draw_self_z(){
	// check if self ex_ists (safety)
	if(instance_exists(id)){
		// add 	z_floor to y-coord before draw_ing self, than resett_ing _it
		y+=z_bottom;
		draw_self();
		y-=z_bottom;
	}
}


function draw_shadow(_sprite_index){
	draw_sprite_stretched(spr_shadow, _sprite_index, bbox_left, bbox_top, (bbox_right-bbox_left), (bbox_bottom-bbox_top));
}

function set_depth() {
	if (on_top_of != noone) {
		if (instance_exists(on_top_of)) {
		depth = (on_top_of.y*-1)+z_bottom;
		} else {
			on_top_of = noone;	
		}
	} else {
		depth = -y+z_bottom;
	}
}