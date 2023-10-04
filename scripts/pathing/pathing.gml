
function pather_create() {
	
	// clear the grid cell below entity in case its occupied with a temporary path grid
	var _temporary_path_grid = global.path_grid;
	var _grid_x = x div 8;
	var _grid_y = y div 8;
	mp_grid_clear_cell(_temporary_path_grid,_grid_x,_grid_y);
	
	// set move to desired speed for returning to origin
	move_speed = run_speed;

	// Create Pather Object
	if (pather_object == noone){
		var _path = path_add();
		mp_grid_path(_temporary_path_grid,_path, x,y,origin_x,origin_y,true);
		
		pather_object = instance_create_layer(x,y,"Instances",obj_con_pather);
		with (pather_object) {
			creator			= other.id;
			move_speed		= other.move_speed;
			path			= _path;
			target_x		= other.origin_x;
			target_y		= other.origin_y;
			path_end_action = path_action_stop;
			path_start(path,move_speed,path_end_action,false);
		}
	}
}