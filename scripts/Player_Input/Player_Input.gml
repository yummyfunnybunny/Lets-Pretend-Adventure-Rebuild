
function player_update_input(){
	if (global.player.input_controls.all_inputs == false) { 
		player_cancel_input("all");
		exit; 
	}
	
	// moving
	if (global.player.input_controls.move_input == true) {
		left_input			= keyboard_check(vk_left);
		right_input			= keyboard_check(vk_right);
		up_input			= keyboard_check(vk_up);
		down_input			= keyboard_check(vk_down);
	}
	
	if (global.player.input_controls.jump_input == true) {
		jump_input			= keyboard_check_pressed(vk_space);
	}
	
	// letter inputs
	if (global.player.input_controls.a_input == true) {
		a_keycode			= 86
		a_input_pressed		= keyboard_check_pressed(ord("V"));
		a_input_held		= keyboard_check(ord("V"));
		a_input_released	= keyboard_check_released(ord("V"));
	}
	
	if (global.player.input_controls.b_input == true) {
		b_keycode			= 67
		b_input_pressed		= keyboard_check_pressed(ord("C"));
		b_input_held		= keyboard_check(ord("C"));
		b_input_released	= keyboard_check_released(ord("C"));
	}
	
	if (global.player.input_controls.x_input == true) {
		x_keycode			= 88
		x_input_pressed		= keyboard_check_pressed(ord("X"));
		x_input_held		= keyboard_check(ord("X"));
		x_input_released	= keyboard_check_released(ord("X"));
	}
	
	if (global.player.input_controls.y_input == true) {
		y_keycode			= 90
		y_input_pressed		= keyboard_check_pressed(ord("Z"));
		y_input_held		= keyboard_check(ord("Z"));
		y_input_released	= keyboard_check_released(ord("Z"));
	}
}

function player_cancel_input(_input) {
	
	if (_input == "move" || _input == "all") {
		left_input = false;
		right_input = false;
		up_input = false;
		down_input = false;
	}
	
	if (_input == "a" || _input == "all") {
		a_input_pressed = false;
		a_input_held = false;
		a_input_released = false;
	}
	
	if (_input == "b" || _input == "all") {
		b_input_pressed = false;
		b_input_held = false;
		b_input_released = false;
	}
	
	if (_input == "x" || _input == "all") {
		x_input_pressed = false;
		x_input_held = false;
		x_input_released = false;
	}
	
	if (_input == "y" || _input == "all") {
		y_input_pressed = false;
		y_input_held = false;
		y_input_released = false;
	}
	
	if (_input == "jump" || _input == "all") {
		jump_input = false;
	}
}

function player_input_jump_check() {
	if (instance_exists(obj_con_textbox)) { exit; }
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (jump_input) {
		last_safe_x = xprevious;
		last_safe_y = yprevious;
		z_speed = -z_jump_speed;
	}
}

function player_input_a_check() {
	// keyboard = V
	if (instance_exists(obj_con_textbox)) { exit; }
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	
	// get equipped slot A input type
	var _input_type = get_weapon_input_type(global.player.equipped[0][0]);

	// check for input
	//if (player_input_handler(_input_type, a_keycode) == true) {
	//	player_use_mainhand(global.player.equipped[0][0]);
	//}
}

function player_input_b_check() {
	// keyboard = C
	if (instance_exists(obj_con_textbox)) { exit; }
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (b_input_pressed) {
		player_use_offhand(global.player.equipped[0][1]);
	}
}

