
// Inherit the parent event
event_inherited();


#region INIT PLAYER SET VARIABLES

/*
These variables are used inside functions for calculations or other purposes and 
do not need to be changed once set.

variables that need to be set an a per-player basis are all in the VARIABLE DEFINITIONS
*/

// Macro Stuff
faction				= FACTION.PLAYER;			// tells the game which faction the player belongs to
terrain_state		= TERRAIN.NONE				// saves the current terrain state of the player

// stats
hp						= max_hp;				// set hp to max hp
mp						= max_mp;				// set mp to max mp
armor					= max_armor;			// set armor to max armor
extra_damage_check		= noone;				// dictates any additional checks to be made before dealing damage to player

// movement & controls
face_direction		= 270;						// sets the current direction the player is facing
move_direction		= -1;						// used to control x/y_speed and helps set the players face direction
last_safe_x			= x;						// saves the last safe x-position the player was on for respawning
last_safe_y			= y;						// saves the last safe y-position the player was on for respawning

// inventory, items, abilities
item_id_used		= noone;					// stores the item id being used to pass into use_weapon/item/consumable functions
equip_slots			= [0,0,0];					// array for storying id of currently equipped items

#endregion

#region INIT PLAYER SPRITES

// Sprites
//sprite_idle_down = spr_player_idle_down;
//sprite_idle_right = spr_player_idle_right;
//sprite_idle_up = spr_player_idle_up;
//sprite_idle_left = spr_player_idle_left;

//sprite_move_down = spr_player_move_down;
//sprite_move_right = spr_player_move_right;
//sprite_move_up = spr_player_move_up;
//sprite_move_left = spr_player_move_left;

//sprite_atk_sword_down = spr_player_attack_sword_down;
//sprite_atk_sword_right = spr_player_attack_sword_right;
//sprite_atk_sword_up = spr_player_attack_sword_up;
//sprite_atk_sword_left = spr_player_attack_sword_left;

//sprite_atk_flail_down = 0;
//sprite_atk_flail_right = 0;
//sprite_atk_flail_up = 0;
//sprite_atk_flail_left = 0;

//sprite_atk_crossbow_down = 0;
//sprite_atk_crossbow_right = 0;
//sprite_atk_crossbow_up = 0;
//sprite_atk_crossbow_left = 0;

//sprite_atk_shield_down = 0;
//sprite_atk_shield_right = 0;
//sprite_atk_shield_up = 0;
//sprite_atk_shield_left = 0;

//sprite_atk_boomstick_down = 0;
//sprite_atk_boomstick_right = 0;
//sprite_atk_boomstick_up = 0;
//sprite_atk_boomstick_left = 0;

//sprite_atk_tomahawk_down = 0;
//sprite_atk_tomahawk_right = 0;
//sprite_atk_tomahawk_up = 0;
//sprite_atk_tomahawk_left = 0;

//sprite_run = spr_player2_run;
//sprite_walk = spr_player2_walk;
//sprite_jump = spr_player2_jump;
//sprite_fall = spr_player2_fall;
//sprite_hurt = spr_player2_hurt;
//sprite_climb = spr_player2_climb;
//sprite_pitfall = spr_player2_pitfall;
//sprite_drown = spr_player2_drown;
//sprite_attack = spr_player2_attack_sword;
//sprite_death = spr_player2_death;

#endregion

#region INIT PLAYER ALARMS

enum P_ALARM {
	DEATH,
	DAMAGED,
	ATK_START,
	ATK_END,
	COUNT,
}

#endregion

#region INIT PLAYER EQUIPMENT & INVENTORY

// enum sets the position for the 3 equip slots
enum EQUIP {
	B,
	X,
	Y,
}

/*
// will try to change the inventory into a struct using this
player_inventory = {
	equip_slots: [0,0,0],
	weapons: ds_grid_create(6,1),
	items: ds_grid_create(6,3),
	unique_right: ds_grid_create(1,4),
	unique_left: ds_grid_create(1,4),
	unique_bottom: ds_grid_create(6,1),
	shards: ds_grid_create(4,2),
}
*/

// initialize inventory DS Grids
weapons			= ds_grid_create(6,1);		// ds grid for the weapons part of the inventory
items			= ds_grid_create(6,3);		// ds grid for the items part of the inventory
unique_right	= ds_grid_create(1,4);		// ds grid for the right side of the unique items inventory
unique_left		= ds_grid_create(1,4);		// ds grid for the left side of the unique items inventory
unique_bottom	= ds_grid_create(6,1);		// ds grid for the bottom section of the uniqie items inventory
shards			= ds_grid_create(4,2);		// ds grid for the shards portion of the inventory

