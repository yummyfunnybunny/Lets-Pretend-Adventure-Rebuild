
// == Draw Self With Delpth == 
function draw_self_z(){
	// check if self exists (safety)
	if(instance_exists(id)){
		// add 	zFloor to y-coord before drawing self, than resetting it
		y+=zBottom;
		draw_self();
		y-=zBottom;
	}
}


function draw_shadow(_spriteIndex){
	draw_sprite_ext(spr_shadow,_spriteIndex,x,y+zFloor,1,1,0,c_white,1);
}