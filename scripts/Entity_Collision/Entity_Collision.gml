
function entity_collision(){
	// set z limites
	set_z_limits();		// we need this in order to check for z overlap later in the code, so update it now
	
	var _bbox_width_half = (bbox_right-bbox_left)/2;
	var _bbox_height_half = (bbox_bottom-bbox_top)/2;
	var _xx = _bbox_width_half*sign(x_speed);
	var _yy = _bbox_height_half*sign(y_speed);
	
	// === HORIZONTAL AXIS ===
	// regular Walls
	wall_x_axis_check(1, _xx, _bbox_height_half);
	
	// Level 1 Walls
	if (layer == layer_get_id(INSTANCES_1_LAYER)) {
		wall_x_axis_check(8, _xx, _bbox_height_half);
	}
	
	// Level 2 Walls
	if (layer == layer_get_id(INSTANCES_2_LAYER)) {
		wall_x_axis_check(7, _xx, _bbox_height_half);
	}
	
	// Entities
	entity_x_axis_check(_xx);
	

	// Horizontal Move Commit
	x += x_speed;
	
	// === VERTICAL AXIS ===

	// regular Walls
	wall_y_axis_check(1, _yy, _bbox_width_half);
	
	// Level 1 walls
	if (layer == layer_get_id(INSTANCES_1_LAYER)) {
		wall_y_axis_check(8, _yy, _bbox_width_half);
	}
	
	// Level 2 walls
	if (layer == layer_get_id(INSTANCES_2_LAYER)) {
		wall_y_axis_check(7, _yy, _bbox_width_half);
	}
	
	// cant get on ladder until you are on the ground
	if (tilemap_get_at_pixel(global.collision_map,x,y + y_speed) == 4 && !on_ground){
		if (tilemap_get_at_pixel(global.collision_map,x,y + sign(y_speed)) == 4 && !on_ground){
			y_speed = 0;
		} else {
			y_speed = sign(y_speed);	
		}
	}
	
	// Entities
	entity_y_axis_check(_yy);
	
	// Vertical Move Commit
	y += y_speed;
	
	// pushout check
	pushout_check();
}

function set_z_limits() {
	// check if there is a collision
	if (place_meeting(x,y,obj_parent_entity)){
		// save the _iD of the coll_id_ing _instance
		var _entity_collided = instance_place(x,y,obj_parent_entity);
		
		// check if _instance _is above you
		if (_entity_collided.entity_solid && _entity_collided.z_bottom < z_top){
			if (bounding_box_overlap_check("xy", id, _entity_collided) == true) {
				// set z_roof to bottom of coll_id_ing _instance above you
				z_roof = _entity_collided.z_bottom+1;
				below_of = _entity_collided;
			}else {
				// set z_roof to ceiling
				z_roof = -room_height;
				below_of = noone;
			}
		
		// check if instance is below you
		}
		
		if (_entity_collided.entity_solid && _entity_collided.z_top > z_bottom) {
			if (bounding_box_overlap_check("xy", id, _entity_collided) == true) {
				z_floor = _entity_collided.z_top-1;
				on_top_of = _entity_collided;
			}else {
				// water collision stuff will probably go here... for now
				z_floor = -1;
				on_top_of = noone;
			}
		}
	}else{
		z_roof = -room_height;
		z_floor = -1;
		on_top_of = noone;
		below_of = noone;
	}	
}

function wall_x_axis_check(_terrain,_xx, _bb_hh){
	if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bb_hh) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bb_hh) == _terrain) {
			
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bb_hh) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bb_hh) == _terrain) {
			x_speed = 0;
		} else {
			x_speed = sign(x_speed);
		}
	}
}

function entity_x_axis_check(_xx) {
	if (place_meeting(x+_xx+x_speed,y,obj_parent_entity)){
		var _entity_collided = instance_place(x+_xx+x_speed,y,obj_parent_entity);	// save the object in question
		
		if (interact_target == _entity_collided && nest_state == nest_state_push) { exit; }
		
		if (_entity_collided.entity_solid) {										// check if entity is solid
			if (check_z_overlap(_entity_collided) == true){							// check for z overlap with object _in quest_ion
				if (stepup_check(_entity_collided) == false){						// perform step-up check
					if (place_meeting(x+sign(x_speed),y,_entity_collided)){			// check for collision 1 pixel away
						x_speed = 0;												// there is a collision, return 0 so there is no movement
					}else {
						x_speed = sign(x_speed);									// no collision, return the sign x_speed
					}
				}
			}
		}
	}
}

