
#region SET VARIABLES

eradicate_room_cleared = false;		// sets to false on room start - gets set to true once room is designated as cleared so we only run our room clear check once
broadcast_receiver = [];
quests = [];						// store all quests from the DB as their own objects in this array

// fill the quests array
for (var _i = 0; _i < ds_grid_height(global.quest_data); _i++) {
	
	// set active
	var _active = ds_grid_get(global.quest_data, QUEST_DATA.ACTIVE, _i);
	switch (_active) {
		case "FALSE":	_active = false;	break;
		case "TRUE":	_active = true;		break;
	}
	
	// set stage
	var _stage = QUEST_STAGE.UNAVAILABLE;
	var _prereqs = ds_grid_get(global.quest_data, QUEST_DATA.PREREQS, _i);
	
	// if the quest does not have any pre-requisites, set stage to 1
	if (_prereqs[0] == 0) {
		_stage = QUEST_STAGE.AVAILABLE;
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
		case "follow":		_quest_type = QUEST_TYPE.FOLLOW;		break;
	}
	
	// set trackers
	var _trackers = [];
	var _all_trackers = ds_grid_get(global.quest_data, QUEST_DATA.TRACKERS, _i);
	var _trackers_length = array_length(_all_trackers);
	for (var _j = 0; _j < _trackers_length; _j++) {
		var _one_tracker = string_split(_all_trackers[_j], "-");
		var _tracker = {
			tracker_id: _one_tracker[0],
			amount_needed: real(_one_tracker[1]),
			detail: _one_tracker[2],
			amount_gotten: 0,
		}
		array_push(_trackers, _tracker);
	}
	
	// set rewards
	var _rewards = [];
	var _all_rewards = ds_grid_get(global.quest_data,QUEST_DATA.REWARDS, _i);
	for (var _j = 0; _j < array_length(_all_rewards); _j++) {
		var _one_reward = string_split(_all_rewards[_j],"-");
		var _reward = {
			category: _one_reward[0],
			item_id: real(_one_reward[1]),
			qty: real(_one_reward[2]),
		}
		array_push(_rewards,_reward);
	}
	
	// start type
	var _start_type = ds_grid_get(global.quest_data, QUEST_DATA.START_TYPE, _i);
	switch (_start_type) {
		case "npc":		_start_type = QUEST_TRIGGER.NPC;			break;	
		case "room":	_start_type = QUEST_TRIGGER.ROOM;			break;	
		case "trigger":	_start_type = QUEST_TRIGGER.TRIGGER;		break;	
		case "kill":	_start_type = QUEST_TRIGGER.KILL;			break;	
		case "item":	_start_type = QUEST_TRIGGER.ITEM;			break;
		case "collide":	_start_type = QUEST_TRIGGER.COLLIDE;		break;
	}
	
	// set start
	var _quest_start = ds_grid_get(global.quest_data,QUEST_DATA.START, _i);
	_quest_start = asset_get_index($"{_quest_start}");
	
	
	// set end
	var _quest_end = ds_grid_get(global.quest_data,QUEST_DATA.END, _i);
	_quest_end = asset_get_index($"{_quest_end}");
	
	// create the quest object
	var _quest = {
		quest_id: _i,
		active: _active,
		completed: false,
		prerequisites: _prereqs,
		stage: _stage,
		name: ds_grid_get(global.quest_data, QUEST_DATA.NAME, _i),
		quest_type: _quest_type,
		trackers: _trackers,
		rewards: _rewards,
		quest_start: _quest_start,
		quest_end: _quest_end,
	}
	
	// push the created quest object to the quest array
	array_push(quests, _quest);
}
total_quests = array_length(quests);

#endregion

#region HELPER FUNCTIONS

// Initialize
function quest_init_npc() {
	for (var _i = 0; _i < total_quests; _i++) {
		var _q  = quests[_i];
		
		// setup quest starters
		var _quest_start = _q.quest_start;
		if (_quest_start != -1 && instance_exists(_quest_start)) {
			if (!_quest_start.quest) {
				_quest_start.quest = new Quest(_q);
			}
		}
		
		// setup quest enders
		var _quest_end = _q.quest_end;
		if (_quest_end != -1 && instance_exists(_quest_end)) {
			if (!_quest_end.quest) {
				_quest_end.quest = new Quest(_q);
			}
		}
		
		// setup followers
		if (_q.quest_type == QUEST_TYPE.FOLLOW) {
			var _followers = [];
			var _trackers_length = array_length(_q.trackers);
			for (var _j = 0; _j < _trackers_length; _j++) {
				var _follower = asset_get_index(_q.trackers[_j].tracker_id);
				if (_follower != -1 && instance_exists(_follower)) {
					if (!_follower.quest) {
						_follower.quest = new Quest(_q);
					}
					with (_follower) {
						quest.follow_target = obj_player;
						quest.update_script = npc_quest_follow_start_check;
					}
				}
			}
		}
		// setup escortees
	}
}

// Updating
function quest_update_broadcast() {
	if (array_length(broadcast_receiver) == 0) { exit; }
	if (instance_exists(obj_con_textbox)) { exit; }
	
	var _message = broadcast_receiver[0];
	_message.process(_message.arg0);
	//delete_broadcast();
	array_shift(global.quest_tracker.broadcast_receiver);
}

function quest_update_eradicate_room_cleared() {
	if (eradicate_room_cleared == true) { exit; }
	
	if (global.enemy_count == 0) {
		// get room name
		var _room_name = room_get_name(room);
		
		// send broadcast
		var _broadcast = new RoomClearedBroadcast(_room_name);
		array_push(global.quest_tracker.broadcast_receiver, _broadcast);
		
		// set room cleared to true
		eradicate_room_cleared = true;	
	}
}

#endregion

#region Archived Code


#endregion