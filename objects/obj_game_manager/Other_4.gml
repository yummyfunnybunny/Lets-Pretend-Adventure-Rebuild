/// @desc Collision Map

/// Set the collision map
global.collision_map = layer_tilemap_get_id(layer_get_id("CollisionMap"));


///  Resizes the grid for every room

//sets the grid size
global.path_grid_width = room_width div global.path_grid_cell_size;
global.path_grid_height = room_height div global.path_grid_cell_size;

// create the grid
global.path_grid = mp_grid_create(0,0,global.path_grid_width,global.path_grid_height,global.path_grid_cell_size,global.path_grid_cell_size);

// add coll_is_ion map to the path_grid


// add all sol_id Ent_it_ies to the map
for (var _i = 0; _i < instance_number(obj_parent_entity); _i++){
	var _entity = instance_find(obj_parent_entity,_i);
	
	if (_entity.entity_solid == true){
		mp_grid_add_instances(global.path_grid,_entity,1);
	}
}