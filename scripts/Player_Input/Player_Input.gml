/// @desc ???
// if (self.state == player_state_death) ex_it;


function player_update_input(){
	// == Update _inputs ==
	left_input			= keyboard_check(vk_left);
	right_input			= keyboard_check(vk_right);
	up_input			= keyboard_check(vk_up);
	down_input			= keyboard_check(vk_down);
	interact_input		= keyboard_check(ord("V"));
	attack_input		= keyboard_check(ord("C"));
	jump_input			= keyboard_check(vk_space);
	a_input				= keyboard_check(ord("D"));
	b_input_pressed		= keyboard_check_pressed(ord("S"));
	b_input_held		= keyboard_check(ord("S"));
	b_input_released	= keyboard_check_released(ord("S"));
	y_input				= keyboard_check(ord("A"));
	x_input				= keyboard_check(ord("W"));
}

function player_move() {
	if (right_input - left_input != 0 || down_input - up_input != 0) {
			
	}
}

function player_jump() {
	if (jump_input) {
		last_safe_x = xprevious;
		last_safe_y = yprevious;
		z_speed = -z_jump_speed;
		state = player_state_jump;
	}
}

function player_attack() {
	if (attack_input) {
		state = player_state_attack;
	}
}

function player_b_input() {
	// make sure no other item is being used
	if (item_id_used == noone) {
		// get item id
		item_id_used = equipped_items[EQUIP.B];
		equip_slot_used = EQUIP.B;
		
		// get item category
		var _item_category = ds_grid_get(global.item_data,ITEM_COLUMN.CATEGORY, item_id_used);
		
		// Pressed input
		if (b_input_pressed) {
			show_debug_message("B Pressed");
			if (_item_category == "weapon") {
				state = player_state_attack;
			}
		}
		
		// held input
		if (b_input_held) {
			show_debug_message("B Held");	
			
			if (_item_category == "shield") {
				
			}
		}
		
		// released input
		if (b_input_released) {
			show_debug_message("B Released");
			
			if (_item_category == "crossbow") {
				
			}
		}
	}
}





function player_equipped_item_input(_input) {
	
	var _item_category = ds_grid_get(global.item_data,ITEM_COLUMN.CATEGORY,y);
}

function player__interact() {
	if (interact_input) {
		state = player_state__interact;
	}
}

function player_menu() {
	
}