#endregion

#region INIT PLAYER HELPER FUNCTIONS

function player_set_last_safe_coordinates() {
	if (!on_ground) { exit; }
	if (tilemap_get_at_pixel(global.collision_map,x,y) != 0) { exit; }
	last_safe_x = xprevious;
	last_safe_y = yprevious;	
}

function player_knockback_check() {
	if (knockback_check() == true) {
		if (nest_state != nest_state_hurt) { nest_state = nest_state_hurt; }	
	} else {
		if (nest_state == nest_state_hurt) {
			show_debug_message("knockback > free");
			nest_state = nest_state_free;
		}
	}
}

function player_death_check() {
	if (nest_state = nest_state_hurt) { exit; }
	if (hp <= 0) {
		main_state = main_state_death;
		nest_state = nest_state_death_normal;
	}
}

function player_jump_check() {
	if (!on_ground && z_speed < 0) {
		if (nest_state != nest_state_jump) { nest_state = nest_state_jump; }
	}
}

function player_fall_check() {
	if (!on_ground && z_speed > 0) {
		if (nest_state != nest_state_fall) { nest_state = nest_state_fall; }	
	}
}

function player_on_ground_check() {
	if (nest_state != nest_state_fall) { exit; }
	if (on_ground) {
		if (nest_state != nest_state_free) { nest_state = nest_state_free; }	
	}
}

function player_respawn() {
	move_direction = -1;
	face_direction = 270;
	x = last_safe_x;
	y = last_safe_y;
	image_alpha = 1;
	alarm[P_ALARM.DAMAGED] = FPS*3;
	main_state = main_state_alive;
	nest_state = nest_state_free;
	terrain_state = TERRAIN.NONE;
	
}

function player_take_damage(_damage, _damage_type, _element_type, _special_effect) {
	if (just_got_damaged) { exit; }
	
	// check immunities
	if (damage_check_modifiers(_damage_type, _element_type, immune_array) == true) { _damage = 0; }
	
	// run extra damage check
	if (extra_damage_check) { script_execute(extra_damage_check); }
	
	// check resistances
	if (damage_check_modifiers(_damage_type, _element_type, resistance_array) == true) { _damage /= round(_damage*2); }
	
	// check vulnerabilities
	if (damage_check_modifiers(_damage_type, _element_type, vulnerable_array) == true) { _damage *= round(_damage*2); }
	
	// check armor
	_damage = damage_check_armor(_damage);
	
	// run special effect
	if (_special_effect) { script_execute(_special_effect); }
	
	// finalize damage
	if (_damage > 0) {
		hp -= _damage;
		just_got_damaged = true;
		item_id_used = noone;
		alarm[ALARM.ATK_START] = -1;		// cancels an attack if one was underway
		alarm[ALARM.DAMAGED] = FPS*0.5;
		nest_state = nest_state_hurt;
		
		// play damage sound
	} else {
		// play block/resist/immune sound	
	}
}

function player_use_equip_slot(_item_id) {
	// when an equip slot is used, figure out what category it is and proceed accordingly
	// - weapon
	// - item
	// - consumable

	if (!_item_id) { exit; }		// exit if no item is equipped
	
	// get item category
	var _item_category = ds_grid_get(global.item_data,ITEM_COLUMN.CATEGORY, _item_id);
	
	item_id_used = _item_id;
	
	switch(_item_category) {
		case "weapon":
			//nest_state = nest_state_weapon;
			player_use_weapon(_item_id);
		break;
		
		case "item":
			//nest_state = nest_state_item;
			player_use_item(_item_id);
		break;
		
		case "consumable":
			//nest_state = nest_state_consumable;
			player_use_consumable(_item_id);
		break;
	}
}

function player_use_weapon(_item_id) {
	// get weapon type
	var _weapon_type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE,_item_id);
	
	// set attack state according to weapon type
	switch (_weapon_type) {
		case "sword":		nest_state = nest_state_attack_sword;		break;
		case "shield":		nest_state = nest_state_attack_shield;		break;
		case "boomstick":	nest_state = nest_state_attack_boomstick;	break;
		case "flail":		nest_state = nest_state_attack_flail;		break;
		case "crossbow":	nest_state = nest_state_attack_crossbow;	break;
		case "tomahawk":	nest_state = nest_state_attack_tomahawk;	break;
	}
}

function player_use_item(_item_id) {
	
}

function player_use_consumable(_item_id) {
	
}

