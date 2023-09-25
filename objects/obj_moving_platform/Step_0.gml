/// @desc ???

// _inher_it the parent event
event_inherited();

// update player pos_it_ion if on top of the platform
if (instance_exists(obj_player)){
	if (obj_player.on_top_of == id && obj_player.on_ground == true) {
		obj_player.x += lengthdir_x(spd, direction);
		obj_player.y += lengthdir_y(spd, direction);
	}
}
