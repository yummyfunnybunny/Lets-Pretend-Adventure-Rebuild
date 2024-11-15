event_inherited();

#region SET VARIABLES

faction					= FACTION_TYPE.NPC;		// set the faction of the instance
hp						= max_hp;				// set hp to max hp
mp						= max_mp;				// set mp to max mp
armor					= max_armor;			// set armor to max armor
move_speed				= 0;					// set max move speed
target					= noone;				// id of current target to chase/attack
align_x					= 0;					// sets x-position to for aligning a certain way to target for attacks
align_y					= 0;					// sets y-position for aligning a certain way to target for attacks
extra_damage_check		= noone;				// use this to store a function to perform additional checks for unique enemies when taking damage
interact_target			= noone;				// sets the id of the player the npc is set to interact with when player presses A
interact_prev_state		= noone;				// stores the state npc was in before interaction, to back to, once interaction ends


// quest
quest = noone;
//quest = {
//	// if npc is related to a quest, store the quest data here for them to use
//	quest_id: noone,				// stores the quest id
//	stage: QUEST_STAGE.UNAVAILABLE,	// stores the stage of the quest
//	update_script: noone,			// use this to run whatever updating function the quest system provides it with
//	start_object: noone,			// stores the object that starts the quest
//	end_object: noone,				// stores the object that ends the quest
//	follow_target: noone,
//}

// dialogue
dialogue = {
	textbox_id: noone,				//stores the id of the current textbox object
	title: "textbox title",			// title displayed in textbox
	//quest_id: 0,					// stores the id of the quest this NPC connects to. 0 = no quest
	//stage: QUEST_STAGE.UNAVAILABLE,	// stores the current stage of the quest
	text: [
		[
			// stage 0: quest = inactive, prerequisites = incomplete
			"stage 0 - text 1",
			"stage 0 - text 2",
			"stage 0 - text 3",
		],
		[
			// stage 1: - quest = inactive, prerequisites = complete || 0
			"stage 1 - text 1",
			"stage 1 - text 2",
			"stage 1 - text 3",
		],
		[
			// stage 2: quest = active, tasks = incomplete
			"stage 2 - text 1",
			"stage 2 - text 2",
			"stage 2 - text 3",
		],
		[
			// stage 3: quest = active, teasks = complete
			"stage 3 - text 1",
			"stage 3 - text 2",
			"stage 3 - text 3",
		],
		[
			// stage 4: quest = completed
			"stage 4 - text 1",
			"stage 4 - text 2",
			"stage 4 - text 3",
		],
	]
}

dialogue2 = {
	textbox_id: noone,
	title: "textbox title",
	quest_id: 0,
	stage: QUEST_STAGE.UNAVAILABLE,
	text: [
		{
			quest_id: 0,
			quest_stage: QUEST_STAGE.UNAVAILABLE,
			quest_text: [
				["","",""],
				["","",""],
				["","",""],
			]
		},
		{
			quest_id: 1,
			quest_stage: QUEST_STAGE.UNAVAILABLE,
			quest_text: [
				["","",""],
				["","",""],
				["","",""],
			]
		}
	]
}

#endregion

#region ALARMS

enum NPC_ALARM {
	DEATH,
	STATE,
	DAMAGED,
	ATK_START,
	ATK_END,
	INTERACT,
	COUNT,
}

#endregion


#region DEFAULT STATES

// main states
main_state_unaware = function() {
	npc_aggro_range_check();
	npc_origin_distance_check();
	npc_follow_reset_check();
}
main_state_aware = function() {
	npc_attack_range_check();
	npc_origin_distance_check();
}
main_state_death = function() {
	
	// begin death - start death timer
	if (alarm[NPC_ALARM.DEATH] == -1) {
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
		alarm[NPC_ALARM.DEATH] = FPS * 4;
	}
	
	// during death - fade out with 1 second left
	if (alarm[NPC_ALARM.DEATH] <= FPS* 1) {
		image_alpha = ((alarm[NPC_ALARM.DEATH]*100)/60)/100;
	}
	
	// end death - destroy npc
	if (alarm[NPC_ALARM.DEATH] == 0) {
		instance_destroy();
	}
}

