/// @desc Initialize Menu

#region SET VARIABLES

current_menu = MENU.ITEMS;				// saves the current menu page
current_items = INVENTORY.WEAPONS;		// saves the current section of the inventory the selector is currently in
current_slot_x = 0;						// saves the grid x position
current_slot_y = 0;						// saves the grid y position
selector_start_x = 0;					// sets the x position for the current menu section
selector_start_y = 0;					// sets the y position for the current menu section
selector_sprite = 0;					// sets the image index to draw for the selector based on the current menu page

#endregion

#region ENUMS

// create bestiary Categories
enum BESTIARY_CAT {
	NONE,
	CRITTERS,
	GOBLINS,
	UNDEAD,
	BOSSES,
}


#endregion

#region HELPER FUNCTIONS

function check_if_equipped(_item_id) {
	for (var _i = 0; _i < array_length(obj_player.equip_slots); _i++){
		if (_item_id == obj_player.equip_slots[_i]) {
			// return the obj_player.equip_slots slot that its in
			return (_i);
		} 
	}
	return -1;
}

function set_inv_to_check() {
	switch(current_items) {
		case INVENTORY.WEAPONS: return obj_player.weapons;	break;
		case INVENTORY.ITEMS:	return obj_player.items;	break;
	}
}

function unequip_item(_item_id) {
	for (var _i = 0; _i < array_length(obj_player.equip_slots); _i++;) {
		if (_item_id == obj_player.equip_slots[_i]){
			obj_player.equip_slots[_i] = 0;	
		}
	}
}

