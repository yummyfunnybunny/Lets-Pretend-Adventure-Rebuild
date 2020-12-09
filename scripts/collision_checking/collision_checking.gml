
// == X / Y Collision Check == 
function xy_collision_check(_xSpeed,_ySpeed){
	
	// check for solid object at destination coordinate
	if (place_meeting(x+_xSpeed,y+_ySpeed,obj_solid)){
		show_debug_message("step 1: if place meeting");
		// save the object in question
		var _instance = instance_place(x+_xSpeed,y+_ySpeed,obj_solid);
		
		// check if object is solid
		if (check_z_solid(_instance) == true){
			show_debug_message("step 2: if zSolid");	
			// check for z overlap with object in question
			if (check_z_overlap(_instance) == true){
				show_debug_message("step 3: if z overlap");
				// check for collision 1 pixel away
				if (place_meeting(x+sign(_xSpeed),y+sign(_ySpeed),obj_solid)){
					// there is a collision, return 0 so there is no movement
					show_debug_message("step 4: if sign(place meeting)");
					return 0;
				}else {
					// no collision, return the sign of either xSpeed or ySpeed
					 var _speed = return_speed(sign(_xSpeed),sign(_ySpeed));
					 return _speed;
				}
			}else{
				// no z overlap, set z limits, return speed
				set_z_limits(_xSpeed,_ySpeed);
				var _speed = return_speed(_xSpeed,_ySpeed);
			return _speed;
			}
		}else{
			// object is not solid, no collision, return speed
			var _speed = return_speed(_xSpeed,_ySpeed);
			return _speed;
		}
	}else{
		// no collision, return speed
		var _speed = return_speed(_xSpeed,_ySpeed);
		return _speed;
	}
}

// == Check For Z Overlap ==
function check_z_overlap(_instance) {
	var _zBottom = _instance.zBottom;
	var _zTop = _instance.zTop;
	if (_zBottom <= zBottom && _zBottom >= zTop ||
		_zTop >= zTop && _zTop <= zBottom){
		// there is z overlap
		//show_debug_message("there IS z overlap");
		return true;
	}else {
		// there is no z overlap
		//show_debug_message("there is NO z overlap");
		return false;
	}
}

// == Check For Z Solid ==
function check_z_solid(_instance){
	if (_instance.zSolid == true){
		return true;
	}else{
		return false;
	}
}

// == Update zFloor and zRoof ==
function set_z_limits(_xSpeed,_ySpeed){
		
	// get the id of all objects in the collision path and save them into a ds list
	var _collisionList = ds_list_create();
	instance_position_list(x+_xSpeed,y+_ySpeed,obj_solid,_collisionList,false);
		
	// make two new lists, the above-you list, and below-you list
	var zTopList = ds_list_create();
	var zBottomList = ds_list_create();
	
	// loop through the collision list and divide it into the top list and bottom list
	for (var i = 0; i < ds_list_size(_collisionList); i++){
		
		// save the id, zBottom, and zTop of object[i]
		var _object = ds_list_find_value(_collisionList,i);
		var _zBottom = _object.zBottom;
		var _zTop = _object.zTop;
			
		// place the object in the appropriate list
		if (_zBottom < zTop){
			ds_list_add(zTopList,_object.zBottom);
		}else if (_zTop > zBottom){
			ds_list_add(zBottomList,_object.zTop);
		}
	}
	// destroy the collision list since we are done with it
	ds_list_destroy(_collisionList);
	
	// sort the completed lists in descending order (the z-axis is backwards)
	ds_list_sort(zTopList,lb_sort_ascending);
	ds_list_sort(zBottomList,lb_sort_ascending);
	
	for (i = 0; i < ds_list_size(zTopList); i++){
		var top = ds_list_find_value(zTopList,i);
		show_debug_message("zTopList :" + string(top));
	}
	for (i = 0; i < ds_list_size(zBottomList); i++){
		var bottom = ds_list_find_value(zBottomList,i);
		show_debug_message("zBottomList :" + string(bottom));
	}
	
	// set the zFloor as needed
	if (ds_list_find_value(zBottomList,0) != undefined){
		//show_debug_message(ds_list_find_value(zBottomList,0));
		zFloor = ds_list_find_value(zBottomList,0);
		zFloor -= 1;
		ds_list_destroy(zBottomList);
	}else {
		// something will probably go here for water once we handle going below 0
		zFloor = -1;
	}
	
	// set the zRoof as needed
	if (ds_list_find_value(zTopList,0) != noone){
		zRoof = ds_list_find_value(zTopList,0);
		ds_list_destroy(zTopList);
	}else {
		// nothing above you, set zRoof to -roomHeight
		zRoof =-room_height;
	}
}

// == Return Correct Speed ==
function return_speed(_xSpeed,_ySpeed){
	if (_xSpeed == 0) {
		//show_debug_message("returning ySpeed: " + string(_ySpeed));
		return _ySpeed;
	}else{
		//show_debug_message("returning xSpeed: " + string(_xSpeed));
		return _xSpeed;
	}
}

//=================================
/*
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
*/