
#region SET VARIABLES

current_menu_page = MENU_TYPE.CHARACTER;				// saves the current menu page
current_menu_section = INVENTORY_TYPE.BAG;				// saves the section of the inventory the selector is currently in

// selector
current_slot_x = 0;						// saves the grid x position
current_slot_y = 0;						// saves the grid y position
selector_start_x = 0;					// sets the x position for the current menu section
selector_start_y = 0;					// sets the y position for the current menu section
selector_img_idx = 0;					// sets the image index to draw for the selector based on the current menu page

// menu headers
header_x = global.gui_width/2;
header_y = 20;
left_subheader_x = global.gui_width/2 - 96;
right_subheader_x = global.gui_width/2 + 96;
left_header_arrow_x = global.gui_width/2 - 192;
right_header_arrow_x = global.gui_width/2 + 192;

// character - equipped slots
char_equip_x_start = 32;
char_equip_y_start = 64;
char_equip_x_gap = 112;
char_equip_y_gap = 48;

// character - bag slots
char_bag_x_start = 457;
char_bag_y_start = 77;
char_bag_gap = 61;


#endregion

#region HELPER FUNCTIONS

// update menus
function menu_update_character() {
	var _bag = global.player.bag;
	var _bag_w = array_length(_bag[0]);
	var _bag_h = array_length(_bag);
	var _equipped = global.player.equipped;
	var _equip_w = array_length(_equipped[0]);
	var _equip_h = array_length(_equipped);
	
	
	
	switch(current_menu_section) {
		case INVENTORY_TYPE.BAG:
			if (selector_start_x != char_bag_x_start) { selector_start_x = char_bag_x_start; }
			if (selector_start_y != char_bag_y_start) { selector_start_y = char_bag_y_start; }
			
			if (right_input) {
				if (current_slot_x == _bag_w-1) {
					// move to left side of equip section
					current_menu_section = INVENTORY_TYPE.EQUIPPED;
					selector_start_x = char_equip_x_start;
					selector_start_y = char_equip_y_start;
					current_slot_x = 0;
					current_slot_y = (current_slot_y > _equip_h-1) ? _equip_h-1 : current_slot_y;
				} else {
					current_slot_x++;	
				}
			}
			
			if (left_input) {
				if (current_slot_x == 0) {
					// move to right side of equip section
					current_menu_section = INVENTORY_TYPE.EQUIPPED;
					selector_start_x = char_equip_x_start;
					selector_start_y = char_equip_y_start;
					current_slot_x = 1;
					current_slot_y = (current_slot_y > _equip_h-1) ? _equip_h-1 : current_slot_y;
				} else {
					current_slot_x--;	
				}
			}
			
			if (up_input) {
				if (current_slot_y == 0) {
					current_slot_y = _bag_h-1;	
				} else {
					current_slot_y--;	
				}
			}
			
			if (down_input) {
				if(current_slot_y == _bag_h-1) {
					current_slot_y = 0;	
				} else {
					current_slot_y++;
				}
			}
			
			if (a_input) {
				// equip/use item
				
				// store current bag slot item
				var _bag_slot = _bag[current_slot_y][current_slot_x];
				var _item_id = _bag_slot.item_id;
				var _category = _bag_slot.category;
				
				switch(_category) {
					case "consumable":
					
					break;
					case "mainhand":	menu_equip_item(_equipped[0][0], _bag_slot);	break;
					case "offhand":		menu_equip_item(_equipped[0][1], _bag_slot);	break;
					case "armor":		menu_equip_item(_equipped[1][0], _bag_slot);	break;
					case "boots":		menu_equip_item(_equipped[1][1], _bag_slot);	break;
					case "trinket":		menu_equip_item(_equipped[2][0], _bag_slot);	break;
				}
			}
			
			if (b_input) {
				menu_drop_item(_bag[current_slot_y,current_slot_x]);
			}
			
		break;
		
		case INVENTORY_TYPE.EQUIPPED:
			selector_start_x = char_equip_x_start;
			selector_start_y = char_equip_y_start;
			
			if (right_input) {
				if (current_slot_x == _equip_w-1) {
					// go to left side of bag
					current_menu_section = INVENTORY_TYPE.BAG;
					selector_start_x = char_bag_x_start;
					selector_start_y = char_bag_y_start;
					current_slot_x = 0;
					current_slot_y = (current_slot_y > _bag_h-1) ? _bag_h-1 : current_slot_y;
				} else {
					current_slot_x++;	
				}
			}
			
			if (left_input) {
				if (current_slot_x == 0) {
					// go to right side of bag
					current_menu_section = INVENTORY_TYPE.BAG;
					selector_start_x = char_bag_x_start;
					selector_start_y = char_bag_y_start;
					current_slot_x = _bag_w-1;
					current_slot_y = (current_slot_y > _bag_h-1) ? _bag_h-1 : current_slot_y;
				} else {
					current_slot_x--;	
				}
			}
			
			if (up_input) {
				if (current_slot_y == 0) {
					current_slot_y = _equip_h-1;
				} else {
					current_slot_y--;	
				}
			}
			
			if (down_input) {
				if (current_slot_y == _equip_h-1) {
					current_slot_y = 0;	
				} else {
					current_slot_y++;	
				}
			}
			
			if (a_input) {
				// unequip
				var _equipped_slot = _equipped[current_slot_y][current_slot_x];
				if (_equipped_slot.item_id == 0) { exit; }
				menu_unequip_item(_equipped_slot, false);
			}
			
			if (b_input) {
				menu_drop_item(_equipped[current_slot_y,current_slot_x]);	
			}
		
		break;
	}
}

