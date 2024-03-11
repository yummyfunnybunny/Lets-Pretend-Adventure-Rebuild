/// @desc

// update input
menu_input = keyboard_check_pressed(ord("P"));


if (menu_input) {
	global.game_paused *= -1;
}

#region UPDATE MENU

if (global.game_paused == 1) {
	
	// update menu input
	right_input = keyboard_check_pressed(vk_right);
	left_input = keyboard_check_pressed(vk_left);
	up_input = keyboard_check_pressed(vk_up);
	down_input = keyboard_check_pressed(vk_down);
	right_bumper = keyboard_check_pressed(ord("E"));
	left_bumper = keyboard_check_pressed(ord("Q"));
	b_input = keyboard_check_pressed(ord("S"));
	y_input = keyboard_check_pressed(ord("A"));
	x_input = keyboard_check_pressed(ord("W"));
	
	
	// switch between menus with bumper input
	if (right_bumper) {
		if (current_menu == MENU.SYSTEM) { current_menu = MENU.MAP; } else { current_menu++;}
		menu_set_selector();
	}
	if (left_bumper) {
		if (current_menu == MENU.MAP) { current_menu = MENU.SYSTEM; } else { current_menu--;}
		menu_set_selector();
	}
	
	// update the active menu
	switch (current_menu) {
		case MENU.ITEMS:		menu_update_items();		break;
		case MENU.BEASTIARY:	menu_update_beastiary();	break;
		case MENU.MAP:			menu_update_map();			break;
		case MENU.SYSTEM:		menu_update_system();		break;
	}
}

#endregion

#region FUNCTIONS

function menu_set_selector() {
	switch (current_menu) {
		case MENU.ITEMS:		
			selector_sprite = 0;
			current_slot_x = 0;
			current_slot_y = 0;
		break;
		case MENU.BEASTIARY:	
			selector_sprite = 1;
			selector_start_x = 64;
			selector_start_y = 76;
			current_slot_x = 0;
			current_slot_y = 1;
			beastiary_current_page = 1;
		break;
		case MENU.MAP:									break;
		case MENU.SYSTEM:								break;
	}
}

function menu_update_items() {
	
	// equip / unequip / swap equipped items
	if (b_input) {
		var _input = EQUIP.B;
		var _current_inventory = set_inv_to_check();
		var _selected_item_id = ds_grid_get(global.item_data,ITEM_COLUMN.ID,ds_grid_get(_current_inventory,current_slot_x,current_slot_y));
		unequip_item(_selected_item_id);
		obj_player.equipped_items[_input] = _selected_item_id;
	}
	
	if (y_input) {
		var _input = EQUIP.Y;
		var _current_inventory = set_inv_to_check();
		var _selected_item_id = ds_grid_get(global.item_data,ITEM_COLUMN.ID,ds_grid_get(_current_inventory,current_slot_x,current_slot_y));
		unequip_item(_selected_item_id);
		obj_player.equipped_items[_input] = _selected_item_id;
	}
	
	if (x_input) {
		var _input = EQUIP.X;
		var _current_inventory = set_inv_to_check();
		var _selected_item_id = ds_grid_get(global.item_data,ITEM_COLUMN.ID,ds_grid_get(_current_inventory,current_slot_x,current_slot_y));
		unequip_item(_selected_item_id);
		obj_player.equipped_items[_input] = _selected_item_id;
	}
	
	// Set Items Selection
	switch(current_items) {
		case INVENTORY.WEAPONS:
			// set starting coordinates
			selector_start_x = 360;
			selector_start_y = 98;
			// input
			if (right_input) {
				if (current_slot_x == 5) { current_slot_x = 0; } else { current_slot_x++; }
				alarm[0] = 0;
			}
			if (left_input) {
				if (current_slot_x == 0) { current_slot_x = 5; } else { current_slot_x--; }
				alarm[0] = 0;
			}
			if (up_input) {
				current_items = INVENTORY.ITEMS;
				current_slot_y = 2; 
				alarm[0] = 0; 
			}
			if (down_input) {
				current_items = INVENTORY.ITEMS;
				current_slot_y = 0;
				alarm[0] = 0; 
			}
		break;
		
		case INVENTORY.ITEMS:
			// set starting coordinates
			selector_start_x = 360;
			selector_start_y = 184;
			// input
			if (right_input) {
				if (current_slot_x == 5) { current_slot_x = 0; } else { current_slot_x++; }
				alarm[0] = 0;
			}
			if (left_input) {
				if (current_slot_x == 0) { current_slot_x = 5; } else { current_slot_x--; }
				alarm[0] = 0;
			}
			if (up_input){
				if (current_slot_y == 0) { 
					current_items = INVENTORY.WEAPONS;
				} else { 
					current_slot_y --;
				}
				alarm[0] = 0;
			}
			if (down_input) {
				if (current_slot_y == 2) { 
					current_items = INVENTORY.WEAPONS; current_slot_y = 0;
				} else { 
					current_slot_y ++;
				}
				alarm[0] = 0;
			}
		break;
		
		case INVENTORY.UNIQUE_RIGHT:
		
		break;
		
		case INVENTORY.SHARDS:
		
		break;
		
		case INVENTORY.UNIQUE_LEFT:
		
		break;
		
		case INVENTORY.UNIQUE_BOTTOM:
		
		break;
	}
}

function menu_update_beastiary() {
	
	// update input
	if (right_input) {
		if (current_slot_x == 4) { current_slot_x = 0;} else { current_slot_x ++;}
		var _value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
		if (_value == 0 || is_string(_value) == true) { current_slot_x = 0; }
		alarm[0] = 0;
	}
	
	if (left_input) {
		if (current_slot_x == 0) { current_slot_x = 4;} else { current_slot_x --;}
		var _value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
		while ( _value == 0 || is_string(_value) == true) { 
			current_slot_x --;
			_value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
		}
		alarm[0] = 0;
	}
	
	if (up_input) {
		current_slot_y--;
		// skip category title row
		var _value = ds_grid_get(beastiary,0,current_slot_y);
		if (is_string(_value)) { current_slot_y--;}
		// move from top of the grid to the bottom of the grid
		if (current_slot_y < 0) { current_slot_y = ds_grid_height(beastiary)-1; }
		// check for empty cell and move to the left
		beastiary_grid_shift_left();
		beastiary_current_page = ceil((current_slot_y+1)/5);
		alarm[0] = 0;
	}
	
	if (down_input) {
		current_slot_y++;
		// move from bottom of the grid to the top of the grid
		if (current_slot_y > ds_grid_height(beastiary)-1) { current_slot_y = 0; }
		// skip category title row
		var _value = ds_grid_get(beastiary,0,current_slot_y);
		if (is_string(_value)) { current_slot_y++;}
		// check for empty cell and move to the left
		beastiary_grid_shift_left();
		beastiary_current_page = ceil((current_slot_y+1)/5);
		alarm[0] = 0;
	}
	
}

function menu_update_map() {
	
}

function menu_update_system() {
	
}

#endregion

/*
// debug gui mouse coords
var _gui_x = device_mouse_x_to_gui(0);
var _gui_y = device_mouse_y_to_gui(0);
show_debug_message("gui x: " +string(_gui_x));
show_debug_message("gui y: " +string(_gui_y));