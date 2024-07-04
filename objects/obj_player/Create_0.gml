// == _initialize == 
event_inherited();

#region CALCULATION VARIABLES

faction = FACTION.PLAYER;
state = player_state_free;
face_direction = 270;
move_direction = -1;
last_safe_x = x;
last_safe_y = y;
item_id_used = noone;
equip_slot_used = noone;
disable_input = false;

// set sprites
sprite_idle_down = spr_player_idle_down;
sprite_idle_right = spr_player_idle_right;
sprite_idle_up = spr_player_idle_up;
sprite_idle_left = spr_player_idle_left;

sprite_move_down = spr_player_move_down;
sprite_move_right = spr_player_move_right;
sprite_move_up = spr_player_move_up;
sprite_move_left = spr_player_move_left;

sprite_atk_sword_down = spr_player_atk_sword_down;
sprite_atk_sword_right = spr_player_atk_sword_right;
sprite_atk_sword_up = spr_player_atk_sword_up;
sprite_atk_sword_left = spr_player_atk_sword_left;

sprite_atk_flail_down = 0;
sprite_atk_flail_right = 0;
sprite_atk_flail_up = 0;
sprite_atk_flail_left = 0;

sprite_atk_crossbow_down = 0;
sprite_atk_crossbow_right = 0;
sprite_atk_crossbow_up = 0;
sprite_atk_crossbow_left = 0;

sprite_atk_shield_down = 0;
sprite_atk_shield_right = 0;
sprite_atk_shield_up = 0;
sprite_atk_shield_left = 0;

sprite_atk_boomstick_down = 0;
sprite_atk_boomstick_right = 0;
sprite_atk_boomstick_up = 0;
sprite_atk_boomstick_left = 0;

sprite_atk_tomahawk_down = 0;
sprite_atk_tomahawk_right = 0;
sprite_atk_tomahawk_up = 0;
sprite_atk_tomahawk_left = 0;

// Alarms
// Alarms
enum P_ALARM {
	DEATH,
	DAMAGED,
	ATK_START,
	ATK_END,
	COUNT,
}

sprite_run = spr_player2_run;
sprite_walk = spr_player2_walk;
sprite_jump = spr_player2_jump;
sprite_fall = spr_player2_fall;
sprite_hurt = spr_player2_hurt;
sprite_climb = spr_player2_climb;
sprite_pitfall = spr_player2_pitfall;
sprite_drown = spr_player2_drown;
sprite_attack = spr_player2_attack_sword;
sprite_death = spr_player2_death;

// equipped items
equipped_items = [0,0,0];

enum EQUIP {
	B,
	Y,
	X,
}

// initialize inventory DS Grids
weapons = ds_grid_create(6,1);
items = ds_grid_create(6,3);
unique_right = ds_grid_create(1,4);
unique_left = ds_grid_create(1,4);
unique_bottom = ds_grid_create(6,1);
shards = ds_grid_create(4,2);

// add some items!!
ds_grid_set(items,0,0,7);
ds_grid_set(items,1,0,8);
ds_grid_set(items,2,0,9);
ds_grid_set(items,3,0,10);
ds_grid_set(items,4,0,11);
ds_grid_set(items,5,0,12);
ds_grid_set(items,0,1,13);
ds_grid_set(items,1,1,14);
ds_grid_set(items,2,1,15);

ds_grid_set(weapons,0,0,1);
ds_grid_set(weapons,1,0,2);
ds_grid_set(weapons,2,0,3);
ds_grid_set(weapons,3,0,4);
ds_grid_set(weapons,4,0,5);
ds_grid_set(weapons,5,0,6);

#endregion

#region FUNCTIONS



#endregion