function string_uppercase_first(_str){
	// set the first letter of the given string to uppercase
	var _uppercased = string_upper(string_char_at(_str, 1));
	_uppercased += string_copy(_str, 2, string_length(_str) - 1);
	return _uppercased;
}

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
		obj_player.equip_slots[_input] = _selected_item_id;
	}
	
	if (y_input) {
		var _input = EQUIP.Y;
		var _current_inventory = set_inv_to_check();
		var _selected_item_id = ds_grid_get(global.item_data,ITEM_COLUMN.ID,ds_grid_get(_current_inventory,current_slot_x,current_slot_y));
		unequip_item(_selected_item_id);
		obj_player.equip_slots[_input] = _selected_item_id;
	}
	
	if (x_input) {
		var _input = EQUIP.X;
		var _current_inventory = set_inv_to_check();
		var _selected_item_id = ds_grid_get(global.item_data,ITEM_COLUMN.ID,ds_grid_get(_current_inventory,current_slot_x,current_slot_y));
		unequip_item(_selected_item_id);
		obj_player.equip_slots[_input] = _selected_item_id;
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

function beastiary_grid_shift_left(){
	var _value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	while(_value == 0) { 
		current_slot_x--;
		_value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	}	
}

function menu_update_map() {
	
}

function menu_update_system() {
	
}

function menu_draw_items() {
	// draw background
	draw_sprite_ext(spr_menu_screen,1,0,0,1,1,0,c_white,1);
	
	// draw weapons
	var _weapons = obj_player.weapons;
	var _weapon_slots_x = 360;
	var _weapon_slots_y = 98;
	var _weapon_length = ds_grid_width(_weapons);
	for(var _i = 0; _i < _weapon_length; _i++;) {
		if (ds_grid_get(_weapons,_i,0) != 0) {
			// draw Item Sprite
			draw_sprite(spr_inv_weapon,global.item_data[# ITEM_COLUMN.INV_IMG_IDX,_weapons[# _i,0]],_weapon_slots_x+(48*_i),_weapon_slots_y);
			// draw equipped input icon
			var _equipped_input = check_if_equipped(ds_grid_get(_weapons,_i,0));
			if (_equipped_input != -1) {
				draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_weapon_slots_x-8)+(48*_i),_weapon_slots_y+8,1.5,1.5,0,c_white,1);
			}
		} else draw_sprite(spr_inv_weapon,0,_weapon_slots_x+(48*_i),_weapon_slots_y);
	}
	

	
	// draw items
	var _items = obj_player.items;
	var _item_slots_x = 360;
	var _item_slots_y = 184;
	for(var _col = 0; _col < ds_grid_width(_items); _col++;) {
		for (var _row = 0; _row < ds_grid_height(_items); _row++;) {
			if (_items[# _col,_row] != 0) {
				// draw item sprite
				draw_sprite(spr_inv_item,global.item_data[# ITEM_COLUMN.INV_IMG_IDX,_items[# _col,_row]],_item_slots_x+(48*_col),_item_slots_y+(32*_row));
				// draw equipped input icon
				var _equipped_input = check_if_equipped(ds_grid_get(_items,_col,_row));
				if (_equipped_input != -1) {
					draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_item_slots_x-8)+(48*_col),(_item_slots_y+8)+(32*_row),1.5,1.5,0,c_white,1);
				}
			} else draw_sprite(spr_inv_item,0,_item_slots_x+(48*_col),_item_slots_y+(32*_row));
		}
	}
	
	// TODO - draw other item sets
	
	// draw selector and item text
	if (alarm[0] == -1) {
		draw_sprite(spr_menu_selector,0,selector_start_x + (48*current_slot_x), selector_start_y + (32*current_slot_y));
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		switch(current_items) {
			case INVENTORY.WEAPONS:
				if (obj_player.weapons[# current_slot_x,current_slot_y] != 0) {
					draw_set_font(fnt_menu_item_name);
					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
					draw_set_font(fnt_menu_item_description);
					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
				}
			break;
			
			case INVENTORY.ITEMS:
				if (obj_player.items[# current_slot_x,current_slot_y] != 0) {
					draw_set_font(fnt_menu_item_name);
					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
					draw_set_font(fnt_menu_item_description);
					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
				}
			break;
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

function menu_draw_beastiary() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,2,0,0,1,1,0,c_white,1);
	
	// draw whichever page you're currently on
	var _starting_page_row = (beastiary_current_page*5)-5;
	var _ending_page_row = min(beastiary_current_page*5,ds_grid_height(beastiary));
	
	// draw beastiary ds grid based on the page you're on
	for (var _row = _starting_page_row; _row < _ending_page_row; _row++) {
		for (var _col = 0; _col < ds_grid_width(beastiary); _col++) {
			var _draw_y = (84+(48*(_row-((beastiary_current_page-1)*5))));
			
			// draw category titles
			if (is_string(ds_grid_get(beastiary,_col,_row))) {
				draw_set_font(fnt_beastiary_category_name);
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				var _category_title = ds_grid_get(beastiary,_col,_row);
				_category_title = string_uppercase_first(_category_title);
				draw_text(48+(32*_col),_draw_y,_category_title);
			}
			// draw enemy grid sprites
			if (is_real(ds_grid_get(beastiary,_col,_row)) && ds_grid_get(beastiary,_col,_row) != 0) {
				var _sprite = asset_get_index(ds_grid_get(global.enemy_data,ENEMY_COLUMN.GRID_SPRITE,ds_grid_get(beastiary,_col,_row)));
				var _sprite_index = global.enemy_data[# ENEMY_COLUMN.GRID_SPRITE_INDEX, ds_grid_get(beastiary, _col, _row)];
				draw_sprite(_sprite, _sprite_index, 64+(56*_col),_draw_y);
			}
		}
	}
	
	// draw beastiary selector
	if (alarm[0] == -1) {
		var _draw_y = (84+(48*(current_slot_y-((beastiary_current_page-1)*5))));
		draw_sprite(spr_menu_selector,selector_sprite, selector_start_x+(current_slot_x*56), _draw_y);		
	}
	// draw selected enemy info
	if (alarm[0] == -1) {
		// draw enemy title
		draw_set_font(fnt_menu_enemy_name);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _enemy_name = ds_grid_get(global.enemy_data,ENEMY_COLUMN.NAME,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_text(480,72,_enemy_name);

		// draw enemy sprite
		var _display_sprite = ds_grid_get(global.enemy_data,ENEMY_COLUMN.DISPLAY_SPRITE,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		if (_display_sprite != "none") {
			_display_sprite = asset_get_index(_display_sprite);
			var _sprite_height = sprite_get_height(_display_sprite);
			draw_sprite_ext(_display_sprite,0,480,138+_sprite_height,2,2,0,c_white,1);	
		}
		
		// draw enemy description
		var _enemy_description = ds_grid_get(global.enemy_data,ENEMY_COLUMN.DESCRIPTION,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_set_font(fnt_menu_enemy_description);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(355,202,_enemy_description);
		
		// draw enemy locales
		
	}
	// draw scroll knob
		var _knob_position = ((beastiary_current_page - 1)/(beastiary_pages-1));
		draw_sprite(spr_beastiary_scroller,0,23,90+(_knob_position*188));
}

function menu_draw_map() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,0,0,0,1,1,0,c_white,1);
}

function menu_draw_system() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,3,0,0,1,1,0,c_white,1);
}



#endregion

#region INIT BEASTIARY

// build the beastiary category list and the enemy count for each category
var _category_list = [];
var _enemy_list_count_per_cat = [];
var _enemy_list_count = 0;
var _current_category = "";
for (var _i = 1; _i < ds_grid_height(global.enemy_data); _i++;) {
	var _cat_i = global.enemy_data[# ENEMY_COLUMN.CATEGORY, _i];
	// new category.
	if (_cat_i != _current_category) {
		if (_current_category != "") {
			// add enemy count to enemy count per cat and reset enemy count
			array_push(_enemy_list_count_per_cat,_enemy_list_count);
			_enemy_list_count = 1;
		} else {
			_enemy_list_count++;	
		}
		//add new category to category list
		_current_category = _cat_i;
		//_category_list_index++;
		array_push(_category_list,global.enemy_data[# ENEMY_COLUMN.CATEGORY, _i]);
		
	// same category
	} else {
		// add to the enemy count for this category
		_enemy_list_count++;	
		
		// end of the data, push the final enemy count to the enemy count list
		if (_i == ds_grid_height(global.enemy_data)-1) {
			array_push(_enemy_list_count_per_cat,_enemy_list_count);	
		}
	}
}

// set the column count based the category & enemy count using the proper grid format
var _column_count = 0;
var _width_count = 5;
_column_count += array_length(_category_list);
for (var _i = 0; _i < array_length(_enemy_list_count_per_cat); _i++) {
	_column_count += ceil(_enemy_list_count_per_cat[_i]/_width_count);
}

// now create the beastiary based on the calculated column count
beastiary = ds_grid_create(_width_count,_column_count);

var _category_list_index = 0;	// this holds the current cell within the category_list array that you are on
var _enemy_list_index = 0;		// this holds the current cell within the enemy_count_per_cat array that you are on
_enemy_list_count = 0;			// this holds the current enemy count that you are on for the given cell you're in
var _enemy_data_count = 1;		// this keeps track of the current row within the global.enemy_data grid you are on

// iterate through the ds grid and fill it
for (var _row = 0; _row < ds_grid_height(beastiary); _row++) {
	for (var _col = 0; _col < ds_grid_width(beastiary); _col++) {
		
		// place the first category
		if (_row == 0 && _col == 0) { 
			ds_grid_set(beastiary,_col,_row,_category_list[_category_list_index]);
			_category_list_index++;
		}
		
		// add enemies if there is not already a title in this row
		if (!is_string(ds_grid_get(beastiary,0, _row))) {
			// add enemies to the list
			if (_enemy_list_index != _category_list_index) {
				if (_enemy_list_count < _enemy_list_count_per_cat[_enemy_list_index]) {
					ds_grid_set(beastiary,_col,_row, global.enemy_data[# ENEMY_COLUMN.ID, _enemy_data_count]);
					_enemy_data_count ++;
					_enemy_list_count ++;
					// check if we've reached the end of the enemies for this category and switch to the next enemy list
					if (_enemy_list_count = _enemy_list_count_per_cat[_enemy_list_index]) {
						_enemy_list_index ++;
						_enemy_list_count = 0;	
					}
				} else {
					// reached the end of the enemies for this category
					_enemy_list_index ++;
					_enemy_list_count = 0;
				}
			} else {
				// add the next category
				if (_col == 0) {
					ds_grid_set(beastiary,_col,_row,_category_list[_category_list_index]);
					_category_list_index++;
				}
			}
		}
	}
}

// initialize beastiary page scrolling
beastiary_pages = ceil(ds_grid_height(beastiary)/5);
beastiary_current_page = 1;

#endregion