function menu_equip_item(_equipped_slot, _bag_slot) {
	if (_equipped_slot.item_id != 0) {
		// equip new item and unequip old item
		var _item_unequipping = {
			category: _equipped_slot.category,
			item_id: _equipped_slot.item_id,
		}
		_equipped_slot.item_id = _bag_slot.item_id;
		_bag_slot.item_id = 0;
		_bag_slot.category = 0;
		menu_unequip_item(_item_unequipping, true);
	} else {
		// equip new item only
		_equipped_slot.item_id = _bag_slot.item_id;
		_bag_slot.item_id = 0;
		_bag_slot.category = 0;
	}
}

function menu_unequip_item(_item_unequipping, _equip_new_item) {
	//show_debug_message(_item_unequipping);
	var _bag = global.player.bag;
	var _bag_w = array_length(_bag[0]);
	var _bag_h = array_length(_bag);
	
	// search bag for empty slot
	for (var _i = 0; _i < _bag_h; _i++) {
		for (var _j = 0; _j < _bag_w; _j++) {
			var _bag_slot = _bag[_i][_j];
			if (_bag_slot.item_id == 0) {
				// add previously equipped item to bag
				_bag_slot.item_id = _item_unequipping.item_id;
				_bag_slot.category = _item_unequipping.category;
				// empty equipped slot
				if (!_equip_new_item) {
					_item_unequipping.item_id = 0;
				}
				exit;
			}
		}	
	}
}