function player_create_damage_object(_item_id, _x_offset, _y_offset) {
	// get all needed data to pass to damage object
	var _faction = faction;
	var _creator = id;
	var _face_dir = face_direction;
	var _dmg_type = ds_grid_get(global.item_data, ITEM_COLUMN.DAMAGE_TYPE, _item_id);
	var _element_type = ds_grid_get(global.item_data, ITEM_COLUMN.ELEMENT_TYPE, _item_id);
	var _dmg_amt = ds_grid_get(global.item_data, ITEM_COLUMN.DAMAGE, _item_id);
	var _knockback =  ds_grid_get(global.item_data, ITEM_COLUMN.KNOCKBACK, _item_id);
	var _special_effect = ds_grid_get(global.item_data, ITEM_COLUMN.EFFECT, _item_id);
	
	// determine which damage object to create
	var _wep_type = ds_grid_get(global.item_data, ITEM_COLUMN.WEAPON_TYPE, _item_id);
	_wep_type = asset_get_index("obj_damage_" + string(_wep_type));
	
	// get the sprite to set for the damage object
	var _sprite = ds_grid_get(global.item_data, ITEM_COLUMN.DAMAGE_SPRITE, _item_id);
	_sprite = asset_get_index(_sprite);
	if (!_sprite) { _sprite = asset_get_index("spr_damage_melee"); }
	
	
	// create the damage object
	instance_create_layer(x + _x_offset, y + _y_offset, INSTANCE_LAYER, _wep_type, {
		faction: _faction,
		creator: _creator,
		image_angle: _face_dir,
		sprite_index: _sprite,
		damage_type: _dmg_type,
		element_type: _element_type,
		damage: _dmg_amt,
		knockback_amount: _knockback,
		special_effect: _special_effect,
	});
}

function player_terrain_checks(){

	var _terrain = tilemap_get_at_pixel(global.collision_map,x,y);

	// Shallow Water
	if (_terrain == 2) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN.SHALLOW_WATER) { terrain_state = TERRAIN.SHALLOW_WATER; }
		if (max_speed != wade_speed) { max_speed = wade_speed; }
	} else { 
		if (terrain_state == TERRAIN.SHALLOW_WATER) { terrain_state = TERRAIN.NONE } 
	}
	
	// Deep Water
	if (_terrain == 3) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN.DEEP_WATER) { terrain_state = TERRAIN.DEEP_WATER; }
		player_take_damage(1);
		main_state = main_state_death;
		nest_state = nest_state_death_drown;
	}
	
	// ladder
	if (_terrain == 4) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN.LADDER) { terrain_state = TERRAIN.LADDER; }
		if (nest_state != nest_state_climb) { nest_state = nest_state_climb; }
	} else {
		if (terrain_state == TERRAIN.LADDER) { terrain_state = TERRAIN.NONE }
		if (nest_state == nest_state_climb) { nest_state = nest_state_free; }
	}
	
	// Tall Grass
	if (_terrain == 5) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN.TALL_GRASS) { terrain_state = TERRAIN.TALL_GRASS; }
		if (max_speed != wade_speed) { max_speed = wade_speed; }
	} else { 
		if (terrain_state == TERRAIN.TALL_GRASS) { terrain_state = TERRAIN.NONE } 
	}

	// PitFall
	if (_terrain == 6) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN.PITFALL) { terrain_state = TERRAIN.PITFALL; }
		if (main_state == main_state_death) { exit; }
		player_take_damage(1);
		main_state = main_state_death;
		nest_state = nest_state_death_pitfall;
	}
	
	// Pitfall edges
	if (_terrain == 12) {
		if (!on_ground) { exit; }
		x_speed += .1;
	}
	if (_terrain == 13) {
		if (!on_ground) { exit; }
		x_speed -= .1;
	}
	if (_terrain  == 14) {
		if (!on_ground) { exit; }
		y_speed += .1;
	}
	if (_terrain == 15) {
		if (!on_ground) { exit; }
		y_speed -= .1;
	}
	if (_terrain == 16) {
		if (!on_ground) { exit; }
		x_speed -= .1;
		y_speed -= .1;
	}
	if (_terrain == 17) {
		if (!on_ground) { exit; }
		x_speed -= .1;
		y_speed += .1;
	}
	if (_terrain == 18) {
		if (!on_ground) { exit; }
		x_speed += .1;
		y_speed += .1;
	}
	if (_terrain == 19) {
		if (!on_ground) { exit; }
		x_speed += .1;
		y_speed -= .1;
	}
}

#endregion

