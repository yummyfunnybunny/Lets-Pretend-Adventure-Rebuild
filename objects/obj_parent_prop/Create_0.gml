event_inherited();

#region SET VARIABLES

// meta
faction					= FACTION_TYPE.NONE;

// can_kill
hp						= max_hp;
armor					= max_armor;
extra_damage_check		= noone;
just_got_damaged		= false;

// can_harm


// can_move
move_speed = 0;

// can_interact
//interact_type			= INTERACT_TYPE.INTERACT;
interact_target			= noone;
interact_prev_state		= noone;				// stores the state npc was in before interaction, to back to, once interaction ends
interact_percent		= 0;
//interact_change			= 1/60; moved to variable definition
//interact_range		= 1.5;
pushing = {
	x_lock: 0,
	y_lock: 0,
}
carrying = {
	xdis: 0,
	ydis: 0,
	zdis: 0,
	original_x: 0,
	original_y: 0,
	original_z: 0,
}

// can_drop_items
drop_queue				= [];

// can_spawn


// can_float


#endregion

#region SET ALARMS

enum PROP_ALARM {
	DEATH,
	DAMAGED,
	DROP_QUEUE,
	INTERACT,
}

#endregion



#region SET STATES

// MAIN STATES
main_state_closed = function() {
	
}

main_state_opening = function() {

	// begin opening 
	interact_percent += interact_change;
	var _position = animcurve_channel_evaluate(open_curve, interact_percent);
	image_index = image_number*_position;
	
	// end opening
	if (interact_percent >= 1) {
		image_index = image_number-1;
		prop_fill_drop_queue();
		main_state = main_state_opened;
	}
}

main_state_opened = function() {
	// drop items
	prop_drop_from_queue();
}

main_state_alive =  function() {
	
}

main_state_death = function() {
	if (alarm[PROP_ALARM.DEATH] == -1) {
		//global.enemy_count--;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
		//image_index = 0;
		alarm[PROP_ALARM.DEATH] = 1;
	}
	
	// destroy enemy
	if (alarm[PROP_ALARM.DEATH] == 0) {
		prop_drop_items();
		instance_destroy();
	}
}

// NEST STATES
nest_state_idle = function() {}

nest_state_hurt = function() {
	if (knockback_check()) { exit; }
	nest_state = nest_state_idle;
}

nest_state_death_normal = function() {}

nest_state_death_drown = function() {}

nest_state_death_pitfall = function() {}

nest_state_push = function() {
	if (interact_target == noone) { nest_state = nest_state_idle; }
	
	// move object relative to lock coords
	x = interact_target.x - pushing.x_lock;
	y = interact_target.y - pushing.y_lock;
}

nest_state_begin_carry = function() {
		
}

nest_state_carry = function() {

	// begin carry - move object above player
	if (alarm[PROP_ALARM.INTERACT] == -1) {
		entity_solid = false;
		global.player.input_controls.all_inputs = false;
		
		// initial setup
		if (interact_percent == 0) {
			var _dis = point_distance(x,y,interact_target.x, interact_target.y+1);
			var _dir = point_direction(x,y,interact_target.x, interact_target.y+1);
			carrying.xdis = lengthdir_x(_dis, _dir);
			carrying.ydis = lengthdir_y(_dis,_dir);
			carrying.zdis = interact_target.z_height - z_bottom + 4;
			carrying.original_x = x;
			carrying.original_y = y;
			carrying.original_z = z_bottom;
		}
		
		// progress AC curve
		interact_percent += interact_change;
		var _hposition = animcurve_channel_evaluate(carry_curve_horizontal, interact_percent);
		var _vposition = animcurve_channel_evaluate(carry_curve_vertical, interact_percent);
		
		// set entity pickup motion
		if (interact_percent < 1) {
			x = carrying.original_x + (carrying.xdis * _hposition);
			y = carrying.original_y + (carrying.ydis * _hposition);
			z_bottom = -carrying.original_z + (-carrying.zdis * _vposition);
		}
		
		// finish pickup sequence and continue carrying
		if (interact_percent >= 1) {
			alarm[PROP_ALARM.INTERACT] = -2;
			global.player.input_controls.all_inputs = true;
			interact_target.carry_object = sprite_get_name(sprite_index);
			print("my targets target 1:",interact_target.interact_target);
			instance_destroy();
			interact_target.interact_target = noone;
			print("my targets target 2:",interact_target.interact_target);
			
			
			//interact_percent = 0;
			//entity_solid = true;
			//carrying.xdis = 0;
			//carrying.ydis = 0;
			//carrying.zdis = 0;
			//carrying.original_x = 0;
			//carrying.original_y = 0;
			//carrying.original_z = 0;
		}
	}
	
	// continue carry - lock object x,y to player
	//if (alarm[PROP_ALARM.INTERACT] == -2) {
	//	z_bottom = -interact_target.z_height-4;
	//	x = interact_target.x;
	//	y = interact_target.y+1;
	//}
}

