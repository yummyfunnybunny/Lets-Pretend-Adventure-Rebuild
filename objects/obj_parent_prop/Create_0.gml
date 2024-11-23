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
//interact_range			= 1.5;
pushing = {
	x_lock: 0,
	y_lock: 0,
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
	open_percent += open_change;
	var _position = animcurve_channel_evaluate(open_curve, open_percent);
	image_index = image_number*_position;
	
	// end opening
	if (open_percent >= 1) {
		image_index = image_number-1;
		prop_fill_drop_queue();
		main_state = main_state_opened;
	}
}

main_state_opened = function() {
	// drop items
	prop_drop_from_queue();
}

main_state_alive =  function(){
	
}

main_state_death = function(){
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
nest_state_idle = function(){}

nest_state_hurt = function(){
	if (knockback_check()) { exit; }
	nest_state = nest_state_idle;
}

nest_state_death_normal = function(){}

nest_state_death_drown = function(){}

nest_state_death_pitfall = function(){}

nest_state_push = function(){
	if (interact_target == noone) { nest_state = nest_state_idle; }
	
	// move object relative to lock coords
	x = interact_target.x - pushing.x_lock;
	y = interact_target.y - pushing.y_lock;
	
	//print("object_index:",object_index);
	//print("object name:", object_get_name(object_index));
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

prop_interact_range_check = function() {}

prop_check_target_infront = function() {}

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
	
	draw_sprite(spr_interact_pickup,0,x,y-z_height - 8);
}

function prop_interact_end() {
	switch (interact_type) {
		case INTERACT_TYPE.PUSH:
			prop_interact_end_push();
		break;
		
		case INTERACT_TYPE.CARRY:
			prop_interact_end_carry();
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

function prop_interact_end_carry() {}



//function prop_interact_input_progression() {
//	if (can_interact == false) { exit; }
//	if (main_state != main_state_closed) { exit; }
	
//	//var _prop_type = object_index;
//	//show_debug_message(_prop_type);
//	//var _parent_type = object_is_ancestor(object_index, obj_parent_chest);
//	//show_debug_message(_parent_type);
//	show_debug_message($"object_index: {object_index}");
//	show_debug_message($"chest parent: {object_is_ancestor(object_index, obj_parent_chest)}");
//	show_debug_message($"crate parent: {object_is_ancestor(object_index, obj_parent_crate)}");
//	show_debug_message($"prop grand_parent: {object_is_ancestor(object_index, obj_parent_prop)}");
	
//	if (main_state == main_state_closed) {
//		// check if a key is needed
//		// - yes -> check if player has key
//			// - yes -> open check
//			// - no -> don't open chest
//		// - no -> open chest
//		if (locked == false) {
//			main_state = main_state_opening;
//		} else {
//			// do the check for the key	
//			if (global.player.ammo.keys > 0) {
//				locked = false;
//				global.player.ammo.keys--;
//				main_state = main_state_opening;
//			} else {
//				// player has no keys
//				// - shake the box, play a failed sound, etc...
//			}
//		}
//	}
//}

#endregion

#region STARTING STATE

main_state = main_state_alive;
nest_state = nest_state_idle;

#endregion