#region INIT PLAYER STATES

// main states
main_state_alive = function(){
	player_update_x_speed();				// set x speed
	player_update_y_speed();				// set y speed
	player_update_move_direction();			// set move direction
	player_update_face_direction();			// set face direction
	player_input_b_check();					// check B input
	player_input_x_check();					// check X input
	player_input_y_check();					// check Y input
	player_input_jump_check();				// check jump input
	knockback_update();						// update knockback
}

main_state_death = function() {
	
	// begin death
	if (alarm[P_ALARM.DEATH] == -1) {
		if (knockback_x != 0) knockback_x = 0;
		if (knockback_y != 0) knockback_y = 0;
		if (x_speed != 0) x_speed = 0;
		if (y_speed != 0) y_speed = 0;
		image_index = 0;
		image_speed = 1;
		alarm[P_ALARM.DEATH] = FPS * 3; 
	}
	
	// during death
	if (P_ALARM.DEATH >= 0) {
		// stop animation at end
		if (image_index >= image_number-1) {
			image_speed = 0;
			image_index = image_number-1;
		}
	}
	
	// end death
	if (alarm[P_ALARM.DEATH] == 0) {
		if (hp <= 0) {
			// GAME OVER SEQUENCE
			game_restart();	
		} else {
			player_respawn();
		}
	}
}

// nest states
nest_state_free = function() {
	// set sprite to either moving or idle
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
	} else { 
		if (image_speed != 0) { image_speed = 0; }
	}
}

nest_state_attack_sword = function() {

	// begin attack
	if (alarm[P_ALARM.ATK_START] == -1 && alarm[P_ALARM.ATK_END] == -1) {
		x_speed = 0;
		y_speed = 0;
		// get weapon type
		var _weapon_type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE, item_id_used);
		image_index = 0;
		image_speed = 1;
		alarm[P_ALARM.ATK_START] = -2;
	}
	
	// during attack
	if (alarm[P_ALARM.ATK_START] == -2) {
		if (image_index >= 3) {
			var _x_offset = 0;
			var _y_offset = 0;
			if (face_direction == 0) _x_offset = 8;
			if (face_direction == 90) _y_offset = -10;
			if (face_direction == 180) _x_offset = -8;
			if (face_direction == 270) _y_offset = 2;
			player_create_damage_object(item_id_used, _x_offset, _y_offset);
			alarm[P_ALARM.ATK_START] = -3;
		}
	}
	
	// end attack
	if (alarm[P_ALARM.ATK_START] == -3) {
		if (image_index >= image_number-1) {
			nest_state = nest_state_free;
			alarm[P_ALARM.ATK_START] = -1;
			alarm[P_ALARM.ATK_END] = FPS * .1;
			item_id_used = noone;
		}
	}
}

nest_state_attack_shield = function() {
	
}

nest_state_attack_boomstick = function() {
	
}

nest_state_attack_flail = function() {
	
}

nest_state_attack_crossbow = function() {
	
}

nest_state_attack_tomahawk = function() {
	
}

nest_state_item = function() {
	
}

nest_state_consumable = function() {
	
}

nest_state_hurt = function() {

}

nest_state_talk = function() {
	
}

nest_state_shop = function() {
	
}

nest_state_climb = function() {
	// set sprite to either moving or idle
	if (x_speed != 0 || y_speed != 0) {
		if (image_speed != 1) { image_speed = 1; }
	} else { 
		if (image_speed != 0) { image_speed = 0; }
	}
}

nest_state_carry = function() {
	
}

nest_state_push = function() {
	
}

nest_state_pull = function() {
	
}

nest_state_jump = function() {

}

nest_state_fall = function() {

}

nest_state_death_normal = function() {

}

nest_state_death_drown = function() {

}

nest_state_death_pitfall = function() {

}


/*
function player_state_attack_crossbow() {
	// begin attack
	if (alarm[P_ALARM.ATK_START] == -1 && alarm[P_ALARM.ATK_END] == -1 && alarm[P_ALARM.DAMAGED] == -1) {
		image_index = 0;
		x_speed = 0;
		y_speed = 0;
		// get weapon type
		var _weapon_type = ds_grid_get(global.item_data,ITEM_COLUMN.WEAPON_TYPE, equip_slot_used);
		player_image_attack(_weapon_type);
		alarm[P_ALARM.ATK_START] = -2;
	}
	
	// during attack
	
	
	// end attack
	
}
*/

#endregion

#region INIT PLAYER STARTING STATES

main_state = main_state_alive;
nest_state = nest_state_free

#endregion;