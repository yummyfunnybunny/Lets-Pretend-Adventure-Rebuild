
// == Draw All Depth Objects ==
// Resize The Grid
var _depthGrid = depthGrid;
var _objNumber = instance_number(parent_Solid);
ds_grid_resize(_depthGrid,2,_objNumber);

// Add Instance Info To Grid
var yy = 0;
with(parent_Solid){
	_depthGrid[# 0,yy] = id;
	_depthGrid[# 1,yy] = y+zBottom;
	yy ++;
}

// Sort Grid In Ascending Order
ds_grid_sort(_depthGrid,1,true);

// Draw Depth Objects
yy = 0;
var _object;
repeat(_objNumber){
	// pull out an ID
	_object = _depthGrid[# 0,yy];
	// get _object to draw itself
	with(_object){
		event_perform(ev_draw,0);
	}
	yy++;
}