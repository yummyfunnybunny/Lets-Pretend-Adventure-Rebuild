
global.enemy_count = instance_number(obj_parent_enemy);
global.ui_type = UI_TYPE.LEVEL;

#region collision map
global.collision_map = layer_tilemap_get_id(layer_get_id("CollisionMap"));


///  Resizes the grid for every room

//sets the grid size
global.path_grid_width = room_width div PATH_GRID_CELL_SIZE;
global.path_grid_height = room_height div PATH_GRID_CELL_SIZE;

// create the pathing grid
global.path_grid = mp_grid_create(0,0,global.path_grid_width,global.path_grid_height,PATH_GRID_CELL_SIZE,PATH_GRID_CELL_SIZE);

// add collision map to the path_grid
var _w = tilemap_get_width(global.collision_map);
var _h = tilemap_get_height(global.collision_map);
var _collision_map_grid = ds_grid_create(_w,_h);

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

#endregion

level_set_overlay();