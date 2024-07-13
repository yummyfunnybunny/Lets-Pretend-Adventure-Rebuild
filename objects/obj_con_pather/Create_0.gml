/// @desc
show_debug_message(path);
show_debug_message(path_end_action);
// check for provided path from creator
if (path != noone) {
	
	path_start(path, move_speed,path_end_action, true);	
} else {
	// create and start path
	show_debug_message("creating new path");
	path = path_add();
	mp_grid_path(global.path_grid, path, x, y, target_x,target_y,true);
	path_start(path, move_speed,path_end_action, true);

}