/// @desc initialize game

#region GUI

// set GUI size
display_set_gui_size(640,360);

#endregion

#region MACROS

#macro COL_TILES_SIZE 16
#macro FPS game_get_speed(gamespeed_fps)
#macro PLAYER_START_X 385
#macro PLAYER_START_Y 255
#macro INSTANCE_DEPTH 700
#macro INSTANCE_LAYER "Instances"
#macro PATH_GRID_CELL_SIZE 8

#endregion

#region GLOBALM VARIABLES

global.game_paused = -1;
global.debugger = false;
global.main_layer = "Instances";
global.ui_type = UI_TYPE.MAIN_MENU;

display_set_gui_size(640,360);
global.gui_width = display_get_gui_width();
global.gui_height = display_get_gui_height();

#endregion

#region ENUMERATORS

// UI types
enum UI_TYPE {
	LEVEL,			// 0
	OVERWORLD,		// 1
	MAIN_MENU		// 2
}

// set damage types
enum DAMAGE_TYPE {
	NONE,			// 0
	SLASH,			// 1
	PIERCE,			// 2
	BLUNT,			// 3
	EXPLOSIVE,		// 4
}

// element types
enum ELEMENT_TYPE {
	NONE,			// 0
	FROST,			// 1
	SHOCK,			// 2
	NECRO,			// 3
}

// factions
enum FACTION {
	NONE,			// 0
	ENEMY,			// 1
	PLAYER,			// 2
	NPC,			// 3
	COUNT,
}

// menu
enum MENU {
	MAP,			// 0
	ITEMS,			// 1
	BEASTIARY,		// 2
	SYSTEM,			// 3
}

// inventory
enum INVENTORY {
	WEAPONS,		// 0
	ITEMS,			// 1
	UNIQUE_RIGHT,	// 2
	SHARDS,			// 3
	UNIQUE_LEFT,	// 4
	UNIQUE_BOTTOM,	// 5
}

#endregion

#region GAME INIT FUNCTIONS

function remove_header_row(_grid,_row){
	// get the width and height of the grid to alter
    var _width = ds_grid_width(_grid);
    var _height = ds_grid_height(_grid);
    
	// iterate through and replace every cell with the cell data below it
    for(var _i = _row+1; _i < _height; _i++){
		// skip the first row
        if(_i > 0){
			for(var _j = 0; _j < _width; _j++){
				ds_grid_set(_grid, _j, _i-1, ds_grid_get(_grid, _j, _i));
            }
        }
    }
    // resize the grid, removing the bottom row
    ds_grid_resize(_grid, _width, _height-1);
}

#endregion

#region IMPORT DATA

#region items

// item data enum
enum ITEM_COLUMN {
	ID,
	NAME,
	DESCRIPTION,
	CATEGORY,
	SPRITE_INDEX,
	IMAGE_INDEX,
	EQUIPPED,
	DAMAGE_TYPE,
	DAMAGE,
	KNOCKBACK,
	WINDUP,
	FOLLOWTHROUGH,
	WEAPON_TYPE,
	DAMAGE_SPRITE,
	START,
	END_WALL,
	END_FOE,
	ELEMENT_TYPE,
	EFFECT,
	
}

// import item csv
global.item_data = load_csv("items_data.csv");
for (var _i = 1; _i < ds_grid_height(global.item_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.item_data,ITEM_COLUMN.ID,_i,real(global.item_data[# ITEM_COLUMN.ID,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.IMAGE_INDEX,_i,real(global.item_data[# ITEM_COLUMN.IMAGE_INDEX,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.EQUIPPED,_i,real(global.item_data[# ITEM_COLUMN.EQUIPPED,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DAMAGE_TYPE,_i,real(global.item_data[# ITEM_COLUMN.DAMAGE_TYPE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DAMAGE,_i,real(global.item_data[# ITEM_COLUMN.DAMAGE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.KNOCKBACK,_i,real(global.item_data[# ITEM_COLUMN.KNOCKBACK,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.WINDUP,_i,real(global.item_data[# ITEM_COLUMN.WINDUP,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.FOLLOWTHROUGH,_i,real(global.item_data[# ITEM_COLUMN.FOLLOWTHROUGH,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.START,_i,real(global.item_data[# ITEM_COLUMN.START,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.END_WALL,_i,real(global.item_data[# ITEM_COLUMN.END_WALL,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.END_FOE,_i,real(global.item_data[# ITEM_COLUMN.END_FOE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.ELEMENT_TYPE,_i,real(global.item_data[# ITEM_COLUMN.ELEMENT_TYPE,_i]));
}

// remove header row from ds grid
remove_header_row(global.item_data,0);

#endregion

#region enemies

// enemy data enum
enum ENEMY_COLUMN {
	ID,
	NAME,
	CATEGORY,
	GRID_SPRITE,
	GRID_SPRITE_INDEX,
	DISPLAY_SPRITE,
	DESCRIPTION,
	DEFEATED,
	LOCALES,
}

// import enemy csv
global.enemy_data = load_csv("enemy_data.csv");
for (var _i = 1; _i < ds_grid_height(global.enemy_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.ID,_i,real(global.enemy_data[# ENEMY_COLUMN.ID,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.GRID_SPRITE_INDEX,_i,real(global.enemy_data[# ENEMY_COLUMN.GRID_SPRITE_INDEX,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.DEFEATED,_i,bool(global.enemy_data[# ENEMY_COLUMN.DEFEATED,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.LOCALES,_i,real(global.enemy_data[# ENEMY_COLUMN.LOCALES,_i]));
}

// remove header row from ds grid
remove_header_row(global.enemy_data,0);

#endregion

#region quests

// nothing here yet

#endregion

#endregion




