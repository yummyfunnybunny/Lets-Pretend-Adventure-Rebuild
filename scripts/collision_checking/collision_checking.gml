
// == Update zFloor and zRoof ==
function set_z_limits(){
	// if there is a collision on the x/y axis
	if (place_meeting(x,y, obj_solid)){
		
		// create a list of all objects currently in collision with you
		var _collisionList = ds_list_create();
		instance_position_list(x,y,obj_solid,_collisionList,false);
		
		// break the list into two lists, the above-you list, and below-you list
		var zTopList = ds_list_create();
		var zBottomList = ds_list_create();
		for (var i = 0; i < ds_list_size(_collisionList); i++){
			var _object = ds_list_find_value(_collisionList,i);
			var _zBottom = _object.zBottom;
			var _zTop = _object.zTop;
			if (_zBottom < zTop){
				ds_list_add(zTopList,_object.zBottom);
			}else if (_zTop > zBottom){
				ds_list_add(zBottomList,_object.zTop);
			}
		}
		ds_list_destroy(_collisionList);
		// sort the completed lists in descending order (the z-axis is backwards)
		ds_list_sort(zTopList,lb_sort_descending);
		ds_list_sort(zBottomList,lb_sort_descending);
		// set the zFloor as needed
		if (ds_list_find_value(zBottomList,0) != noone){
			zFloor = ds_list_find_value(zBottomList,0);
			ds_list_destroy(zBottomList);
		}else {
			// something will probably go here for water once we handle going below 0
			zFloor = 0;
		}
		// set the zRoof as needed
		if (ds_list_find_value(zTopList,0) != noone){
			zRoof = ds_list_find_value(zTopList,0);
			ds_list_destroy(zTopList);
		}else {
			zRoof =-room_height;
		}
	}
}

// check for z collision

function check_z_collision(){
	// create list of all objects in collision on the x/y-axis
	var _collisionList = ds_list_create();
	instance_position_list(x+xSpeed, y+ySpeed,obj_solid,_collisionList,false);
	// loop through the list to find an object that opverlaps you on the z-axis
	for (var i = 0; i < ds_list_size(_collisionList); i++){
		var _object = ds_list_find_value(_collisionList,i);
		if (_object.zSolid == true){
			// check for z collision
			if (_object.zBottom <= zBottom && _object.zBottom >= zTop ||
				_object.zTop >= zTop && _object.zTop <= zBottom){
				// there is a collision
				return true;
			}else {
				// there is no collision
				//return false;
			}
		}
	}
	// there is no collision
	return false;
}



// == X/Y COLLISION CHECK == 
function xy_collision_check(_xSpeed,_ySpeed){
	// check for solid object at destination coordinate
	if (place_meeting(x+_xSpeed,y+_ySpeed,obj_solid)){
		if (check_z_collision() == true){
			// check for collision 1 pixel away
			if (place_meeting(x+sign(_xSpeed),y+sign(_ySpeed),obj_solid)){
				// there is a collision, return 0 so there is no movement
				return 0;
			}else {
				// no collision, return the sign of either xSpeed or ySpeed
				if (_xSpeed == 0){
					return sign(_ySpeed);
				}else{
					return sign(_xSpeed);
				}
			}
		}else {
			// no collision, return either xSpeed or ySpeed
			if (_xSpeed == 0) {
				return _ySpeed;
			}else{
				return _xSpeed;
			}
		}
	}else{
		// no collision, return either xSpeed or ySpeed
		if (_xSpeed == 0) {
			return _ySpeed;
		}else{
			return _xSpeed;
		}
	}
}



