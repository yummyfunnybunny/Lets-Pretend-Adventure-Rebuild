/// @desc ???
function entity_collision(){
	// -- Set z l_im_ites --
	// we need th_is _in order to check for z overlap later _in the code, so update _it now
	set_z_limits();
	
	
	
	// === HORiZONTAL AXiS ===
	// iSSUE HAPPENS BEFORE WE MAKE iT TO COLLiSiON CHECKiNG

	// -- Hor_izontal collision_map Check --
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
	
	// -- Horizontal entities --
	if (place_meeting(x+x_speed,y,obj_parent_entity)){
		
		// save the object _in quest_ion
		var _entity_collided = instance_place(x+x_speed,y,obj_parent_entity);
		
		// check if ent_ity _is sol_id
		if (_entity_collided.entity_solid) {
			// check for z overlap with object _in quest_ion
			if (check_z_overlap(_entity_collided) == true){
				// perform step-up check
				if (stepup_check(_entity_collided) == false){
					// check for coll_is_ion 1 p_ixel away
					if (place_meeting(x+sign(x_speed),y,_entity_collided)){
						// there _is a coll_is_ion, return 0 so there _is no movement
						x_speed = 0;
					}else {
						// no coll_is_ion, return the sign of e_ither x_speed or y_speed
						x_speed = sign(x_speed);
					}
				}
			}
		}
	}
	
	// Cliff
	// collide with the cliff from the sides and stop the player from moving horizontally through it
	if (z_floor = -1 && on_ground == true) {
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_height_half) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_height_half) == 10) {
			if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_height_half) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_height_half) == 10) {
				x_speed = 0;
			} else {
				x_speed = sign(x_speed);
			}
		}
	}

	// -- Horinzontal Move Commit --
	x += x_speed;
	
	// === VERTICAL AXIS ===

	// -- Vertical collision_map Check --
	if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+y_speed) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x-_bbox_width_half,y+_yy+y_speed) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_bbox_width_half,y+_yy+y_speed) == 1){
		if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+sign(y_speed)) == 1 ||
			tilemap_get_at_pixel(global.collision_map,x-_bbox_width_half,y+_yy+sign(y_speed)) == 1 ||
			tilemap_get_at_pixel(global.collision_map,x+_bbox_width_half,y+_yy+sign(y_speed)) == 1){
			y_speed = 0;
		} else {
			y_speed = sign(y_speed);	
		}
	}
	
	// cant get on ladder until you are on the ground
	if (tilemap_get_at_pixel(global.collision_map,x,y + y_speed) == 4 && !on_ground){
		if (tilemap_get_at_pixel(global.collision_map,x,y + sign(y_speed)) == 4 && !on_ground){
			y_speed = 0;	
		} else {
			y_speed = sign(y_speed);	
		}
	}
	
	// -- Handle Downward Cliffs --
	// drop down the cliff if coming at it from above
	if (sign(_yy) == -1) { _yy *= -1 }
	if (tilemap_get_at_pixel(global.collision_map,x,y) == 10) {
		for (var _i = 0; _i < room_height; _i++) {
			if (tilemap_get_at_pixel(global.collision_map,x,y-_yy+_i) != 10) {
				y = y + _i;
				z_bottom -= _i;
				break;
			}
		}
		if (sign(y_speed) == -1) {
			y_speed = 0; 
		}
	}
	
	// collide with the cliff and prevent from going up it if coming from below
	if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_height_half+y_speed) == 10 && sign(y_speed) == -1) {
		if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_height_half+sign(y_speed)) == 10 && sign(y_speed) == -1) {
			y_speed = 0;	
		} else {
			y_speed = sign(y_speed);
		}
	}
	
	// -- Vertical entities --
	if (place_meeting(x,y+y_speed,obj_parent_entity)){
		
		// save the object in question
		var _entity_collided = instance_place(x,y+y_speed,obj_parent_entity);
		
		// check if entity is solid
		if (entity_solid && _entity_collided.entity_solid) {
			// check for z overlap with object in question
			if (check_z_overlap(_entity_collided) == true){
				
				// perform step-up check
				if (stepup_check(_entity_collided) == false){
					
					// check for collision 1 pixel away
					if (place_meeting(x,y+sign(y_speed),_entity_collided)){
						// there is a collision, return 0 so there is no movement
						y_speed = 0;
					}else {
						// no collision, return the sign of either x_speed or y_speed
						y_speed = sign(y_speed);
					}
				}
			}
		}
	}
	// Vertical Move Commit
	y += y_speed;
	
	
	// -- get pushed out of solid Entities if you somehow overlap --
	// this should only get used when moving objects move over the player
	// but never when a player is about to move onto an entity.
	// that should all be pre-handled above before the move commit
	if (place_meeting(x,y,obj_moving_platform)){
		// save the object in question
		var _entity_collided = instance_place(x,y,obj_parent_entity);
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

// == Check For Z Overlap ==
function check_z_overlap(_entity_collided) {
	// returns TRUE if there IS overalp
	// returns FALSE if there is NO overlap
	var _z_bottom = _entity_collided.z_bottom;
	var _z_top = _entity_collided.z_top;
	if (_z_bottom <= z_bottom && _z_bottom >= z_top ||
		_z_top >= z_top && _z_top <= z_bottom){
		// there _is z overlap
		return true;
	}else {
		// there _is no z overlap
		return false;
	}
}



// == Stepup Check ==
function stepup_check(_entity_collided) {
	if (state != player_state_wade) {
		if (_entity_collided.z_top >= z_bottom-z_step_up){
			z_bottom = _entity_collided.z_top-1;
			return true;
		}else {
			return false;
		}
	}
}



function set_z_limits() {
	// check if there is a collision
	if (place_meeting(x,y,obj_parent_entity)){
		
		// save the _iD of the coll_id_ing _instance
		var _entity_collided = instance_place(x,y,obj_parent_entity);
		
		// check if _instance _is above you
		if (_entity_collided.z_bottom < z_top){
			if (bounding_box_check(_entity_collided) == true) {
			// set z_roof to bottom of coll_id_ing _instance above you
			z_roof = _entity_collided.z_bottom+1;
			below_of = _entity_collided;
		}else {
			// set z_roof to ceiling
			z_roof = -room_height;
			below_of = noone;
		}
		
		// check if instance is below you
		}else if (_entity_collided.z_top > z_bottom) {
			if (bounding_box_check(_entity_collided) == true) {
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

// == Bounding Box Check ==
function bounding_box_check(_entity_collided) {
	
	// save bound_ing boxes of coll_id_ing _instance
	var _bbox_right = _entity_collided.bbox_right;
	var _bbox_left = _entity_collided.bbox_left;
	var _bbox_bottom = _entity_collided.bbox_bottom;
	var _bbox_top = _entity_collided.bbox_top;
	
	// perform the check
	if (bbox_left <= _bbox_right && bbox_left >= _bbox_left ||
		bbox_right >= _bbox_left && bbox_right <= _bbox_right ||
		bbox_bottom <= _bbox_bottom && bbox_bottom >= _bbox_top ||
		bbox_top >= _bbox_top  && bbox_top <= _bbox_bottom) {
		// there _is overlap, so return true
		return true;
	}else {
		// there _is NO overlap, so return false
		return false;	
	}
}


/*
// == Return Correct Speed ==
function return_speed(_x_speed,_y_speed){
	if (_x_speed == 0) {
		return _y_speed;
	}else{
		return _x_speed;
	}
}
	
function reset_z_limits() {	
}

// == Check For Z Sol_id ==
function check_z_sol_id(__instance){
	if (__instance.zSol_id == true){
		return true;
	}else{
		return false;
	}
}