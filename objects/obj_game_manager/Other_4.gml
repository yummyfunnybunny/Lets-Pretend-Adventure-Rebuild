/// @desc Collision Map

/// Set the collision map
global.collision_map = layer_tilemap_get_id(layer_get_id("CollisionMap"));


///  Resizes the grid for every room

//sets the grid size
global.path_grid_width = room_width div global.path_grid_cell_size;
global.path_grid_height = room_height div global.path_grid_cell_size;

// create the pathing grid
global.path_grid = mp_grid_create(0,0,global.path_grid_width,global.path_grid_height,global.path_grid_cell_size,global.path_grid_cell_size);

// add collision map to the path_grid
var _w = tilemap_get_width(global.collision_map)-1;
var _h = tilemap_get_height(global.collision_map);
var _collision_map_grid = ds_grid_create(_w,_h);

for (var _i = 1; _i < _w; _i++) {
	for (var _j = 1; _j < _h; _j++) {
		ds_grid_set(_collision_map_grid, _i,_j,tilemap_get_at_pixel(global.collision_map,_i*8,_j*8));
		
		//show_debug_message(ds_grid_get(_collision_map_grid,_i,_j));
	}
}

//show_message(ds_grid_get(_collision_map_grid,1,1));
//show_message(ds_grid_get(_collision_map_grid,21,14));
//show_message(tilemap_get_cell_x_at_pixel(global.collision_map,1,1));
//show_message(tilemap_get_cell_x_at_pixel(global.collision_map,21,14));

// add walls to the path grid
for (var _i = 0; _i < global.path_grid_width; _i++) {
	for (var _j = 0; _j < global.path_grid_height; _j++;) {
		ds_grid_to_mp_grid(_collision_map_grid, global.path_grid);	
	}
}

// add buffer room around all obstacles
for (var _i = 0; _i < global.path_grid_width; _i++) {
	for (var _j = 0; _j < global.path_grid_height; _j++;) {
		
		/*
		if (mp_grid_get_cell(global.path_grid,_i,_j) != 0){
			mp_grid_add_cell(global.path_grid, _i-1, _j);
			mp_grid_add_cell(global.path_grid, _i+1, _j);
			mp_grid_add_cell(global.path_grid, _i, _j-1);
			mp_grid_add_cell(global.path_grid, _i, _j+1);
			
		}
		*/
		//show_debug_message(mp_grid_get_cell(global.path_grid, _i, _j));
		//ds_grid_to_mp_grid(_collision_map_grid, global.path_grid);	
	}
}

//show_message(mp_grid_get_cell(global.path_grid, 1,1));
//show_message(mp_grid_get_cell(global.path_grid, 21,14));
// add deep water to the path grid

// add ladders to the path grid

// add cliffs to the path grid

// add pitfalls to the path grid

// add pitfall edges to the path grid




// add all solid Entities to collision_map
for (var _i = 0; _i < instance_number(obj_parent_entity); _i++){
	var _entity = instance_find(obj_parent_entity,_i);
	
	if (_entity.entity_solid == true){
		mp_grid_add_instances(global.path_grid,_entity,1);
	}
}