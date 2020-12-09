
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
function check_z_collision(_xSpeed,_ySpeed){
	
	// create list of all objects in collision on the x/y-axis
	var _collisionList = ds_list_create();
	instance_position_list(x+_xSpeed, y+_ySpeed,obj_solid,_collisionList,false);
	
	// break the list into two lists, the above-you list, and below-you list
	var zTopList = ds_list_create();
	var zBottomList = ds_list_create();
	
	// loop through the list to find an object that opverlaps you on the z-axis
	for (var i = 0; i < ds_list_size(_collisionList); i++){
		
		// save the id of each object
		var _object = ds_list_find_value(_collisionList,i);
		
		
		// check if object is solid
		if (_object.zSolid == true){
			
			// save the object's zBottom and zTop
			var _zBottom = _object.zBottom;
			var _zTop = _object.zTop;
			
			// check for z overlap
			if (_zBottom <= zBottom && _zBottom >= zTop ||
				_zTop >= zTop && _zTop <= zBottom){
				// there is a collision
				return true;
			// place the object in either the zTopList or the zBottomList
			}else if (_zBottom < zTop){
				ds_list_add(zTopList,_object.zBottom);
			}else if (_zTop > zBottom){
				ds_list_add(zBottomList,_object.zTop);
			}
		}
		// no collision with solid objects
	}
	// finished looping through all objects
	// destroy the collision list, we are done with it
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



// check for z overlap
function check_z_overlap(_instance) {
	var _zBottom = _instance.zBottom;
	var _zTop = _instance.zTop;
	if (_zBottom <= zBottom && _zBottom >= zTop ||
		_zTop >= zTop && _zTop <= zBottom){
		// there is z overlap
		return true;
	}else {
		// there is no z overlap
		return false;
	}
}

// check for z solid
function check_z_solid(_instance){
	if (_instance.zSolid == true){
		return true;
	}else{
		return false;
	}
}




// == X/Y COLLISION CHECK == 
function xy_collision_check(_xSpeed,_ySpeed){
	
	// check for solid object at destination coordinate
	if (place_meeting(x+_xSpeed,y+_ySpeed,obj_solid)){
		
		// save the object in question
		var _instance = instance_place(x+_xSpeed,y+_ySpeed,obj_solid);
		
		// check if object is solid
		if (check_z_solid(_instance) == true){
			
			// check for z overlap with object in question
			if (check_z_overlap(_instance) == true){
				
				// check for collision 1 pixel away
				if (place_meeting(x+sign(_xSpeed),y+sign(_ySpeed),obj_solid)){
					// there is a collision, return 0 so there is no movement
					return 0;
				}else {
					// no collision, return the sign of either xSpeed or ySpeed
					return_speed(sign(_xSpeed),sign(_ySpeed));
				}
			}else{
				// no z overlap, set z limits
				set_z_limits();
			}
		}else{
			// object is not solid, no collision, return either xSpeed or ySpeed
			return_speed(_xSpeed,_ySpeed);
		}
	}else{
		// no collision, return either xSpeed or ySpeed
		return_speed(_xSpeed,_ySpeed);
	}
}

// return correct speed
function return_speed(_xSpeed,_ySpeed){
	if (_xSpeed == 0) {
		return _ySpeed;
	}else{
		return _xSpeed;
	}
}



