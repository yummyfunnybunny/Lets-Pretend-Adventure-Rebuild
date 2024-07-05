/// @desc initialize game

// -- MACROS --
#region MACROS

#macro COL_TILES_SIZE 16
#macro FPS game_get_speed(gamespeed_fps)
#macro PLAYER_START_X 84
#macro PLAYER_START_Y 504
#macro INSTANCE_DEPTH 700

#endregion

// -- ENUMS --

// initialize data column enums for easier accessing
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
}

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

// load CVS files and set the data
global.item_data = load_csv("items_data.csv");
for (var _i = 1; _i < ds_grid_height(global.item_data); _i ++) {
	ds_grid_set(global.item_data,ITEM_COLUMN.ID,_i,real(global.item_data[# ITEM_COLUMN.ID,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.IMAGE_INDEX,_i,real(global.item_data[# ITEM_COLUMN.IMAGE_INDEX,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.EQUIPPED,_i,real(global.item_data[# ITEM_COLUMN.EQUIPPED,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DAMAGE_TYPE,_i,real(global.item_data[# ITEM_COLUMN.DAMAGE_TYPE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DAMAGE,_i,real(global.item_data[# ITEM_COLUMN.DAMAGE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.KNOCKBACK,_i,real(global.item_data[# ITEM_COLUMN.KNOCKBACK,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.WINDUP,_i,real(global.item_data[# ITEM_COLUMN.WINDUP,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.FOLLOWTHROUGH,_i,real(global.item_data[# ITEM_COLUMN.FOLLOWTHROUGH,_i]));
}

global.enemy_data = load_csv("enemy_data.csv");

for (var _i = 1; _i < ds_grid_height(global.enemy_data); _i ++) {
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.ID,_i,real(global.enemy_data[# ENEMY_COLUMN.ID,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.GRID_SPRITE_INDEX,_i,real(global.enemy_data[# ENEMY_COLUMN.GRID_SPRITE_INDEX,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.DEFEATED,_i,bool(global.enemy_data[# ENEMY_COLUMN.DEFEATED,_i]));
	ds_grid_set(global.enemy_data,ENEMY_COLUMN.LOCALES,_i,real(global.enemy_data[# ENEMY_COLUMN.LOCALES,_i]));
}

#region FUNCTIONS

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

remove_header_row(global.item_data,0);
remove_header_row(global.enemy_data,0);
#endregion

show_debug_message(global.enemy_data);
show_message(global.enemy_data);





