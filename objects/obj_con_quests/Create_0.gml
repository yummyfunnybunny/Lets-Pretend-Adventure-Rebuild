
#region SET VARIABLES

eradicate_room_cleared = false;			// sets to false on room start - gets set to true once room is designated as cleared so we only run our room clear check once


// create global quest tracker struct
// store all quests from the DB as their own objects in this array
quests = [
	//{
	//	quest_id: 0,
	//	active: false,
	//	completed: false,
	//	name: ds_grid_get(global.quest_data, QUEST_DATA.NAME, _i),
	//	type: ds_grid_get(global.quest_data, QUEST_DATA.TYPE, _i),
	//	track_id: ds_grid_get(global.quest_data, QUEST_DATA.TRACK_ID, _i),
	//	track_qty: ds_grid_get(global.quest_data, QUEST_DATA.TRACK_QTY, _i),
	//	progress_qty: [0],
	//	reward: [
	//		{category: 1, item_id: 1, qty: 1},
	//		{category: 2, item_id: 2, qty: 1},
	//	],	
	//},
]

// fill the quests array
for (var _i = 0; _i < ds_grid_height(global.quest_data); _i++) {
	
	// set active
	var _active = ds_grid_get(global.quest_data, QUEST_DATA.ACTIVE, _i);
	switch (_active) {
		case "FALSE":	_active = false;	break;	
		case "TRUE":	_active = true;		break;	
	}
	
	// set stage
	var _stage = 0;
	var _prereqs = ds_grid_get(global.quest_data, QUEST_DATA.PREREQS, _i);
	
	// if the quest does not have any pre-requisites, set stage to 1
	if (_prereqs[0] == 0) {
		_stage = 1;
	}
	
	// set quest type
	var _quest_type = ds_grid_get(global.quest_data, QUEST_DATA.TYPE, _i);
	switch (_quest_type) {
		case "talk":		_quest_type = QUEST_TYPE.TALK;			break;	
		case "dispatch":	_quest_type = QUEST_TYPE.DISPATCH;		break;	
		case "eradicate":	_quest_type = QUEST_TYPE.ERADICATE;		break;	
		case "gather":		_quest_type = QUEST_TYPE.GATHER;		break;	
		case "discover":	_quest_type = QUEST_TYPE.DISCOVER;		break;	
		case "defend":		_quest_type = QUEST_TYPE.DEFEND;		break;	
		case "escort":		_quest_type = QUEST_TYPE.ESCORT;		break;
	}
	
	// set progress quantity
	var _progress_qty = [];
	repeat(array_length(ds_grid_get(global.quest_data, QUEST_DATA.TRACK_QTY, _i))) {
		array_push(_progress_qty, 0);
	}
	
	// set rewards
	var _rewards = [];
	var _all_rewards = string_split(ds_grid_get(global.quest_data,QUEST_DATA.REWARD, _i),",");
	//show_debug_message($"_all_rewards: {_all_rewards}");
	for (var _j = 0; _j < array_length(_all_rewards); _j++) {
		var _one_reward = string_split(_all_rewards[_j],"-");
		//show_debug_message($"_one_reward: {_one_reward}");
		var _reward = {
			category: _one_reward[0],
			item_id: real(_one_reward[1]),
			qty: real(_one_reward[2]),
		}
		array_push(_rewards,_reward);
	}
	//show_debug_message($"_rewards: {_rewards}");
	
	// start type
	var _start_type = ds_grid_get(global.quest_data, QUEST_DATA.START_TYPE, _i);
	switch (_start_type) {
		case "npc":		_start_type = QUEST_START.NPC;			break;	
		case "room":	_start_type = QUEST_START.ROOM;			break;	
		case "trigger":	_start_type = QUEST_START.TRIGGER;		break;	
		case "kill":	_start_type = QUEST_START.KILL;			break;	
		case "item":	_start_type = QUEST_START.ITEM;			break;	
	}
	
	// set start
	var _quest_start = ds_grid_get(global.quest_data,QUEST_DATA.START, _i);
	_quest_start = asset_get_index($"obj_npc_{_quest_start}");
	
	// set end
	var _quest_end = ds_grid_get(global.quest_data,QUEST_DATA.END, _i);
	_quest_end = asset_get_index($"obj_npc_{_quest_end}");
	
	// create the quest object
	var _quest = {
		quest_id: _i,
		active: _active,
		completed: false,
		prerequisites: _prereqs, 
		stage: _stage,
		name: ds_grid_get(global.quest_data, QUEST_DATA.NAME, _i),
		type: _quest_type,
		track_id: ds_grid_get(global.quest_data, QUEST_DATA.TRACK_ID, _i),
		track_qty: ds_grid_get(global.quest_data, QUEST_DATA.TRACK_QTY, _i),
		progress_qty: _progress_qty,
		reward: _rewards,
		start_type: _start_type,
		quest_start: _quest_start,
		quest_end: _quest_end,
	}
	
	// push the created quest object to the quest array
	array_push(quests, _quest);
}