#endregion



#region HELPER FUNCTIONS

// can_kill
function prop_take_damage(_damage, _damage_type, _element_type, _special_effect) {
	if (can_kill == false) { exit; }
	if (just_got_damaged) { exit; }
	
	// check immunities
	if (damage_check_modifiers(_damage_type, _element_type, damage_immunities, element_immunities) == true) { _damage = 0; }
	
	// run extra damage check
	if (extra_damage_check) { script_execute(extra_damage_check); }
	
	// check resistances
	if (damage_check_modifiers(_damage_type, _element_type, damage_resistances, element_resistances) == true) { _damage /= round(_damage*2); }
	
	// check vulnerabilities
	if (damage_check_modifiers(_damage_type, _element_type, damage_vulnerabilities, element_vulnerabilities) == true) { _damage *= round(_damage*2); }
	
	// check armor
	_damage = damage_check_armor(_damage);
	
	// run special effect
	if (_special_effect) { script_execute(_special_effect); }
	
	// finalize damage
	if (_damage > 0) {
		hp -= _damage;
		just_got_damaged = true;
		alarm[PROP_ALARM.DAMAGED] = FPS*0.5;
		nest_state = nest_state_hurt;
		
		// play damage sound
	} else {
		// play block/resist/immune sound	
	}
}

function prop_death_check() {
	if (can_kill == false) { exit; }
	if (main_state == main_state_death) { exit; }
	if (hp <= 0) {
		main_state = main_state_death;
		nest_state = nest_state_death_normal;
	}
}

// can drop items
function prop_drop_items() {
	if (can_drop_items == false) { exit; }
	
	var _len = array_length(item_drops);
	if (_len == 0) { exit; }
	
	if (_len > 0) {
		// set drops
		for (var _i = 0; _i < _len; _i++) {
			repeat(item_drops[_i].qty) {
				var _item = instance_create_layer(x,y,INSTANCES_1_LAYER, obj_parent_item, {
					category: item_drops[_i].category,
					item_id: item_drops[_i].item_id,
				});
			}
		}
	} else {
		// random drops
	}
}

function prop_fill_drop_queue() {
	if (can_drop_items == false) { exit; }
	var _len = array_length(item_drops);
	if (_len > 0) {
		for (var _i = 0; _i < _len; _i++) {
			repeat(item_drops[_i].qty) {
				array_push(drop_queue, {
					category: item_drops[_i].category,
					item_id: item_drops[_i].item_id,
				});
			}
		}
	}
}

function prop_drop_from_queue() {
	if (can_drop_items == false) { exit; }
	var _len = array_length(drop_queue);
	if (_len == 0) { exit; }
	if (alarm[PROP_ALARM.DROP_QUEUE] == -1) {
		alarm[PROP_ALARM.DROP_QUEUE] = 3;
	}
		
	if (alarm[PROP_ALARM.DROP_QUEUE] == 0) {
		var _item = instance_create_layer(x,y+6,INSTANCES_1_LAYER, obj_parent_item, {
			category: drop_queue[0].category,
			item_id: drop_queue[0].item_id,
		});
		array_shift(drop_queue);
	}
}

// can move
function prop_knockback_check() {
	if (can_move == false) { exit; }
	if (knockback_check() == true) {
		if (nest_state != nest_state_hurt) { nest_state = nest_state_hurt; }	
	} else {
		if (nest_state == nest_state_hurt) {
			nest_state = nest_state_idle;
		}
	}
}

function prop_update_terrain_state() {
	if (can_move == false) { exit; }
	var _terrain = tilemap_get_at_pixel(global.collision_map,x,y);

	// Shallow Water
	if (_terrain == 2) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.SHALLOW_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.NONE }
		
	}
	
	// Deep Water
	if (_terrain == 3) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.DEEP_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.NONE } 
		
	}
	
	// ladder
	if (_terrain == 4) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.LADDER; }
	} else {
		if (terrain_state == TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.NONE }
	}
	
	// Tall Grass
	if (_terrain == 5) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.TALL_GRASS; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.NONE } 
	}

	// PitFall
	if (_terrain == 6) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.PITFALL; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.NONE }
	}
}

