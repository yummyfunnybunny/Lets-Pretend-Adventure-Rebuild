
var _grid = layer_grid;
var _element_ids = layer_get_all_elements(layer);
var _num = array_length(_element_ids );
ds_grid_resize(_grid,2,_num);

for (var _i = 0; _i < _num; _i++) {
	var _id = layer_instance_get_instance(_element_ids [_i]);
	if (_id == id) { continue; }
	_grid[# 0, _i] = _id;
	_grid[# 1, _i] = _id.y;
}

ds_grid_sort(_grid, 1, true);

var _yy = 0;
var _inst;
repeat(_num) {
	_inst = _grid[# 0, _yy];
	with(_inst) {
		event_perform(ev_draw,0);
	}
	_yy++;
}



////resize grid
//var _grid = depth_grid;

//var _num = instance_number(obj_parent_entity);
//ds_grid_resize(_grid,2,_num);

//// add instance info to grid
//var _yy = 0;
//with(obj_parent_entity) {
//	_grid[# 0, _yy] = id;
//	_grid[# 1, _yy] = y;
//	//_grid[# 2, _yy] = depth;
//	_yy++;
//}

//// sort grid in ascending order
//ds_grid_sort(_grid, 1, true);

//// draw all instances
//_yy = 0;
//var _inst;
//repeat(_num) {
//	_inst = _grid[# 0, _yy];
//	with(_inst) {
//		event_perform(ev_draw,0);
//	}
//	_yy++;
//}

// NEW SYSTEM

//var _current_layer = layer_get_name(layer);
//show_message(_current_layer);