//show_debug_message($"quests: {quests}");

#endregion

#region ALARMS



#endregion

#region STATES



#endregion

#region HELPER FUNCTIONS



function quest_check_npc_interact_end() {
	// checks if there is a textbox in despawn state - if so, get its creator info and check for a possible
	// progression with a quest
	if (!instance_exists(obj_con_textbox)) { exit; }
	if (obj_con_textbox.main_state == obj_con_textbox.main_state_despawn) {
		var _npc = obj_con_textbox.creator;
		var _quest_id = _npc.dialogue.quest_id;
		var _stage = _npc.dialogue.stage;
		
		// check for an inactive quest that we can start
		if (quests[_quest_id].active == false && quests[_quest_id].stage == 1) {
			quests[_quest_id].active = true;
			quests[_quest_id].stage++;
			_npc.dialogue.stage++;
		}
		
		// check for an active quest that we can complete
		if (quests[_quest_id].active == true && quests[_quest_id].stage == 3) {
			quests[_quest_id].completed = true;
			quests[_quest_id].stage++;
			_npc.dialogue.stage++;
			// call reward function here?
			quest_complete(_quest_id, _npc);
		}
	}
}

function quest_complete(_quest_id, _npc) {
	// provide reward
	for (var _i = 0; _i < array_length(quests[_quest_id].reward); _i++) {
		repeat(quests[_quest_id].reward[_i].qty) {
			var _item = instance_create_layer(_npc.x,_npc.y,INSTANCE_LAYER,obj_parent_item, {
				category: quests[_quest_id].reward[_i].category,
				item_id: quests[_quest_id].reward[_i].item_id,
				despawn_time: 0,
			});	
		}
	}
	// check pre-requisites?
	quest_check_prerequisites();
	// play sound?
	// play animation?
}

function quest_check_prerequisites() {
	// after a quest is completed, check if any other quests had the completed quest as a prereq and set it to true
	
	// drill into quests array
	for (var _i = 0; _i < array_length(quests); _i++) {
		if (quests[_i].stage != 0) { continue; }
		var _prereqs_completed = true;
		
		// drill into quest prerequisites array
		for (var _j = 0; _j < array_length(quests[_i].prerequisites); _j++) {
		
			// loop through prereqs and check if they are all complete
			if (quests[_j].completed == false) {
				_prereqs_completed = false;
				break;
			}
		}
		
		// increment the quest stage from 0 to 1
		if (_prereqs_completed == true) {
			quests[_i].stage = 1;	
		}
	}
}

// talk quests
	
// dispatch quests
	
// eradicate quests
function quest_check_room_cleared() {
	if (eradicate_room_cleared == true) { exit; }
	if (!instance_exists(obj_parent_enemy)) {
		//var _room_id = asset_get_id;
		var _room_name = room_get_name(room);
		//show_debug_message($"_room_name: {_room_name}");
		
		// look for a quest with type eradicate and the current rooms name
		for (var _i = 0; _i < array_length(quests); _i++) {
			//show_debug_message($"quest[_i].track_id: {quests[_i].track_id[0]}");
			if (quests[_i].type == QUEST_TYPE.ERADICATE && quests[_i].track_id[0] == _room_name && quests[_i].track_qty[0] == 0) {
				show_debug_message("FOUND MATCH!!");
				show_debug_message(typeof(quests[_i].track_qty[0]));
				quests[_i].track_qty[0]++;
				quests[_i].stage = 3;
				quests[_i].active = true;
				// THIS WONT WORK IF YOU SET MULTIPLE ROOMS THAT NEEED TO BE CLEARED. WILL NEED TO ITERATE THROUGH TRACK_ID
			}
		}
		
		// set room cleared to true
		eradicate_room_cleared = true;
	}
}
// gather quests
	
// discover quests
	
// defend quests
	
// escort quests

#endregion