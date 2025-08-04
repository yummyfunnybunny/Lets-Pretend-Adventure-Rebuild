
function entity_collision(){
	if (x_speed == 0 && y_speed == 0) { exit; }
	
	// set z limites - current z limits needed for z_overlap checks done below
	set_z_limits(id);
	
	// === HORIZONTAL AXIS ===
	if (x_speed != 0) {
		// regular Walls
		x_speed = wall_x_axis_check(id, 1, x_speed);
	
		// Level 1 Walls
		if (layer == layer_get_id(INSTANCES_1_LAYER)) {
			x_speed = wall_x_axis_check(id, 8, x_speed);
		}
	
		// Level 2 Walls
		if (layer == layer_get_id(INSTANCES_2_LAYER)) {
			x_speed = wall_x_axis_check(id, 7, x_speed);
		}
	
		// Entities
		x_speed = entity_x_axis_check(id, x_speed);
		
		// interacting checks
		print("my interact target:", interact_target);
		if (interact_target != noone && instance_exists(interact_target)) {
			if (!object_is_ancestor(id.object_index, obj_parent_player)) { exit; }
			print(id);
			// player must be interacting in such a way that the other entity can interfer with movement
			
			//if (nest_state == nest_state_push || nest_state == nest_state_carry) {
			//	x_speed = interacting_x_collision_check(interact_target);
			//}
		}

		// Horizontal Move Commit
		x += x_speed;
	}
	
	// === VERTICAL AXIS ===
	if (y_speed != 0) {
		// regular Walls
		y_speed = wall_y_axis_check(id, 1, y_speed);
	
		// Level 1 walls
		if (layer == layer_get_id(INSTANCES_1_LAYER)) {
			y_speed = wall_y_axis_check(id, 8, y_speed);
		}
	
		// Level 2 walls
		if (layer == layer_get_id(INSTANCES_2_LAYER)) {
			y_speed = wall_y_axis_check(id, 7, y_speed);
		}
	
		// cant get on ladder until you are on the ground
		y_speed = ladder_check(id);
	
		// Entities
		y_speed = entity_y_axis_check(id, y_speed);
		
		// interacting checks
		if (interact_target != noone && instance_exists(interact_target)) {
			// player must be interacting in such a way that the other entity can interfer with movement
			if (nest_state == nest_state_push || nest_state == nest_state_carry) {
				y_speed = interacting_y_collision_check(interact_target);
			}
		}
	
		// Vertical Move Commit
		y += y_speed;
	}
	
	// pushout check
	pushout_check(id);
}

function interacting_x_collision_check(_e) {
	// _e = entity we're working with
	
	var _xspeed = x_speed;
	
	// regular Walls
	_xspeed = wall_x_axis_check(_e, 1, _xspeed);
	
	// Level 1 Walls
	if (layer == layer_get_id(INSTANCES_1_LAYER)) {
		_xspeed = wall_x_axis_check(_e, 8, _xspeed);
	}
	
	// Level 2 Walls
	if (layer == layer_get_id(INSTANCES_2_LAYER)) {
		_xspeed = wall_x_axis_check(_e, 7, _xspeed);
	}
	
	// Entities
	_xspeed = entity_x_axis_check(_e, _xspeed);
	
	return _xspeed;
	
}

function interacting_y_collision_check(_e) {
	// _e = entity we're working with
	
	var _yspeed = y_speed;
	
	// regular Walls
	_yspeed = wall_y_axis_check(_e, 1, _yspeed);
	
	// Level 1 walls
	if (layer == layer_get_id(INSTANCES_1_LAYER)) {
		_yspeed = wall_y_axis_check(_e, 8, _yspeed);
	}
	
	// Level 2 walls
	if (layer == layer_get_id(INSTANCES_2_LAYER)) {
		_yspeed = wall_y_axis_check(_e, 7, _yspeed);
	}
	
	// Entities
	_yspeed = entity_y_axis_check(_e, _yspeed);
	
	return _yspeed;
}

