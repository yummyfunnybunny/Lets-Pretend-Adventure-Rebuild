function enemy_check_collision_map() {
	//show_debug_message("running enemy check collision map");
	
	var _xx = lengthdir_x(move_speed, direction);
	var _yy = lengthdir_y(move_speed, direction);
	
	if (tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 1 ||
		tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 4 ||
		tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 3) {
		return true;
	}
}

/*
var _bbox_width_half = (bbox_right-bbox_left)/2;
	var _bbox_height_half = (bbox_bottom-bbox_top)/2;
	var _xx = _bbox_width_half*sign(x_speed);
	var _yy = _bbox_height_half*sign(y_speed);

// Walls - collide with walls from the collision_map
	if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_height_half) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_height_half) == 1) {
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_height_half) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_height_half) == 1) {
			x_speed = 0;
		} else {
			x_speed = sign(x_speed);
		}
	}
	*/