function prop_terrain_effect() {
	if (can_move == false) { exit; }
	switch (terrain_state) {
		case TERRAIN_TYPE.SHALLOW_WATER: 
			main_state = main_state_death;
			nest_state = nest_state_death_drown;
		break;
		case TERRAIN_TYPE.DEEP_WATER:	
			main_state = main_state_death;
			nest_state = nest_state_death_drown;
		break;
		case TERRAIN_TYPE.LADDER:		
					
		break;
		case TERRAIN_TYPE.TALL_GRASS:	
				
		break;
		case TERRAIN_TYPE.PITFALL:		
			main_state = main_state_death;
			nest_state = nest_state_death_pitfall;		
		break;
		default: /* nothing */ break;
	}
}

// can interact
function prop_interact_set_target() {
	if (can_interact == false) { exit; }
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (interact_type == INTERACT_TYPE.OPEN && main_state != main_state_closed) { exit; }
	
	if (!instance_exists(interact_target)) {
		if (instance_exists(obj_parent_player)){
			interact_target = instance_nearest(x,y,obj_parent_player);
			print("resetting interact_target:", interact_target);
		} else if (interact_target != noone) {
			interact_target = noone;
		}
	}
	
	if (instance_exists(interact_target)) {
		if (interact_target.main_state == obj_parent_player.main_state_death) {
			if (interact_target != noone) { interact_target = noone; }
		}
	}
}

prop_interact_range_check = function() {
	if (can_interact == false) { exit; }
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.layer != layer) { exit; }
	
	// run any interact_type specific checks here
	switch(interact_type){
		case INTERACT_TYPE.OPEN:
			if (main_state != main_state_closed) { exit; }
		break;
	}
	
	// check the distance
	var _dis = point_distance(x,y,interact_target.x,interact_target.y);
	if (_dis <= interact_range*COL_TILES_SIZE) {
		interact_target.interact_target = prop_check_target_infront();
		print("distance interact_target:", interact_target.interact_target);
	} else {
		if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
	}
}

prop_check_target_infront = function() {
	if (can_interact == false) { exit; }
	if (interact_target.on_ground == false) { exit; }
	
	// target is below, facing up
	if (interact_target.y > y) {
		if (interact_target.face_direction == 90) {
			if (bbox_left <= interact_target.x && bbox_right >= interact_target.x) {
				return id;
			}
		}
	}
	
	
	if (interact_type != INTERACT_TYPE.OPEN) {
		
		// target is above, facing down
		if (interact_target.y < y) {
			if (interact_target.face_direction == 270) {
				if (bounding_box_overlap_check("y", id, interact_target) == true) {
					return id;
				}
			}
		}
	
		// target is on the right, facing left
		if (interact_target.x > x) {
			if (interact_target.face_direction == 180) {
				if (bounding_box_overlap_check("x", id, interact_target) == true) {
					return id;
				}
			}
		}
	
		// target is on the left, facing right
		if (interact_target.x < x) {
			if (interact_target.face_direction == 0) {
				if (bounding_box_overlap_check("x", id, interact_target) == true) {
					return id;
					
				}
			}
		}
	}
	
	// all checks failed, return noone
	return noone;
}

prop_remove_interact_target_target_check = function() {
	if (interact_target == noone) { exit; }
	if (interact_target.interact_target != id) { exit; }
	
	if (interact_target.on_top_of == id) { interact_target.interact_target = noone; }
	if (interact_target.on_ground == false) { interact_target.interact_target = noone; }
}


function prop_interact_draw_icon() {
	if (can_interact == false) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.interact_target != id) { exit; }
	if (interact_type == INTERACT_TYPE.OPEN && main_state != main_state_closed) { exit; }
	if (interact_type == INTERACT_TYPE.PUSH && nest_state == nest_state_push) { exit; }
	if (interact_type == INTERACT_TYPE.CARRY&& nest_state == nest_state_carry) { exit; }
	
	draw_sprite(spr_interact_pickup,0,x,y-z_height - 8);
}

function prop_interact_end() {

	switch (interact_type) {
		case INTERACT_TYPE.PUSH:
			prop_interact_end_push();
		break;
		
		case INTERACT_TYPE.CARRY:

			//prop_interact_end_carry();
		break;
		
		case INTERACT_TYPE.OPEN:
			prop_interact_end_open();
		break;
	}
}

function prop_interact_end_push() {
	if (interact_prev_state != noone) {
		nest_state = interact_prev_state;
		interact_prev_state = noone;
		interact_target = noone;
	}
}

function prop_interact_end_open() {}

//function prop_interact_end_carry() {}

prop_interact_input_progression = function() {}

function prop_interact_throw() {
	//instance_destroy();
	// get player back in free state
	
	// get entity being thrown back in idle state or create a thrown state
	
	// apply knockback to the entity being thrown
}

#endregion

#region STARTING STATE

main_state = main_state_alive;
nest_state = nest_state_idle;

#endregion