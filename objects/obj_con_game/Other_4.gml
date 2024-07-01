/// @desc Collision Map


/// Set the collision map
global.collision_map = layer_tilemap_get_id(layer_get_id("CollisionMap"));
show_debug_message(global.collision_map);


///  Resizes the grid for every room

//sets the grid size
show_debug_message("room_height: " + string(room_height));
show_debug_message("cell size: " +string(global.path_grid_cell_size));
global.path_grid_width = room_width div global.path_grid_cell_size;
global.path_grid_height = room_height div global.path_grid_cell_size;

// create the pathing grid
global.path_grid = mp_grid_create(0,0,global.path_grid_width,global.path_grid_height,global.path_grid_cell_size,global.path_grid_cell_size);

// add collision map to the path_grid
var _w = tilemap_get_width(global.collision_map);
var _h = tilemap_get_height(global.collision_map);
var _collision_map_grid = ds_grid_create(_w,_h);
show_debug_message(global.path_grid_height);
show_debug_message(global.path_grid_width);
show_debug_message(_w);
show_debug_message(_h);

for (var _i = 1; _i < _w; _i++) {
	for (var _j = 1; _j < _h; _j++) {
		ds_grid_set(_collision_map_grid, _i,_j,tilemap_get_at_pixel(global.collision_map,_i*8,_j*8));
	}
}

// add walls to the path grid
for (var _i = 0; _i < global.path_grid_width; _i++) {
	for (var _j = 0; _j < global.path_grid_height; _j++;) {
		ds_grid_to_mp_grid(_collision_map_grid, global.path_grid);	
	}
}

// add all solid Entities to collision_map
for (var _i = 0; _i < instance_number(obj_parent_entity); _i++){
	var _entity = instance_find(obj_parent_entity,_i);
	
	if (_entity.entity_solid == true){
		mp_grid_add_instances(global.path_grid,_entity,1);
	}
}

// create player at the start
if (!instance_exists(obj_player)) {
	instance_create_depth(global.transfer_x, global.transfer_y, global.instance_depth, obj_player);
}

// create the camera event
if (!instance_exists(obj_con_camera)) {
	//global.camera = view_camera[0];
	//global.camera_width_half = camera_get_view_width(global.camera)*.5;
	//global.camera_height_half = camera_get_view_height(global.camera)*.5;
	//show_debug_message("setting camera x,y to create it right over player");
	//show_debug_message(global.camera_width_half);
	//show_debug_message(global.camera_height_half);
	//show_message("creating camera");
	//var _camera_x = obj_player.x;
	//var _camera_y = obj_player.y;
	// clamp camera to room bounds
	
	//var _camera_x = clamp(obj_player.x - global.camera_width_half, global.camera_width_half, room_width-global.camera_width_half);
	//var _camera_y = clamp(obj_player.y - global.camera_height_half, global.camera_height_half, room_height-global.camera_height_half);
	//show_debug_message(_camera_x);
	//show_debug_message(_camera_y);
	global.camera = instance_create_depth(obj_player.x,obj_player.y,global.instance_depth,obj_con_camera);	
}

#region FINALIZE ROOM TRANSITIONS

if (global.transitioning) {
	
	// set variables for in-transition
	transition_percent = 0;
	transition_left = 0;
	transition_top = 0;
	transition_right = global.gui_width;
	transition_bottom = global.gui_height;

	// set in-direction based on previous out-direction
	switch (global.transition_type) {
		case "out-left":
			global.transition_type = "in-right";
		break;
		
		case "out-right":
			global.transition_type = "in-left";
		break;
		
		case "out-up":
			global.transition_type = "in-down";
		break;
		
		case "out-down":
			global.transition_type = "in-up";
		break;
	}
}

#endregion