function set_z_limits(_e) {
	// check if there is a collision
	if (place_meeting(_e.x, _e.y, obj_parent_entity)){
		// save the _iD of the coll_id_ing _instance
		var _e_collided = instance_place(_e.x, _e.y, obj_parent_entity);
		
		// check if _instance _is above you
		if (_e_collided.entity_solid && _e_collided.z_bottom < _e.z_top){
			if (bounding_box_overlap_check("xy", _e, _e_collided) == true) {
				// set z_roof to bottom of coll_id_ing _instance above you
				_e.z_roof = _e_collided.z_bottom + 1;
				_e.below_of = _e_collided;
			}else {
				// set z_roof to ceiling
				_e.z_roof = -room_height;
				_e.below_of = noone;
			}
		
		// check if instance is below you
		}
		
		if (_e_collided.entity_solid && _e_collided.z_top > _e.z_bottom) {
			if (bounding_box_overlap_check("xy", _e, _e_collided) == true) {
				_e.z_floor = _e_collided.z_top - 1;
				_e.on_top_of = _e_collided;
			}else {
				// water collision stuff will probably go here... for now
				_e.z_floor = -1;
				_e.on_top_of = noone;
			}
		}
	}else{
		_e.z_roof = -room_height;
		_e.z_floor = -1;
		_e.on_top_of = noone;
		_e.below_of = noone;
	}	
}

function wall_x_axis_check(_e, _terrain, _xspeed){
	// LEGEND
	// _e = the entity to perform the check on
	// _terrain = the terrain # to check for a collision with
	// _ex = x coord of entity we
	// _ey = y coord of entity 
	// _exspd = x_speed of entity 
	// _bb_hh = vertical bbox half of entity
	// _xx = velocity vertical bbox
	
	var _ex = _e.x;
	var _ey = _e.y;
	//var _exspd = _e.x_speed;
	var _bb_wh = (_e.bbox_right - _e.bbox_left) / 2;
	var _bb_hh = (_e.bbox_bottom - _e.bbox_top) / 2;
	var _xx = _bb_wh*sign(_xspeed);

	
	if (tilemap_get_at_pixel(global.collision_map, _ex + _xx + _xspeed, _ey) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex + _xx + _xspeed, _ey - _bb_hh) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex + _xx + _xspeed, _ey + _bb_hh) == _terrain) {
			
		if (tilemap_get_at_pixel(global.collision_map, _ex + _xx + sign(_xspeed), _ey) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex + _xx + sign(_xspeed), _ey - _bb_hh) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex + _xx + sign(_xspeed), _ey + _bb_hh) == _terrain) {
			return 0;
		} else {
			return sign(_xspeed);
		}
	}
	
	// no collisions, return regular x_speed
	return _xspeed;
}

function entity_x_axis_check(_e, _xspeed) {
	
	var _ex = _e.x;
	var _ey = _e.y;
	var _bb_wh = (_e.bbox_right - _e.bbox_left) / 2;
	var _bb_hh = (_e.bbox_bottom - _e.bbox_top) / 2;
	var _xx = _bb_wh*sign(_xspeed);
	
	// horizontal borderbox + x_speed collision check with entity
	with (_e) {
		// save colliding entity
		var _e_collided = instance_place(_ex + _xx + _xspeed, _ey, obj_parent_entity);
		if (_e_collided && _e_collided != _e) {
			// interact + push/carry state check
			if (_e.interact_target == _e_collided) { 
				if (_e.nest_state == nest_state_push ||
					_e.nest_state == nest_state_carry) {
					return _xspeed; 
				}
			}
			// check if entity is solid
			if (_e_collided.entity_solid) {
				// check for z overlap with object _in quest_ion
				if (check_z_overlap(_e, _e_collided) == true){	
					// perform step-up check
					if (stepup_check(_e, _e_collided) == false){
						if (place_meeting(_ex + _xspeed, _ey, _e_collided)) {
							// check for collision 1 pixel away
							if (place_meeting(_ex + sign(_xspeed), _ey, _e_collided)){
								// there is a collision, return 0 so there is no movement
								return 0;
							}else {
								// no collision, return the sign 
								return sign(_xspeed);
							}
						}
					}
				}
			}
		}
	}
	
	// no collisions, return regular x_speed
	return _xspeed;
}