function player_input_x_check() {
	// keyboard = X
	if (!x_input_pressed && !x_input_held && !x_input_released) { exit; }
	if (!interact_target) { exit; }
	
	if (x_input_pressed == true || x_input_held == true || x_input_released == true) {
		
		// check the interact_target's interact type and act accordingly
		var _input_type = get_interact_target_input_type(interact_target);
	
		if (player_input_handler(_input_type, "x") == true) {
		
			// call objects input progression
			with (interact_target) {
				// NPCs
				if (object_is_ancestor(object_index,obj_parent_npc)) {
					npc_interact_input_progression();
				// ITEMS
				} else if (object_index == obj_parent_item) {
					item_interact_input_progression();
				// PROPS
				} else if(object_is_ancestor(object_index, obj_parent_prop)) {
					prop_interact_input_progression();
				}
			}
			// set player state
			switch(interact_target.interact_type) {
				case INTERACT_TYPE.PUSH:
					nest_state = nest_state_push;
				break;
				case INTERACT_TYPE.CARRY:
				nest_state = nest_state_carry;
			}
		} else {
			// currently, click does not need to use this else statement because they are finished as soon as the click occurs anyway
			// release: IDK we'll have to revamp the whole thing once we get a release type input made
			if (_input_type == "hold") {
				player_interact_end(nest_state_free);
			}
		}
	}
}

function player_interact_end(_goto_state) {
	
	// reset interact target
	if (interact_target) {
		with (interact_target) {
			// NPCs
			if (object_is_ancestor(object_index,obj_parent_npc)) {
			
			// ITEMS
			} else if (object_index == obj_parent_item) {
				
			// PROPS
			} else if(object_is_ancestor(object_index, obj_parent_prop)) {
				prop_interact_end();	
			}
		}
	}
	// reset player
	interact_target = noone;
	nest_state = _goto_state;
}

function player_input_y_check() {
	// keyboard = Z
	if (instance_exists(obj_con_textbox)) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (!on_ground) { exit; }
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (y_input_pressed) {
	}
}

function get_interact_target_input_type(_target) {
	
	var _type = _target.interact_type;
	switch(_type) {
		case INTERACT_TYPE.TALK:
		case INTERACT_TYPE.SHOP:
		case INTERACT_TYPE.QUEST:
		case INTERACT_TYPE.CARRY:
		case INTERACT_TYPE.PICKUP:
		case INTERACT_TYPE.OPEN:
			return "click";

		case INTERACT_TYPE.PUSH:
			return "hold";
	}
}

function get_weapon_input_type(_wep){
	var _dataset = get_dataset(_wep.category);
	var _wep_type_enum = enum_get_wep_type(_wep.category);
	var _type = ds_grid_get(_dataset,_wep_type_enum,_wep.item_id);
	
	switch(_type) {
		case "sword":
		case "boomstick":
		case "tomahawk":
		case "bomb":
			return "click";
		
		case "flail":
		case "shield":
			return "hold";
		
		case "crossbow":
			return "release";
	}
}

function player_input_handler(_input_type, _keycode) {

	// set input group being pressed (a,b,x,y)
	var _input_pressed		= undefined; 
	var _input_held			= undefined; 
	var _input_released		= undefined;
	switch(_keycode) {
		case "a":
			_input_pressed	= a_input_pressed;
			_input_held		= a_input_held;
			_input_released = a_input_released;
		break;
		
		case "b":
			_input_pressed	= b_input_pressed;
			_input_held		= b_input_held;
			_input_released = b_input_released;
		break;
		
		case "x":
			_input_pressed	= x_input_pressed;
			_input_held		= x_input_held;
			_input_released = x_input_released;
		break;
		
		case "y":
			_input_pressed	= y_input_pressed;
			_input_held		= y_input_held;
			_input_released = y_input_released;
		break;
	}
	
	//show_debug_message($"{_input_pressed}, {_input_held}, {_input_released}");
	if (!_input_pressed && !_input_held && !_input_released) {
		exit;
	}
	
	// return the result of the input check based on the type
	switch(_input_type) {
		case "click":
			if (_input_pressed) {
				return true;
			} else {
				return false;
			}
		break;
		
		case "hold":
			if (_input_held) {
				return true;
			} else {
				return false;
			}
		break;
		
		case "release":
			if (_input_held) {
				_inputs.held = true;
				_inputs.released = false;
			} else if (_input_released) {
				_inputs.held = false;
				_inputs.released = true;
			} else {
				_inputs.held = false;
				_inputs.released = false;
			}
		break;
	}
}