// unaware states
nest_state_idle = function() {
	
	// begin idle
	if (alarm[NPC_ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[NPC_ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[NPC_ALARM.STATE] == 0) {
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}
nest_state_wander = function() {
	
	// begin wander
	if (alarm[NPC_ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		alarm[NPC_ALARM.STATE] = FPS * 2;
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
	}
	
	// TODO - avoid water, pitfalls, and walls
	
	// end wander
	if (alarm[NPC_ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}
nest_state_patrol = function() {

	// begin patrol - create pather
	if (alarm[NPC_ALARM.STATE] == -1) {
		if (!pather_object) {
			pather_object = instance_create_depth(x,y,INSTANCE_DEPTH,obj_con_pather,{
				creator: id,
				path: patrol_path,
				move_speed: walk_speed,
				target_x: origin_x,
				target_y: origin_y,
				path_end_action: patrol_end_action,
				
			});
		}
		alarm[NPC_ALARM.STATE] = -2;
	}
	
	// during patrol - follow pather
	if (alarm[NPC_ALARM.STATE] == -2) {
		if (pather_object) {
			if (move_speed != walk_speed) { move_speed = walk_speed; }
			direction = point_direction(x,y,pather_object.x,pather_object.y);
		}
	}
	
	// end patrol
	if (alarm[NPC_ALARM.STATE] == -2) {
		if (point_distance(x,y,origin_x,origin_y) <= COL_TILES_SIZE) {
			//instance_destroy(pather_object);
			//pather_object = noone;
			//main_state = main_state_unaware;
			//nest_state = nest_state_wait;
			alarm[NPC_ALARM.STATE] = -1;
		}
	}
}
nest_state_follow = function() {
	if (!quest.follow_target) { exit; }
	// begin follow
	if (alarm[NPC_ALARM.STATE] == -1) {
		direction = point_direction(x,y,quest.follow_target.x,quest.follow_target.y);
		alarm[NPC_ALARM.STATE] = -2;
	}
	
	// during follow
	if (alarm[NPC_ALARM.STATE] == -2) {
		
		var _dis = point_distance(x,y,quest.follow_target.x,quest.follow_target.y);
		if (_dis > 2*COL_TILES_SIZE) {
			if (move_speed != run_speed) { move_speed = run_speed; }
			if (sprite_index != sprite_move) { sprite_index = sprite_move; }
			direction = point_direction(x,y,quest.follow_target.x,quest.follow_target.y);
		} else {
			if (move_speed != 0) { move_speed = 0; }
			if (sprite_index != sprite_idle) { sprite_index = sprite_idle; }
		}
		
	}
	
	// stop when close to player
}
nest_state_sleep = function() {}
nest_state_return_origin = function() {
	// create pather
	if (!pather_object) {
		pather_object = instance_create_layer(x,y,INSTANCES_1_LAYER,obj_con_pather,{
			creator: id,
			path: noone,
			move_speed: run_speed,
			target_x: origin_x,
			target_y: origin_y,
			path_end_action: path_action_stop,
		});
	}
	
	// follow pather
	if (pather_object) {
		if (move_speed != run_speed) { move_speed = run_speed; }
		direction = point_direction(x,y,pather_object.x,pather_object.y);
	}
	
	// end once origin is reached
	if (point_distance(x,y,origin_x,origin_y) <= COL_TILES_SIZE) {
		alarm[NPC_ALARM.STATE] = -1;
		quest.update_script = npc_quest_follow_start_check;
		instance_destroy(pather_object);
		pather_object = noone;
		main_state = main_state_unaware;
		nest_state = nest_state_wait;
	}
}
nest_state_interact = function() {
	// stop npc movement
	if (move_speed != 0) { move_speed = 0; }
	
	// face the player
	npc_interact_face_target();
	
	// figure out what type of interaction to run
	switch(interact_type) {
		case INTERACT_TYPE.TALK: npc_interact_talk();	break;
		case INTERACT_TYPE.SHOP: npc_interact_shop();	break;
	}
}



// aware states
nest_state_chase = function() {}
nest_state_align = function() {}
nest_state_flee = function() {}
nest_state_attack = function() {}

// death states
nest_state_death_normal = function() {}
nest_state_death_drown = function() {}
nest_state_death_pitfall = function() {}

// wild-card states
nest_state_wait = function() {
	
	// begin idle
	if (alarm[NPC_ALARM.STATE] == -1) {
		if (image_speed != 1) image_speed = 1;
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[NPC_ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[NPC_ALARM.STATE] == 0) {
		main_state = main_state_unaware;
		nest_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	}
}
nest_state_hurt = function() {}
nest_state_react = function() {}

#endregion

#region DEFAULT HELPER FUNCTIONS

function npc_set_enemy_target() {
	if (!instance_exists(target)) {
		if (instance_exists(obj_parent_enemy)){
			target = instance_nearest(x,y,obj_parent_enemy);	
		} else if (target != noone) {
			target = noone;
		}
	}
	
	if (instance_exists(target)) {
		if (target.main_state == obj_parent_enemy.main_state_death) {
			if (target != noone) {
				target = noone;	
			}
		}
	}
}

function npc_death_check() {
	if (nest_state == nest_state_hurt) { exit; }
	if (main_state == main_state_death) { exit; }
	if (hp <= 0) {
		main_state = main_state_death;
		nest_state = nest_state_death_normal;
	}
}

function npc_update_movement() {
	if (knockback_check()) { exit; }
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
}

function npc_take_damage(_damage, _damage_type, _element_type, _special_effect) {
	if (just_got_damaged) { exit; }
	
	// check immunities
	if (damage_check_modifiers(_damage_type, _element_type, damage_immunities, element_immunities) == true) { _damage = 0; }
	
	// run extra damage check
	if (extra_damage_check) { script_execute(extra_damage_check); }
	
	// check resistances
	if (damage_check_modifiers(_damage_type, _element_type, damage_resistances, element_resistances) == true) { _damage /= round(_damage*2); }
	
	// check vulnerabilities
	if (damage_check_modifiers(_damage_type, _element_type, damage_vulnerabilities, element_vulnerabilities) == true) { _damage *= round(_damage*2); }
	
	// check armor
	_damage = damage_check_armor(_damage);
	
	// run special effect
	if (_special_effect) { script_execute(_special_effect); }
	
	// finalize damage
	if (_damage > 0) {
		hp -= _damage;
		just_got_damaged = true;
		alarm[NPC_ALARM.ATK_START] = -1;		// cancels an attack if one was underway
		alarm[NPC_ALARM.DAMAGED] = FPS*0.5;
		//alarm[ALARM.STATE] = 1;
		nest_state = nest_state_hurt;
		
		// play damage sound
	} else {
		// play block/resist/immune sound	
	}
	
}

function npc_aggro_range_check(_main_state = main_state_aware,_nest_state = nest_state_chase){
	if (target == noone) exit;
	if (nest_state = nest_state_return_origin) { exit; }
	if (nest_state = nest_state_wait) { exit; }
	if (point_distance(x,y,target.x,target.y) <= aggro_range*COL_TILES_SIZE) {
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function npc_origin_distance_check(_main_state = main_state_unaware, _nest_state = nest_state_return_origin) {
	if (nest_state == nest_state_return_origin) { exit; }
	if (nest_state == nest_state_patrol) { exit; }
	if (nest_state == nest_state_wait) { exit; }
	if (nest_state == nest_state_interact) { exit; }
	if (origin_range == 0) { exit; }
	if (point_distance(x,y,origin_x,origin_y) >= origin_range*COL_TILES_SIZE) {
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function npc_follow_reset_check(_main_state = main_state_unaware, _nest_state = nest_state_return_origin) {
	if (nest_state != nest_state_follow) { exit; }
	if (follow_reset_range == 0) { exit; }
	var _following = quest.follow_target;
	var _dis = point_distance(x,y,_following.x, _following.y);
	if (_dis >= follow_reset_range*COL_TILES_SIZE) {
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function npc_attack_range_check(_main_state = main_state_aware, _nest_state = nest_state_attack) {
	if (target == noone) { exit; }
	if (nest_state == nest_state_sleep) { exit; }
	if (nest_state = nest_state_return_origin) { exit; }
	if (nest_state = nest_state_wait) { exit; }
	var _dis = point_distance(x,y,target.x,target.y);
	if (_dis <= attack_range*COL_TILES_SIZE) { 
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

// Terrain Functions
function npc_update_terrain_state(){

	var _terrain = tilemap_get_at_pixel(global.collision_map,x,y);

	// Shallow Water
	if (_terrain == 2) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.SHALLOW_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.NONE }
		
	}
	
	// Deep Water
	if (_terrain == 3) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.DEEP_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.NONE } 
		
	}
	
	// ladder
	if (_terrain == 4) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.LADDER; }
	} else {
		if (terrain_state == TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.NONE }
		
	}
	
	// Tall Grass
	if (_terrain == 5) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.TALL_GRASS; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.NONE } 
		
	}

	// PitFall
	if (_terrain == 6) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.PITFALL; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.NONE }
		
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

function npc_terrain_effect() {
	switch (terrain_state) {
		case TERRAIN_TYPE.SHALLOW_WATER: npc_terrain_shallow_water();	break;
		case TERRAIN_TYPE.DEEP_WATER:	npc_terrain_deep_water();		break;
		case TERRAIN_TYPE.LADDER:		npc_terrain_ladder();			break;
		case TERRAIN_TYPE.TALL_GRASS:	npc_terrain_tall_grass();		break;
		case TERRAIN_TYPE.PITFALL:		npc_terrain_pitfall();			break;
		default: /* nothing */										break;
	}
}

npc_terrain_shallow_water = function(){
	main_state = main_state_death;
	nest_state = nest_state_death_drown;
}

npc_terrain_deep_water = function(){
	main_state = main_state_death;
	nest_state = nest_state_death_drown;
}

npc_terrain_ladder = function(){}

npc_terrain_tall_grass = function(){}

npc_terrain_pitfall = function(){
	main_state = main_state_death;
	nest_state = nest_state_death_pitfall;
}

// Interact Functions
function npc_interact_set_target() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (!instance_exists(interact_target)) {
		if (instance_exists(obj_parent_player)){
			interact_target = instance_nearest(x,y,obj_parent_player);	
		} else if (interact_target != noone) {
			interact_target = noone;
		}
	}
	
	if (instance_exists(interact_target)) {
		if (interact_target.main_state == obj_parent_player.main_state_death) {
			if (interact_target != noone) { interact_target = noone; }
		}
	}
}

function npc_interact_check_interact_range() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.layer != layer) { exit; }
	var _dis = point_distance(x,y,interact_target.x,interact_target.y);
	if (_dis <= interact_range*COL_TILES_SIZE) {
		interact_target.interact_target = id;
	} else {
		if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
	}
}

function npc_interact_draw_icon() {
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.interact_target != id) { exit; }
	if (nest_state == nest_state_interact) { exit; }
	if (alarm[NPC_ALARM.INTERACT] != -1) { exit; }
	
	switch(interact_type) {
		case INTERACT_TYPE.TALK: draw_sprite(spr_interact_talk,-1,x,y-z_height);	break;
	}
}

function npc_interact_talk() {
	// create textbox object
	if (dialogue.textbox_id == noone) {
		dialogue.textbox_id = instance_create_layer(x,y,CONTROLLER_LAYER,obj_con_textbox, {
			creator: id,
			text_to_display: dialogue.text[quest.stage],
			textbox_title: dialogue.title,
		});
	}
	
	// end talking if out of range
	if (!interact_target.interact_target) {
		npc_interact_end_talk();
	}
}

function npc_interact_shop() {}

function npc_interact_face_target() {
	var _x_diff = x-interact_target.x;
	if (sign(_x_diff) == -1) { direction = 0; } else { direction = 180; }
}

function npc_interact_input_progression() {
	// this function takes in the input from the player and progresses the interaction	
	if (alarm[NPC_ALARM.INTERACT] != -1) { exit; }
	
	// enter nest_state_interact if not in it
	if (nest_state != nest_state_interact) { 
		interact_prev_state = nest_state;
		nest_state = nest_state_interact; 
	} else {
		
		switch (interact_type) {
			case INTERACT_TYPE.TALK:
				var _tb = dialogue.textbox_id;	// store the id of the textbox
				if (_tb.main_state != _tb.main_state_display_text) { exit; }

				// end conversation once all text has been displayed
				if (_tb.text_count == string_length(_tb.text_to_display[_tb.page]) && _tb.page == array_length(_tb.text_to_display)-1) {
					npc_interact_end_talk();
				
				// go to next text page
				} else if (_tb.text_count == string_length(_tb.text_to_display[_tb.page])) {
					_tb.page++;
					_tb.text_count = 0;
				
				// instantly display current text page
				} else if (_tb.text_count < string_length(_tb.text_to_display[_tb.page])) {
					_tb.text_count = string_length(_tb.text_to_display[_tb.page]);	
				}
				
			break;
			
			case INTERACT_TYPE.SHOP:
			
			break;
		}
	}	
}

function npc_interact_end_talk() {
	
	//destroy textbox and reset dialoge
	if (instance_exists(dialogue.textbox_id)) { 
		dialogue.textbox_id.main_state = dialogue.textbox_id.main_state_despawn;
	}
	dialogue.textbox_id = noone;
	nest_state = interact_prev_state;
	interact_prev_state = noone;
	alarm[NPC_ALARM.INTERACT] = FPS*1;
}

// quest helpers
npc_quest_follow_start_check = function() {
	if (nest_state == nest_state_idle) {
		var _dis = point_distance(x,y,obj_player.x,obj_player.y);
		if (_dis < 2*COL_TILES_SIZE) {
			quest.follow_target = obj_player;
			nest_state = nest_state_follow;
			quest.update_script = npc_quest_follow_end_check;
		}
	}
}

npc_quest_follow_end_check = function() {
	if (nest_state != nest_state_follow) { exit; }
	if (quest.follow_target == quest.end_object) { exit; }
	if (instance_exists(obj_con_textbox)) { exit; }
	
	if (!quest.end_object) { exit; }
	var _dis = point_distance(x,y,quest.end_object.x, quest.end_object.y);
	if (_dis <= 2*COL_TILES_SIZE) {
		// start following the end object
		quest.follow_target = quest.end_object;
		follow_reset_range = 0;
		
		// send broadcast
		var _broadcast = new EndFollowBroadcast(object_index);
		array_push(global.quest_tracker.broadcast_receiver, _broadcast);
	}
}

#endregion

#region SET STARTING STATES

main_state = main_state_unaware;
nest_state = nest_state_idle;

#endregion