/// @desc initialize game

randomize();

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

global.game_paused = false;
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
enum DAMAGE {
	NONE,			// 0
	SLASH,			// 1
	PIERCE,			// 2
	BLUNT,			// 3
	EXPLOSIVE,		// 4
}

// element types
enum ELEMENT {
	NONE,			// 0
	FROST,			// 1
	SHOCK,			// 2
	NECRO,			// 3
	FIRE,			// 4
	HOLY,			// 5
	BLOOD,			// 6
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

enum TERRAIN {
	NONE,
	WALL,
	SHALLOW_WATER,
	DEEP_WATER,
	LADDER,
	TALL_GRASS,
	PITFALL,
}

enum ITEM {
	NONE,
	WEAPON,
	ARMOR,
	BOOTS,
	TRINKET,
	COLLECTIBLE,
	CONSUMABLE,
	POWERUP,
	AMMO,
	REAGENT,
	ITEM, 
}

enum WEP_TYPE {
	NONE,
	SWORD,
	CROSSBOW,
	SHIELD,
	FLAIL,
	BOOMSTICK,
	TOMAHAWK,
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

#region weapons

enum WEP_DATA {
	ID,						// number
	NAME,					// string
	DESC,					// string
	CATEGORY,				// string - helps differentiate from other items from other data sets and is used to pick the proper sprite indexes
	DMG_TYPE,				// string
	WEP_TYPE,				// string
	ELMT_TYPE,				// string
	DROP_IMG_IDX,			// number
	INV_IMG_IDX,			// number
	DMG_IMG_IDX,			// number
	DMG_AMT,				// number
	KNOCKBACK,				// number
	WEP_START,				// number
	WEP_CD,					// number
	EFFECT,					// function/number
}

// import weapon csv
global.weapon_data = load_csv("weapon_data.csv");
for (var _i = 1; _i < ds_grid_height(global.weapon_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.weapon_data,WEP_DATA.ID,_i,real(global.weapon_data[# WEP_DATA.ID,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.DROP_IMG_IDX,_i,real(global.weapon_data[# WEP_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.INV_IMG_IDX,_i,real(global.weapon_data[# WEP_DATA.INV_IMG_IDX,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.DMG_IMG_IDX,_i,real(global.weapon_data[# WEP_DATA.DMG_IMG_IDX,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.DMG_AMT,_i,real(global.weapon_data[# WEP_DATA.DMG_AMT,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.KNOCKBACK,_i,real(global.weapon_data[# WEP_DATA.KNOCKBACK,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.WEP_START,_i,real(global.weapon_data[# WEP_DATA.WEP_START,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.WEP_CD,_i,real(global.weapon_data[# WEP_DATA.WEP_CD,_i]));
	ds_grid_set(global.weapon_data,WEP_DATA.EFFECT,_i,real(global.weapon_data[# WEP_DATA.EFFECT,_i]));
}

// remove header row from ds grid
remove_header_row(global.weapon_data,0);

#endregion

#region armor

enum ARMOR_DATA {
	ID,						// number
	NAME,					// string
	DESC,					// string
	CATEGORY,				// string - helps differentiate from other items from other data sets and is used to pick the proper sprite indexes
	DROP_IMG_IDX,			// number
	INV_IMG_IDX,			// number
	HP,						// number
	MP,						// number
	ARMOR,					// number
	KNOCKBACK,				// number
	DMG_IMN,				// array
	DMG_RES,				// array
	DMG_VULN,				// array
	ELMT_IMN,				// array
	ELMT_RES,				// array
	ELMT_VULN,				// array
	EFFECT,					// function/number
}

// import weapon csv
global.armor_data = load_csv("armor_data.csv");
for (var _i = 1; _i < ds_grid_height(global.armor_data); _i ++) {
	// 1 - convert numbers
	ds_grid_set(global.armor_data,ARMOR_DATA.ID,_i,real(global.armor_data[# ARMOR_DATA.ID,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.DROP_IMG_IDX,_i,real(global.armor_data[# ARMOR_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.INV_IMG_IDX,_i,real(global.armor_data[# ARMOR_DATA.INV_IMG_IDX,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.HP,_i,real(global.armor_data[# ARMOR_DATA.HP,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.MP,_i,real(global.armor_data[# ARMOR_DATA.MP,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.ARMOR,_i,real(global.armor_data[# ARMOR_DATA.ARMOR,_i]));
	ds_grid_set(global.armor_data,ARMOR_DATA.KNOCKBACK,_i,real(global.armor_data[# ARMOR_DATA.KNOCKBACK,_i]));
	
	// 2 - convert arrays
	// damage immunities
	var _dmg_imn_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.DMG_IMN,_i),",");
	for (var _j = 0; _j < array_length(_dmg_imn_array); _j++) {
			_dmg_imn_array[_j] = real(_dmg_imn_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.DMG_IMN,_i, _dmg_imn_array);
	// damage resistances
	var _dmg_res_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.DMG_RES,_i),",");
	for (var _j = 0; _j < array_length(_dmg_res_array); _j++) {
			_dmg_res_array[_j] = real(_dmg_res_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.DMG_RES,_i, _dmg_res_array);
	// damage vulnerabilities
	var _dmg_vuln_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.DMG_VULN,_i),",");
	for (var _j = 0; _j < array_length(_dmg_vuln_array); _j++) {
			_dmg_vuln_array[_j] = real(_dmg_vuln_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.DMG_VULN,_i, _dmg_vuln_array);
	// elemment immunities
	var _elmt_imn_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.ELMT_IMN,_i),",");
	for (var _j = 0; _j < array_length(_elmt_imn_array); _j++) {
			_elmt_imn_array[_j] = real(_elmt_imn_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.ELMT_IMN,_i, _elmt_imn_array);
	// element resistances
	var _elmt_res_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.ELMT_RES,_i),",");
	for (var _j = 0; _j < array_length(_elmt_res_array); _j++) {
			_elmt_res_array[_j] = real(_elmt_res_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.ELMT_RES,_i, _elmt_res_array);
	// element vulnerabilities
	var _elmt_vuln_array = string_split(ds_grid_get(global.armor_data,ARMOR_DATA.ELMT_VULN,_i),",");
	for (var _j = 0; _j < array_length(_elmt_vuln_array); _j++) {
			_elmt_vuln_array[_j] = real(_elmt_vuln_array[_j]);
	}
	ds_grid_set(global.armor_data,ARMOR_DATA.ELMT_VULN,_i, _elmt_vuln_array);
}

// remove header row from ds grid
remove_header_row(global.armor_data,0);

#endregion

#region boots

enum BOOTS_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string
	DROP_IMG_IDX,		// number
	INV_IMG_IDX,		// number
	RUN_SPD,			// number
	WADE_SPD,			// number
	SWIM_SPD,			// number
	CLIMB_SPD,			// number
	EFFECT,				// function
}

// import boots csv
global.boots_data = load_csv("boots_data.csv");
for (var _i = 1; _i < ds_grid_height(global.boots_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.boots_data,BOOTS_DATA.ID,_i,real(global.boots_data[# BOOTS_DATA.ID,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.DROP_IMG_IDX,_i,real(global.boots_data[# BOOTS_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.INV_IMG_IDX,_i,real(global.boots_data[# BOOTS_DATA.INV_IMG_IDX,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.RUN_SPD,_i,real(global.boots_data[# BOOTS_DATA.RUN_SPD,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.WADE_SPD,_i,real(global.boots_data[# BOOTS_DATA.WADE_SPD,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.SWIM_SPD,_i,real(global.boots_data[# BOOTS_DATA.SWIM_SPD,_i]));
	ds_grid_set(global.boots_data,BOOTS_DATA.CLIMB_SPD,_i,real(global.boots_data[# BOOTS_DATA.CLIMB_SPD,_i]));
}

// remove header row from ds grid
remove_header_row(global.boots_data,0);


#endregion

#region trinkets

enum TRINKET_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string
	DROP_IMG_IDX,		// number
	INV_IMG_IDX,		// number
	EFFECT,				// function
}

// import collectible csv
global.trinket_data = load_csv("trinket_data.csv");
for (var _i = 1; _i < ds_grid_height(global.trinket_data); _i ++) {
	// convert numbers
	ds_grid_set(global.trinket_data,TRINKET_DATA.ID,_i,real(global.trinket_data[# TRINKET_DATA.ID,_i]));
	ds_grid_set(global.trinket_data,TRINKET_DATA.DROP_IMG_IDX,_i,real(global.trinket_data[# TRINKET_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.trinket_data,TRINKET_DATA.INV_IMG_IDX,_i,real(global.trinket_data[# TRINKET_DATA.INV_IMG_IDX,_i]));
}

// remove header row from ds grid
remove_header_row(global.trinket_data,0);

#endregion

#region ammo

enum AMMO_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string -  helps differentiate from other items from other data sets
	AMMO_TYPE,			// string - the ammo type to increase (hp, mp, armor, coins, arrows, bombs, axes, keys, etc)
	DROP_IMG_IDX,		// number - image index of the drop ammo sprite index to show
	AMMO_AMT,			// number - amount to increase the ammo
}

// import item csv
global.ammo_data = load_csv("ammo_data.csv");
for (var _i = 1; _i < ds_grid_height(global.ammo_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.ammo_data,AMMO_DATA.ID,_i,real(global.ammo_data[# AMMO_DATA.ID,_i]));
	ds_grid_set(global.ammo_data,AMMO_DATA.DROP_IMG_IDX,_i,real(global.ammo_data[# AMMO_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.ammo_data,AMMO_DATA.AMMO_AMT,_i,real(global.ammo_data[# AMMO_DATA.AMMO_AMT,_i]));
}

// remove header row from ds grid
remove_header_row(global.ammo_data,0);

#endregion

#region consumables

enum CONSUMABLE_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string
	DROP_IMG_IDX,		// number
	INV_IMG_IDX,		// number
	EFFECT,				// function/number - stores the function that dictates what the consumable does
}

// import item csv
global.consumable_data = load_csv("consumable_data.csv");
for (var _i = 1; _i < ds_grid_height(global.consumable_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.consumable_data,CONSUMABLE_DATA.ID,_i,real(global.consumable_data[# CONSUMABLE_DATA.ID,_i]));
	ds_grid_set(global.consumable_data,CONSUMABLE_DATA.DROP_IMG_IDX,_i,real(global.consumable_data[# CONSUMABLE_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.consumable_data,CONSUMABLE_DATA.INV_IMG_IDX,_i,real(global.consumable_data[# CONSUMABLE_DATA.INV_IMG_IDX,_i]));
	ds_grid_set(global.consumable_data,CONSUMABLE_DATA.EFFECT,_i,real(global.consumable_data[# CONSUMABLE_DATA.EFFECT,_i]));
}

// remove header row from ds grid
remove_header_row(global.consumable_data,0);

#endregion

#region collectibles

enum COLLECTIBLE_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string
	COLLECTIBLE_TYPE,	// string
	DROP_IMG_IDX,		// number
	INV_IMG_IDX,		// number
}

// import collectible csv
global.collectible_data = load_csv("collectible_data.csv");
for (var _i = 1; _i < ds_grid_height(global.collectible_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.collectible_data,COLLECTIBLE_DATA.ID,_i,real(global.collectible_data[# COLLECTIBLE_DATA.ID,_i]));
	ds_grid_set(global.collectible_data,COLLECTIBLE_DATA.DROP_IMG_IDX,_i,real(global.collectible_data[# COLLECTIBLE_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.collectible_data,COLLECTIBLE_DATA.INV_IMG_IDX,_i,real(global.collectible_data[# COLLECTIBLE_DATA.INV_IMG_IDX,_i]));
}

// remove header row from ds grid
remove_header_row(global.collectible_data,0);

#endregion

#region powerups

enum POWERUP_DATA {
	ID,					// number
	NAME,				// string
	DESC,				// string
	CATEGORY,			// string
	DROP_IMG_IDX,		// number
	EFFECT,				// function/number
}

// import item csv
global.powerup_data = load_csv("powerup_data.csv");
for (var _i = 1; _i < ds_grid_height(global.powerup_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.powerup_data,POWERUP_DATA.ID,_i,real(global.powerup_data[# POWERUP_DATA.ID,_i]));
	ds_grid_set(global.powerup_data,POWERUP_DATA.DROP_IMG_IDX,_i,real(global.powerup_data[# POWERUP_DATA.DROP_IMG_IDX,_i]));
	ds_grid_set(global.powerup_data,POWERUP_DATA.EFFECT,_i,real(global.powerup_data[# POWERUP_DATA.EFFECT,_i]));
}

// remove header row from ds grid
remove_header_row(global.powerup_data,0);

#endregion

#region items

// item data enum
enum ITEM_COLUMN {
	ID,					// use this to reference the item from the DB
	NAME,				// name that appears as text in the inventory
	DESCRIPTION,		// description shows up in the inventory 
	TYPE,				// this it the item type : weapon, collectible, consumable, ammo, powerup
	INV_SPR_IDX,		// sprite index of for the sprite shown in the inventory 
	INV_IMG_IDX,		// image index of the sprite shown in the inventory
	DMG_TYPE,			// see damage type enum for reference
	DMG_AMT,			// 
	KNOCKBACK,			// 
	WEP_START,			// sets the image index that the damage object will appear on during attack
	WEP_CD,				// sets the cooldown of the weapon after it gets used
	WEP_TYPE,			// sets the type. see WEP_TYPE enum for reference 
	DMG_OBJ_SPR,		// sets the sprite index of the damage object that is spawned
	ELEMENT_TYPE,		// sets the element of the weapon
	EFFECT,				// the special effect function for the weapon
}

// import item csv
global.item_data = load_csv("items_data.csv");
for (var _i = 1; _i < ds_grid_height(global.item_data); _i ++) {
	// convert all cells that must be numbers, from strings to numbers
	// because everything comes in as a string
	ds_grid_set(global.item_data,ITEM_COLUMN.ID,_i,real(global.item_data[# ITEM_COLUMN.ID,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.INV_IMG_IDX,_i,real(global.item_data[# ITEM_COLUMN.INV_IMG_IDX,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DMG_TYPE,_i,real(global.item_data[# ITEM_COLUMN.DMG_TYPE,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.DMG_AMT,_i,real(global.item_data[# ITEM_COLUMN.DMG_AMT,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.KNOCKBACK,_i,real(global.item_data[# ITEM_COLUMN.KNOCKBACK,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.WEP_START,_i,real(global.item_data[# ITEM_COLUMN.WEP_START,_i]));
	ds_grid_set(global.item_data,ITEM_COLUMN.WEP_CD,_i,real(global.item_data[# ITEM_COLUMN.WEP_CD,_i]));
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