function wall_y_axis_check(_terrain, _yy, _bb_wh) {
	if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+y_speed) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x-_bb_wh,y+_yy+y_speed) == _terrain ||
		tilemap_get_at_pixel(global.collision_map,x+_bb_wh,y+_yy+y_speed) == _terrain){
		if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+sign(y_speed)) == _terrain ||
			tilemap_get_at_pixel(global.collision_map,x-_bb_wh,y+_yy+sign(y_speed)) == _terrain ||
			tilemap_get_at_pixel(global.collision_map,x+_bb_wh,y+_yy+sign(y_speed)) == _terrain){
			y_speed = 0;
		} else {
			y_speed = sign(y_speed);	
		}
	}	
}

function entity_y_axis_check(_yy) {
	if (place_meeting(x,y+_yy+y_speed,obj_parent_entity)){
		var _entity_collided = instance_place(x,y+_yy+y_speed,obj_parent_entity);			// save the object in question
		
		if (interact_target == _entity_collided && nest_state == nest_state_push) { exit; }
		
		if (_entity_collided.entity_solid) {												// check if entity is solid
			if (check_z_overlap(_entity_collided) == true){									// check for z overlap with object in question
				if (stepup_check(_entity_collided) == false){								// perform step-up check
					if (place_meeting(x,y+sign(y_speed),_entity_collided)){					// check for collision 1 pixel away
						//show_debug_message("y_speed = 0");
						y_speed = 0;														// there is a collision, return 0 so there is no movement
					}else {
						//show_debug_message($"y_speed: {y_speed}");
						//show_debug_message($"sin y_speed: {sin(y_speed)}");
						y_speed = sign(y_speed);											// no collision, return the sign of either x_speed or y_speed
					}
				}
			}
		}
	}	
}

function check_z_overlap(_entity_collided) {
	// returns TRUE if there IS overalp
	// returns FALSE if there is NO overlap
	var _z_bottom = _entity_collided.z_bottom;
	var _z_top = _entity_collided.z_top;
	if (_z_bottom <= z_bottom && _z_bottom >= z_top ||
		_z_top >= z_top && _z_top <= z_bottom ||
		_z_bottom >= z_bottom && _z_top <= z_top ||
		_z_bottom <= z_bottom && _z_top >= z_top){
		// there _is z overlap
		return true;
	}else {
		// there _is no z overlap
		return false;
	}
}

function stepup_check(_entity_collided) {
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { exit; }
	if (_entity_collided.z_top >= z_bottom-z_step_up){
		z_bottom = _entity_collided.z_top-1;
		return true;
	}else {
		return false;
	}
}

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

function pushout_check() {
	if (place_meeting(x,y,obj_parent_entity)){
		// save the object in question
		var _entity_collided = instance_place(x,y,obj_parent_entity);
		
		
		if (interact_target == _entity_collided && nest_state == nest_state_push) { exit; }
		
		// check if entity is solid
		if (_entity_collided.entity_solid) {
			
			// check for z overlap with object in question
			if (check_z_overlap(_entity_collided) == true){
				
				var _dir = point_direction(_entity_collided.x,_entity_collided.y,x,y);
				var _cardinal_dir = round(_dir/90);
				switch(_cardinal_dir) {
					case 0: x += (_entity_collided.bbox_right-bbox_left)+1;		break;	// right
					case 4: x += (_entity_collided.bbox_right-bbox_left)+1;		break;	// right
					case 1: y -= (bbox_bottom-_entity_collided.bbox_top)+1;		break;	// up
					case 2: x -= (bbox_right-_entity_collided.bbox_left)+1;		break;	// left
					case 3: y += (_entity_collided.bbox_bottom-bbox_top)+1;		break;	// down
				}
			}
		}
	}
}

#region SAVE THIS CODE FOR LATER

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