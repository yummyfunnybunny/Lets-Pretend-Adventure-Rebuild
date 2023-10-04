/// @desc update pathing

if (instance_exists(creator)){ 
	// Check distance to creator and start/pause the path
	var _dis = point_distance(x,y,creator.x,creator.y);
	if (_dis > path_pause_range){
		// pause the path
		if (path_speed != 0){ path_speed = 0; }
	}else{
		// start the path
		if (path_speed = 0){ path_speed = move_speed; }
	}

// Destroy Pather if creator does not exist
}else{
	instance_destroy();
}