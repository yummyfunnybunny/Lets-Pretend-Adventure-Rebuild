function enemy_check_collision_map() {
	
	var _xx = lengthdir_x(move_speed, direction);
	var _yy = lengthdir_y(move_speed, direction);
	
	if (tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 1 ||
		tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 4 ||
		tilemap_get_at_pixel(global.collision_map, x+_xx,y+_yy) == 3) {
		return true;
	}
}

function enemy_check_collision_map_xy(_xx,_yy) {
	if (tilemap_get_at_pixel(global.collision_map, _xx,_yy) == 0) {
		return true;
	}else return false;
}