// == initialize Game Manager ==

global.game_paused = -1;
global.debugger = false;
global.main_layer = "Instances";

display_set_gui_size(640,360);
global.gui_width = display_get_gui_width();
global.gui_height = display_get_gui_height();

// set GUI size
display_set_gui_size(640,360);

/// -- initialize path finding grid --

// set the size of each individual cell in the grid
global.path_grid_cell_size = 8;

// create the UI Controller
global.ui = instance_create_layer(0, 0, layer, obj_con_hud);

// set damage types
enum DAMAGE_TYPE {
	NONE,			// 0
	SLASH,			// 1
	PIERCE,			// 2
	BLUNT,			// 3
	EXPLOSIVE,		// 4
	FROST,			// 5
	SHOCK,			// 6
	NECRO,			// 7
}

enum FACTION {
	NONE,
	ENEMY,
	PLAYER,
	NPC,
	COUNT,
}

/*
enum UI_MODE {
	NONE,			// no ui, playing game normally
	MAIN_MENU,		// main menu
	GAME_MENU,		// in-game menu
	PAUSE,			// game paused
	COUNT,
}
*/

enum MENU {
	MAP,
	ITEMS,
	BEASTIARY,
	SYSTEM,
}

enum INVENTORY {
	WEAPONS,
	ITEMS,
	UNIQUE_RIGHT,
	SHARDS,
	UNIQUE_LEFT,
	UNIQUE_BOTTOM,
}

current_menu = MENU.ITEMS;
current_items = INVENTORY.WEAPONS;
current_slot_x = 0;
current_slot_y = 0;
selector_start_x = 0;
selector_start_y = 0;
selector_sprite = 0;

#region INITIALIZE INVENTORY

function check_if_equipped(_item_id) {
	for (var _i = 0; _i < array_length(obj_player.equipped_items); _i++){
		if (_item_id == obj_player.equipped_items[_i]) {
			// return the obj_player.equipped_items slot that its in
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
	for (var _i = 0; _i < array_length(obj_player.equipped_items); _i++;) {
		if (_item_id == obj_player.equipped_items[_i]){
			obj_player.equipped_items[_i] = 0;	
		}
	}
}

#endregion


#region INITIALIZE BEASTIARY

// create bestiary
enum BESTIARY_CAT {
	NONE,
	CRITTERS,
	GOBLINS,
	UNDEAD,
	BOSSES,
}


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

// new create the beastiary based on the calculated column count
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

function string_ucfirst(str){
	var out = string_upper(string_char_at(str, 1));
	out += string_copy(str, 2, string_length(str) - 1);
	return out;
}

function beastiary_grid_shift_left(){
	var _value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	while(_value == 0) { 
		current_slot_x--;
		_value = ds_grid_get(beastiary,current_slot_x,current_slot_y);
	}	
}

#endregion

#region CREATE PLAYER

if (!instance_exists(obj_player) && !instance_exists(obj_con_camera)) {
	instance_create_depth(PLAYER_START_X, PLAYER_START_Y, INSTANCE_DEPTH, obj_player);
}

#endregion





#region CREATE CAMERA

if (!instance_exists(obj_con_camera)) {
	global.camera = instance_create_depth(obj_player.x,obj_player.y,INSTANCE_DEPTH,obj_con_camera);	
}

#endregion