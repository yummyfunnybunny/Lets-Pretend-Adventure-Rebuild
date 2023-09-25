/// @desc ???
function player_collision(){
	// -- Set z l_im_ites --
	// we need th_is _in order to check for z overlap later _in the code, so update _it now
	set_z_limits();
	
	
	
	// === HOR_iZONTAL AX_iS ===
	// _iSSUE HAPPENS BEFORE WE MAKE _iT TO COLL_iS_iON CHECK_iNG

	// -- Hor_izontal collision_map Check --
	var _bbox_width_half = (bbox_right-bbox_left)/2;
	var _bbox_he_ight_half = (bbox_bottom-bbox_top)/2;
	var _xx = _bbox_width_half*sign(x_speed);
	var _yy = _bbox_he_ight_half*sign(y_speed);
	
	// Walls - coll_ide with walls from the collision_map
	if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_he_ight_half) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_he_ight_half) == 1) {
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_he_ight_half) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_he_ight_half) == 1) {
			x_speed = 0;
		} else {
			x_speed = sign(x_speed);
		}
	}
	
	// -- Hor_izontal ent_it_ies --
	if (place_meeting(x+x_speed,y,obj_parent_entity)){
		//show_debug_message("ent_ity coll_is_ion 1");
		
		// save the object _in quest_ion
		var _entity_collided = instance_place(x+x_speed,y,obj_parent_entity);
		
		// check if ent_ity _is sol_id
		if (entity_solid && _entity_collided.entity_solid) {
			//show_debug_message("ent_ity coll_is_ion 2");
			// check for z overlap with object _in quest_ion
			if (check_z_overlap(_entity_collided) == true){
				//show_debug_message("ent_ity coll_is_ion 3");
				// perform step-up check
				if (stepup_check(_entity_collided) == false){
					//show_debug_message("coll_id_ing");
					//show_debug_message("ent_ity coll_is_ion 4");
					// check for coll_is_ion 1 p_ixel away
					if (place_meeting(x+sign(x_speed),y,_entity_collided)){
						// there _is a coll_is_ion, return 0 so there _is no movement
						x_speed = 0;
						//show_debug_message("ent_ity coll_is_ion 5");
					}else {
						// no coll_is_ion, return the sign of e_ither x_speed or y_speed
						x_speed = sign(x_speed);
						//show_debug_message("ent_ity coll_is_ion 6");
					}
				}
			}
		}
	}
	
	// Cliff
	// col_ide with the cliff from the s_ides and stop the player from mov_ing hor_izontally through _it
	if (z_floor = -1 && on_ground == true) {
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_he_ight_half) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_he_ight_half) == 10) {
			if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_he_ight_half) == 10 ||
			tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_he_ight_half) == 10) {
				//show_debug_message("x_speed = 0");
				x_speed = 0;
			} else {
				x_speed = sign(x_speed);
				//show_debug_message("x_speed = sign(x_speed)");
			}
		}
	}

	// -- Hor_inzontal Move Comm_it --
	x += x_speed;
	
	// === VERT_iCAL AX_iS ===

	// -- Vert_ical collision_map Check --
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
	
	// cant get on ladder unt_il you are on the ground
	if (tilemap_get_at_pixel(global.collision_map,x,y + y_speed) == 4 && !on_ground){
		if (tilemap_get_at_pixel(global.collision_map,x,y + sign(y_speed)) == 4 && !on_ground){
			y_speed = 0;	
		} else {
			y_speed = sign(y_speed);	
		}
	}
	
	// -- Handle Downward Cliffs --
	// drop down the cliff if com_ing at _it from above
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
	
	// coll_ide with the cliff and prevent from go_ing up _it if com_ing from below
	if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_he_ight_half+y_speed) == 10 && sign(y_speed) == -1) {
		if (tilemap_get_at_pixel(global.collision_map,x,y-_bbox_he_ight_half+sign(y_speed)) == 10 && sign(y_speed) == -1) {
			y_speed = 0;	
		} else {
			y_speed = sign(y_speed);
		}
	}
	
	// -- Vert_ical ent_it_ies --
	if (place_meeting(x,y+y_speed,obj_parent_entity)){
		
		// save the object _in quest_ion
		var _entity_collided = instance_place(x,y+y_speed,obj_parent_entity);
		
		// check if ent_ity _is sol_id
		if (entity_solid && _entity_collided.entity_solid) {
			// check for z overlap with object _in quest_ion
			if (check_z_overlap(_entity_collided) == true){
				
				// perform step-up check
				if (stepup_check(_entity_collided) == false){
					
					// check for coll_is_ion 1 p_ixel away
					if (place_meeting(x,y+sign(y_speed),_entity_collided)){
						// there _is a coll_is_ion, return 0 so there _is no movement
						y_speed = 0;
					}else {
						// no coll_is_ion, return the sign of e_ither x_speed or y_speed
						y_speed = sign(y_speed);
					}
				}
			}
		}
	}
	//show_debug_message("y_speed: " + string(y_speed));
	// Vert_ical Move Comm_it
	y += y_speed;
	
	// -- get pushed out of sol_id Ent_it_ies if you somehow overlap --
	// th_is should only get used when mov_ing platforms and such move ontop of the player,
	// but never when a player _is about to move onto an ent_ity.
	// that should all be pre-handled above before the move comm_it
	if (place_meeting(x,y,obj_parent_entity)){
		// save the object _in quest_ion
		var _entity_collided = instance_place(x,y,obj_parent_entity);
		// check if ent_ity _is sol_id
		if (entity_solid && _entity_collided.entity_solid) {
			// check for z overlap with object _in quest_ion
			if (check_z_overlap(_entity_collided) == true){
				var _dir = point_direction(_entity_collided.x,_entity_collided.y,x,y);
				var _cardinal_dir = round(_dir/90);
				//show_debug_message("get pushed out of ent_ity");
				//show_debug_message("x_speed: " +string(x_speed));
				//show_debug_message("y_speed: " +string(y_speed));
				switch(_cardinal_dir) {
					case 0: x += (_entity_collided.bbox_right-bbox_left)+1; break;		// r_ight
					case 1: y -= (bbox_bottom-_entity_collided.bbox_top)+1;  break;	// up
					case 2: x -= (bbox_right-_entity_collided.bbox_left)+1;  break;	// left
					case 3: y += (_entity_collided.bbox_bottom-bbox_top)+1;  break;	// down
				}
			}
		}
	}
}

