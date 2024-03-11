/// @desc ???

/*
if (global.game_paused == 1) {
	path_speed = 0;
} else {
	path_speed = move_speed;
}
*/


// _inher_it the parent event
event_inherited();

// update player position if on top of the platform
if (instance_exists(obj_player)){
	if (obj_player.on_top_of == id && obj_player.on_ground == true) {
		obj_player.x += lengthdir_x(move_speed, direction);
		obj_player.y += lengthdir_y(move_speed, direction);
	}
}
