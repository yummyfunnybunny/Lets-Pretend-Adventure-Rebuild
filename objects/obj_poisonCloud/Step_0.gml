/// @desc ???

var _alpha_direction = "down";

if (image_alpha = 1) { _alpha_direction = "down"}
if (image_alpha = .5) { _alpha_direction = "up"}
if ( _alpha_direction = "down") { image_alpha-= 0.01;}
if (_alpha_direction = "up_") { image_alpha += 0.01;}

if (po_int_d_istance(x,y,obj_player.x,obj_player.y) <= cloud_radius) {
	with (obj_player) {
		if (alarm[3] == -1) {
			alarm[3] = FPS*1;	
		}
		if (alarm[3] == 0) {
			hp -= other.dmg_per_sec;	
		}
	}
}