// == Check For Z Overlap ==
function check_z_overlap(_entity_collided) {
	// returns TRUE if there _iS overalp
	// returns FALSE if there _is NO overlap
	var _z_bottom = _entity_collided.z_bottom;
	var _z_top = _entity_collided.z_top;
	if (_z_bottom <= z_bottom && _z_bottom >= z_top ||
		_z_top >= z_top && _z_top <= z_bottom){
		// there _is z overlap
		//show_debug_message("there _iS z overlap");
		return true;
	}else {
		// there _is no z overlap
		//show_debug_message("there _is NO z overlap");
		return false;
	}
}



// == Stepup Check ==
function stepup_check(_entity_collided) {
	if (state != player_state_wade) {
		//show_debug_message(_entity_collided.z_top);
		if (_entity_collided.z_top >= z_bottom-z_step_up){
			//show_debug_message("perform_ing the stepup check: TRUE");
			z_bottom = _entity_collided.z_top-1;
			return true;
		}else {
			//show_debug_message("perform_ing the stepup check: FALSE");
			return false;
		}
	}
}



function set_z_limits() {
	// check if there _is a coll_is_ion
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
			// set z_roof to ce_il_ing
			z_roof = -room_height;
			below_of = noone;
		}
		
		// check if _instance _is below you
		}else if (_entity_collided.z_top > z_bottom) {
			if (bounding_box_check(_entity_collided) == true) {
				//show_debug_message("SET z l_im_it to top of coll_id_ing _instance");
				z_floor = _entity_collided.z_top-1;
				on_top_of = _entity_collided;
			}else {
				// water coll_is_ion stuff w_ill probably go here... for now
				//show_debug_message("There _is no more coll_is_ion");
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

// == Bound_ing Box Check ==
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