function wall_y_axis_check(_e, _terrain, _yspeed) {
	// LEGEND
	// _e = the object to perform the check on
	// _terrain = the terrain # to check for a collision with
	// _yy = sing of y_speed * bbox_height_half
	// _bb_wh = bbox width / 2
	
	var _ex = _e.x;
	var _ey = _e.y;
	//var _eyspd = _e.y_speed;
	var _bb_wh = (_e.bbox_right - _e.bbox_left) / 2;
	var _bb_hh = (_e.bbox_bottom - _e.bbox_top) / 2;
	var _yy = _bb_hh*sign(_yspeed);
	
	if (tilemap_get_at_pixel(global.collision_map, _ex, _ey + _yy + _yspeed) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex - _bb_wh, _ey + _yy + _yspeed) == _terrain ||
		tilemap_get_at_pixel(global.collision_map, _ex + _bb_wh, _ey + _yy + _yspeed) == _terrain){
			
		if (tilemap_get_at_pixel(global.collision_map, _ex, _ey + _yy + sign(_yspeed)) == _terrain ||
			tilemap_get_at_pixel(global.collision_map, _ex - _bb_wh, _ey + _yy + sign(_yspeed)) == _terrain ||
			tilemap_get_at_pixel(global.collision_map, _ex + _bb_wh, _ey + _yy + sign(_yspeed)) == _terrain){
			return 0;
		} else {
			return sign(_yspeed);	
		}
	}
	
	// no collisions, return regular y_speed
	return _yspeed;
}

function entity_y_axis_check(_e, _yspeed) {
	
	var _ex = _e.x;
	var _ey = _e.y;
	//var _eyspd = _e.y_speed;
	var _bb_wh = (_e.bbox_right - _e.bbox_left) / 2;
	var _bb_hh = (_e.bbox_bottom - _e.bbox_top) / 2;
	var _yy = _bb_hh*sign(_yspeed);
	
	with (_e) {
		// save the object in question
		var _e_collided = instance_place(_ex, _ey + _yy + _yspeed, obj_parent_entity);
		if (_e_collided && _e_collided != _e) {
			// interact + push/carry state check
			if (_e.interact_target == _e_collided) { 
				if (_e.nest_state == nest_state_push ||
					_e.nest_state == nest_state_carry) {
					return _yspeed;
				}
			}
			// check if entity is solid
			if (_e_collided.entity_solid) {
				// check for z overlap with object in question
				if (check_z_overlap(_e, _e_collided) == true){
					// perform step-up check
					if (stepup_check(_e,_e_collided) == false){
						if (place_meeting(_ex, _ey + _yspeed, _e_collided)) {
							// check for collision 1 pixel away
							if (place_meeting(_ex, _ey + sign(_yspeed),_e_collided)){
								// there is a collision, return 0 so there is no movement
								return 0;
							}else {
								// no collision, return the sign of either x_speed or y_speed
								return sign(_yspeed);								
							}
						}
					}
				}
			}
		}
	}
	
	// no collisions, return regular y_speed
	return _yspeed;
}

function check_z_overlap(_e, _e_collided) {
	// returns TRUE if there IS overalp
	// returns FALSE if there is NO overlap
	
	var _e_z_bot = _e.z_bottom;
	var _e_z_top = _e.z_top;
	var _e_col_z_bot = _e_collided.z_bottom;
	var _e_col_z_top = _e_collided.z_top;
	
	if (_e_col_z_bot <= _e_z_bot && _e_col_z_bot >= _e_z_top ||
		_e_col_z_top >= _e_z_top && _e_col_z_top <= _e_z_bot ||
		_e_col_z_bot >= _e_z_bot && _e_col_z_top <= _e_z_top ||
		_e_col_z_bot <= _e_z_bot && _e_col_z_top >= _e_z_top){
		// there _is z overlap
		return true;
	}else {
		// there _is no z overlap
		return false;
	}
}