function menu_drop_item(_slot_item) {
	// drop item to level
	var _x = obj_player.x;
	var _y = obj_player.y;
	var _dropped_item = instance_create_layer(_x, _y, INSTANCES_1_LAYER, obj_parent_item, {
		category: _slot_item.category,
		item_id: _slot_item.item_id,
		despawn_time: 0,
	});
	
	// send broadcast
	var _broadcast = new ItemDropBroadcast(_slot_item.category, _slot_item.item_id, "gather");
	array_push(global.quest_tracker.broadcast_receiver, _broadcast);
	
	// empty the slot
	_slot_item.item_id = 0;
	_slot_item.category = 0;
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

function menu_update_quests() {
	
}

// draw menus
function menu_draw_beastiary() {
	
	// layout
	draw_sprite_ext(spr_level_menu_layouts,1,0,0,1,1,0,c_white,1);
	
	// header
	menu_draw_header("Beastiary", "Items", "System");
	
	// draw whichever page you're currently on
	var _starting_page_row = (beastiary_current_page*5)-5;
	var _ending_page_row = min(beastiary_current_page*5,ds_grid_height(beastiary));
	
	// draw beastiary ds grid based on the page you're on
	for (var _row = _starting_page_row; _row < _ending_page_row; _row++) {
		for (var _col = 0; _col < ds_grid_width(beastiary); _col++) {
			var _draw_y = (84+(48*(_row-((beastiary_current_page-1)*5))));
			
			// draw category titles
			if (is_string(ds_grid_get(beastiary,_col,_row))) {
				draw_set_font(fnt_text_12);
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				var _category_title = ds_grid_get(beastiary,_col,_row);
				_category_title = string_uppercase_first(_category_title);
				draw_text(48+(32*_col),_draw_y,_category_title);
			}
			// draw enemy grid sprites
			if (is_real(ds_grid_get(beastiary,_col,_row)) && ds_grid_get(beastiary,_col,_row) != 0) {
				var _sprite = asset_get_index(ds_grid_get(global.enemy_data,ENEMY_DATA.GRID_SPRITE,ds_grid_get(beastiary,_col,_row)));
				var _sprite_index = global.enemy_data[# ENEMY_DATA.GRID_SPRITE_INDEX, ds_grid_get(beastiary, _col, _row)];
				draw_sprite(_sprite, _sprite_index, 64+(56*_col),_draw_y);
			}
		}
	}
	
	// draw beastiary selector
	if (alarm[0] == -1) {
		var _draw_y = (84+(48*(current_slot_y-((beastiary_current_page-1)*5))));
		draw_sprite(spr_menu_selector,selector_img_idx, selector_start_x+(current_slot_x*56), _draw_y);		
	}
	// draw selected enemy info
	if (alarm[0] == -1) {
		// draw enemy title
		draw_set_font(fnt_text_16);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _enemy_name = ds_grid_get(global.enemy_data,ENEMY_DATA.NAME,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_text(480,72,_enemy_name);

		// draw enemy sprite
		var _display_sprite = ds_grid_get(global.enemy_data,ENEMY_DATA.DISPLAY_SPRITE,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		if (_display_sprite != "none") {
			_display_sprite = asset_get_index(_display_sprite);
			var _sprite_height = sprite_get_height(_display_sprite);
			draw_sprite_ext(_display_sprite,0,480,138+_sprite_height,2,2,0,c_white,1);	
		}
		
		// draw enemy description
		var _enemy_description = ds_grid_get(global.enemy_data,ENEMY_DATA.DESCRIPTION,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_set_font(fnt_text_10);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(355,202,_enemy_description);
		
		// draw enemy locales
		
	}
	// draw scroll knob
		var _knob_position = ((beastiary_current_page - 1)/(beastiary_pages-1));
		draw_sprite(spr_beastiary_scroller,0,23,90+(_knob_position*188));
		
	// reset text
	reset_text();
}

function menu_draw_map() {
	
	// layout
	draw_sprite_ext(spr_level_menu_layouts,0,0,0,1,1,0,c_white,1);
	
	// header
	menu_draw_header("Map", "Quests", "Items");
}

function menu_draw_system() {
	
	// layout
	draw_sprite_ext(spr_level_menu_layouts,3,0,0,1,1,0,c_white,1);
	
	// header
	menu_draw_header("System", "Beastiary", "Character");
}

function menu_draw_character() {

	// layout
	draw_sprite_ext(spr_level_menu_layouts,2,0,0,1,1,0,c_white,1);
	
	// header
	menu_draw_header("Character", "System", "Quests");
	
	// character
	var _char_x = 104;
	var _char_y = 130;
	draw_sprite_ext(spr_level_menu_character_char,0,_char_x,_char_y,1,1,0,c_white,1);
	
	draw_sprite_ext(spr_level_menu_icons, 0, char_equip_x_start, char_equip_y_start,1,1,0,c_white,.25);
	draw_sprite_ext(spr_level_menu_icons, 2, char_equip_x_start, char_equip_y_start+(char_equip_y_gap*1),1,1,0,c_white,.25);
	draw_sprite_ext(spr_level_menu_icons, 4, char_equip_x_start, char_equip_y_start+(char_equip_y_gap*2),1,1,0,c_white,.25);
	draw_sprite_ext(spr_level_menu_icons, 1, char_equip_x_start+char_equip_x_gap, char_equip_y_start,1,1,0,c_white,.25);
	draw_sprite_ext(spr_level_menu_icons, 3, char_equip_x_start+char_equip_x_gap, char_equip_y_start+(char_equip_y_gap*1),1,1,0,c_white,.25);
	draw_sprite_ext(spr_level_menu_icons, 4, char_equip_x_start+char_equip_x_gap, char_equip_y_start+(char_equip_y_gap*2),1,1,0,c_white,.25);
	
	// equip slots
	var _equip_width = array_length(global.player.equipped[0]);
	var _equip_height = array_length(global.player.equipped);
	var _player_equipped = global.player.equipped;
	for (var _i = 0; _i < _equip_height; _i++) {
		for (var _j = 0; _j < _equip_width; _j++) {
			// draw frame
			draw_sprite(spr_item_frame,0,char_equip_x_start+(char_equip_x_gap*_j), char_equip_y_start+(char_equip_y_gap*_i));
			
			var _item_id = _player_equipped[_i][_j].item_id;
			if (_item_id == 0) { continue; }
			
			// draw rarity
			var _category = _player_equipped[_i][_j].category;
			var _dataset = get_dataset(_category);
			var _rarity_col = enum_get_rarity(_category);
			var _rarity = ds_grid_get(_dataset, _rarity_col, _item_id);
			draw_sprite(spr_level_menu_item_rarity, _rarity, char_equip_x_start+(char_equip_x_gap*_j), char_equip_y_start+(char_equip_y_gap*_i));
			
			// draw item
			var _img_idx_col = enum_get_inv_img_idx(_category);
			
			var _sprite = asset_get_index($"spr_item_inv_{_category}");
			var _img_idx = ds_grid_get(_dataset, _img_idx_col, _item_id);
			
			draw_sprite_ext(_sprite,_img_idx, char_equip_x_start+(char_equip_x_gap*_j), char_equip_y_start+(char_equip_y_gap*_i),2,2,0,c_white,1);
		}
	}
	
	
	
	draw_set_font(fnt_text_10);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(16, 216, "HP");
	draw_text(16, 232, "MP");
	draw_text(16, 248, "ARM");
	draw_text(16, 264, "SPD");
	draw_text(16, 280, "KB");
	draw_text(16, 296, "KBR");
	
	draw_text(128, 216, "FIRE");
	draw_text(128, 232, "ICE");
	draw_text(128, 248, "SHOCK");
	draw_text(128, 264, "BLOOD");
	draw_text(128, 280, "HOLY");
	draw_text(128, 296, "NECRO");
	
	draw_set_halign(fa_right);
	draw_text(64, 216, "4");
	draw_text(64, 232, "4");
	draw_text(64, 248, "4");
	draw_text(64, 264, "4");
	draw_text(64, 280, "4");
	draw_text(64, 296, "4");
	
	draw_sprite(spr_level_menu_circles, 0, 176, 216);
	draw_sprite(spr_level_menu_circles, 0, 176, 232);
	draw_sprite(spr_level_menu_circles, 0, 176, 248);
	draw_sprite(spr_level_menu_circles, 0, 176, 264);
	draw_sprite(spr_level_menu_circles, 0, 176, 280);
	draw_sprite(spr_level_menu_circles, 0, 176, 296);
	
	// item details
	
	// bag slots
	var _player_bag_rows = array_length(global.player.bag);
	for (var _i = 0; _i < _player_bag_rows; _i++) {
		for (var _j = 0; _j < 3; _j++) {
			draw_sprite(spr_item_frame,0,char_bag_x_start+(char_bag_gap*_j), char_bag_y_start+(char_bag_gap*_i));
		}
	}
	
	// bag items
	for (var _i = 0; _i < _player_bag_rows; _i++){
		for (var _j = 0; _j < 3; _j++) {
			var _bag_slot = global.player.bag[_i][_j];
			// get bag slot details
			var _item_id = _bag_slot.item_id;
			var _category = _bag_slot.category;
			// exit if no item exists in the slot
			if (!_item_id) { continue; }
			// get the dataset to pull from
			var _dataset = get_dataset(_category);
			// set the right enums to use
			var _rarity_col = enum_get_rarity(_category);
			var _img_idx_col = enum_get_inv_img_idx(_category);
			// get the rarity, item sprite, and image index
			var _rarity = ds_grid_get(_dataset, _rarity_col,_item_id);
			var _sprite = asset_get_index($"spr_item_inv_{_category}");
			var _img_idx = ds_grid_get(_dataset, _img_idx_col, _item_id);
			// draw the rarity and then the item
			draw_sprite_ext(spr_level_menu_item_rarity, _rarity, char_bag_x_start+(char_bag_gap*_j), char_bag_y_start+(char_bag_gap*_i), 1, 1, 0, c_white, 1);
			draw_sprite_ext(_sprite,_img_idx, char_bag_x_start+(char_bag_gap*_j), char_bag_y_start+(char_bag_gap*_i),2,2,0,c_white,1);
		}
	}
	
	// footer
	
	// selector
	switch (current_menu_section) {
		case INVENTORY_TYPE.BAG:		draw_sprite(spr_menu_selector,selector_img_idx, char_bag_x_start+(char_bag_gap*current_slot_x), char_bag_y_start +(char_bag_gap*current_slot_y));	break;
		case INVENTORY_TYPE.EQUIPPED:	draw_sprite(spr_menu_selector,selector_img_idx, char_equip_x_start+(char_equip_x_gap*current_slot_x), char_equip_y_start +(char_equip_y_gap*current_slot_y));	break;
	}
	
	
	// reset text
	reset_text();
}

function menu_draw_quests() {
	// layout
	draw_sprite_ext(spr_level_menu_layouts,1,0,0,1,1,0,c_white,1);
	
	// header
	menu_draw_header("Quests", "Character", "Map");
}

function menu_draw_header(_main, _left, _right) {
	
	// header
	draw_set_font(fnt_text_24);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(header_x, header_y, _main);
	
	// left subheader
	draw_set_font(fnt_text_16);
	
	draw_set_halign(fa_right);
	draw_text(left_subheader_x, header_y, _left);
	
	// right subheader
	draw_set_halign(fa_left);
	draw_text(right_subheader_x, header_y, _right);
	
	// left arrow
	draw_sprite_ext(spr_level_menu_header_arrow, 0, left_header_arrow_x, header_y,1,1,0,c_white,1);
	
	// right arrow
	draw_sprite_ext(spr_level_menu_header_arrow, 1, right_header_arrow_x, header_y,1,1,0,c_white,1);
	
	// reset text
	reset_text();
}

// misc
function string_uppercase_first(_str){
	// set the first letter of the given string to uppercase
	var _uppercased = string_upper(string_char_at(_str, 1));
	_uppercased += string_copy(_str, 2, string_length(_str) - 1);
	return _uppercased;
}

function menu_set_selector() {
	switch (current_menu_page) {
		//case MENU_TYPE.ITEMS:		
		//	selector_img_idx = 0;
		//	current_slot_x = 0;
		//	current_slot_y = 0;
		//break;
		case MENU_TYPE.BEASTIARY:	
			selector_img_idx = 1;
			selector_start_x = 64;
			selector_start_y = 76;
			current_slot_x = 0;
			current_slot_y = 1;
			beastiary_current_page = 1;
		break;
		case MENU_TYPE.MAP:									break;
		case MENU_TYPE.SYSTEM:								break;
		case MENU_TYPE.CHARACTER:
			current_menu_section = INVENTORY_TYPE.BAG;
			selector_img_idx = 0;
			selector_start_x = char_bag_x_start;
			selector_start_y = char_bag_y_start;
			current_slot_x = 0;
			current_slot_y = 0;
		break;
		
		case MENU_TYPE.QUESTS:
		
		break;
	}
}

function beastiary_grid_shift_left(){
	var _value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	while(_value == 0) { 
		current_slot_x--;
		_value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	}	
}

#endregion

#region INIT BEASTIARY

// build the beastiary category list and the enemy count for each category
var _category_list = [];
var _enemy_list_count_per_cat = [];
var _enemy_list_count = 0;
var _current_category = "";
for (var _i = 1; _i < ds_grid_height(global.enemy_data); _i++;) {
	var _cat_i = global.enemy_data[# ENEMY_DATA.CATEGORY, _i];
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
		array_push(_category_list,global.enemy_data[# ENEMY_DATA.CATEGORY, _i]);
		
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
					ds_grid_set(beastiary,_col,_row, global.enemy_data[# ENEMY_DATA.ID, _enemy_data_count]);
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


#region ARCHIVED CODE

// -- misc --
//function check_if_equipped(_item_id) {
//	for (var _i = 0; _i < array_length(obj_player.equip_slots); _i++){
//		if (_item_id == obj_player.equip_slots[_i]) {
//			// return the obj_player.equip_slots slot that its in
//			return (_i);
//		} 
//	}
//	return -1;
//}

//function set_inv_to_check() {
//	switch(current_menu_section) {
//		case INVENTORY_TYPE.WEAPONS: return obj_player.weapons;	break;
//		case INVENTORY_TYPE.ITEMS:	return obj_player.items;	break;
//	}
//}

//function unequip_item(_item_id) {
//	for (var _i = 0; _i < array_length(obj_player.equip_slots); _i++;) {
//		if (_item_id == obj_player.equip_slots[_i]){
//			obj_player.equip_slots[_i] = 0;	
//		}
//	}
//}

// -- draw menus --
//function menu_draw_items() {
	
//	// layout
//	draw_sprite_ext(spr_level_menu_layouts,1,0,0,1,1,0,c_white,1);
	
//	// header
//	menu_draw_header("Items", "Map", "Beastiary");
	
//	// draw weapons
//	var _weapons = obj_player.weapons;
//	var _weapon_slots_x = 360;
//	var _weapon_slots_y = 98;
//	var _weapon_length = ds_grid_width(_weapons);
//	for(var _i = 0; _i < _weapon_length; _i++;) {
//		if (ds_grid_get(_weapons,_i,0) != 0) {
//			// draw Item Sprite
//			draw_sprite(spr_inv_weapon,global.item_data[# ITEM_COLUMN.INV_IMG_IDX,_weapons[# _i,0]],_weapon_slots_x+(48*_i),_weapon_slots_y);
//			// draw equipped input icon
//			var _equipped_input = check_if_equipped(ds_grid_get(_weapons,_i,0));
//			if (_equipped_input != -1) {
//				draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_weapon_slots_x-8)+(48*_i),_weapon_slots_y+8,1.5,1.5,0,c_white,1);
//			}
//		} else draw_sprite(spr_inv_weapon,0,_weapon_slots_x+(48*_i),_weapon_slots_y);
//	}
	

	
//	// draw items
//	var _items = obj_player.items;
//	var _item_slots_x = 360;
//	var _item_slots_y = 184;
//	for(var _col = 0; _col < ds_grid_width(_items); _col++;) {
//		for (var _row = 0; _row < ds_grid_height(_items); _row++;) {
//			if (_items[# _col,_row] != 0) {
//				// draw item sprite
//				draw_sprite(spr_inv_item,global.item_data[# ITEM_COLUMN.INV_IMG_IDX,_items[# _col,_row]],_item_slots_x+(48*_col),_item_slots_y+(32*_row));
//				// draw equipped input icon
//				var _equipped_input = check_if_equipped(ds_grid_get(_items,_col,_row));
//				if (_equipped_input != -1) {
//					draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_item_slots_x-8)+(48*_col),(_item_slots_y+8)+(32*_row),1.5,1.5,0,c_white,1);
//				}
//			} else draw_sprite(spr_inv_item,0,_item_slots_x+(48*_col),_item_slots_y+(32*_row));
//		}
//	}
	
//	// TODO - draw other item sets
	
//	// draw selector and item text
//	if (alarm[0] == -1) {
//		draw_sprite(spr_menu_selector,selector_img_idx,selector_start_x + (48*current_slot_x), selector_start_y + (32*current_slot_y));
//		draw_set_halign(fa_center);
//		draw_set_valign(fa_middle);
//		switch(current_menu_section) {
//			case INVENTORY_TYPE.WEAPONS:
//				if (obj_player.weapons[# current_slot_x,current_slot_y] != 0) {
//					draw_set_font(fnt_text_16);
//					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
//					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
//					draw_set_font(fnt_text_10);
//					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
//					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
//				}
//			break;
			
//			case INVENTORY_TYPE.ITEMS:
//				if (obj_player.items[# current_slot_x,current_slot_y] != 0) {
//					draw_set_font(fnt_text_16);
//					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
//					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
//					draw_set_font(fnt_text_10);
//					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
//					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
//				}
//			break;
//		}
		
//		// reset text
//		reset_text();
//	}
//}

#endregion