function stepup_check(_e, _e_collided) {
	if (_e.terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { exit; }
	if (_e_collided.z_top >= _e.z_bottom - _e.z_step_up){
		_e.z_bottom = _e_collided.z_top-1;
		return true;
	}else {
		return false;
	}
}

function ladder_check(_e) {
	if (tilemap_get_at_pixel(global.collision_map, _e.x , _e.y + _e.y_speed) == 4 && !_e.on_ground){
		if (tilemap_get_at_pixel(global.collision_map, _e.x, _e.y + sign(_e.y_speed)) == 4 && !_e.on_ground){
			return 0;
			//y_speed = 0;
		} else {
			return sign(_e.y_speed);
			//y_speed = sign(y_speed);	
		}
	}
	
	// no changes, return regular y_speed
	return _e.y_speed;
}

function pushout_check(_e) {
	if (place_meeting(_e.x, _e.y, obj_parent_entity)){
		// save the object in question
		var _e_collided = instance_place(_e.x, _e.y, obj_parent_entity);
		
		
		if (_e.interact_target == _e_collided && _e.nest_state == nest_state_push) { exit; }
		
		// check if entity is solid
		if (_e_collided.entity_solid) {
			
			// check for z overlap with object in question
			if (check_z_overlap(_e, _e_collided) == true){
				
				var _dir = point_direction(_e_collided.x, _e_collided.y, _e.x, _e.y);
				var _cardinal_dir = round(_dir/90);
				switch(_cardinal_dir) {
					case 0: _e.x += (_e_collided.bbox_right - _e.bbox_left) + 1;		break;	// right
					case 4: _e.x += (_e_collided.bbox_right - _e.bbox_left) + 1;		break;	// right
					case 1: _e.y -= (_e.bbox_bottom - _e_collided.bbox_top) + 1;		break;	// up
					case 2: _e.x -= (_e.bbox_right - _e_collided.bbox_left) + 1;		break;	// left
					case 3: _e.y += (_e_collided.bbox_bottom - _e.bbox_top) + 1;		break;	// down
				}
			}
		}
	}
}

#region SAVE THIS CODE FOR LATER

//function bounding_box_check(_entity_collided) {
	
//	// save bound_ing boxes of coll_id_ing _instance
//	var _bbox_right = _entity_collided.bbox_right;
//	var _bbox_left = _entity_collided.bbox_left;
//	var _bbox_bottom = _entity_collided.bbox_bottom;
//	var _bbox_top = _entity_collided.bbox_top;
	
//	// perform the check
//	if (bbox_left <= _bbox_right && bbox_left >= _bbox_left ||
//		bbox_right >= _bbox_left && bbox_right <= _bbox_right ||
//		bbox_bottom <= _bbox_bottom && bbox_bottom >= _bbox_top ||
//		bbox_top >= _bbox_top  && bbox_top <= _bbox_bottom) {
//		// there _is overlap, so return true
//		return true;
//	}else {
//		// there _is NO overlap, so return false
//		return false;	
//	}
//}

//function reset_z_limits() {	
//}

// == Check For Z Solid ==
//function check_z_solid(__instance){
//	if (__instance.zSolid == true){
//		return true;
//	}else{
//		return false;
//	}
//}

// Cliff
// collide with the cliff from the sides and stop the player from moving horizontally through it
//if (z_floor = -1 && on_ground == true) {
//	if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 10 ||
//		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_height_half) == 10 ||
//		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_height_half) == 10) {
//		if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 10 ||
//		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_height_half) == 10 ||
//		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_height_half) == 10) {
//			x_speed = 0;
//		} else {
//			x_speed = sign(x_speed);
//		}
//	}
//}

// -- Handle Downward Cliffs --
// drop down the cliff if coming at it from above
//if (sign(_yy) == -1) { _yy *= -1 }
//if (tilemap_get_at_pixel(global.collision_map,x,y) == 10) {
//	for (var _i = 0; _i < room_height; _i++) {
//		if (tilemap_get_at_pixel(global.collision_map,x,y-_yy+_i) != 10) {
//			y = y + _i;
//			z_bottom -= _i;
//			break;
//		}
//	}
//	if (sign(y_speed) == -1) {
//		y_speed = 0; 
//	}
//}
	
// collide with the cliff and prevent from going up it if coming from below
//if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_height_half+y_speed) == 10 && sign(y_speed) == -1) {
//	if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_height_half+sign(y_speed)) == 10 && sign(y_speed) == -1) {
//		y_speed = 0;	
//	} else {
//		y_speed = sign(y_speed);
//	}
//}

#endregion