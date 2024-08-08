
#region NPC QUEST STRUCTS

function Quest(_quest) constructor {
	quest_id		= _quest.quest_id;
	stage			= _quest.stage;
	start_object	= _quest.quest_start;
	end_object		= _quest.quest_end;
	update_script	= noone;
	follow_target	= noone;
}

#endregion

#region BROADCAST STRUCTS

function QuestBroadcast(_quest_type) constructor {

}

function ItemDropBroadcast(_item_category, _item_id, _quest_type = QUEST_TYPE.NONE) : QuestBroadcast(_quest_type) constructor {
	quest_type = _quest_type;
	
	static process = function(_item_category, _item_id) {
		// loop through quests and find gather quests
		for (var _i = 0; _i < total_quests; _i++) {
			if (quests[_i].type == QUEST_TYPE.GATHER) {
				var _q = quests[_i];
				var _trackers_length = array_length(_q.trackers);
				
				// loop through the trackers for each gather quest
				for (var _j = 0; _j < _trackers_length; _j++) {
					var _tracker = _q.trackers[_j];
					var _tracker_id = _tracker.tracker_id;
					var _tracker_detail = _tracker.detail;
					if (_item_category == _tracker_detail && _item_id == _tracker_id) {
						_q.stage = QUEST_STAGE.ACTIVE;	
					}
				}
			}
		}
	}
}

function ItemPickupBroadcast(_quest_type) : QuestBroadcast(_quest_type) constructor {
	quest_type = _quest_type;
}

function EndDialogueBroadcast(_npc, _quest_type = QUEST_TYPE.NONE ) : QuestBroadcast(_quest_type) constructor {
	arg0 = _npc;
	quest_type = _quest_type;
	
	static process = function(_npc) {
		var _total = global.quest_tracker.total_quests;
		var _quests = global.quest_tracker.quests;
		// loop through quests and find any that are associated with the NPC
		for (var _i = 0; _i < _total; _i++) {
			var _q = _quests[_i];

			// quest start
			if (_q.quest_start == _npc) {
				if (_q.stage == QUEST_STAGE.AVAILABLE) {
					_q.stage = QUEST_STAGE.ACTIVE;
					quest_update_npc_quest(_npc, _q.stage);
				}
			}
			
			// quest end
			if (_q.quest_end == _npc) {
				if (_q.stage == QUEST_STAGE.SUCCESS) {
					_q.stage = QUEST_STAGE.COMPLETED;
					quest_update_npc_quest(_npc, _q.stage);
					quest_complete(_q.quest_id, _q.quest_start);
				}
			}
		}
	}
}

function RoomClearedBroadcast(_room, _quest_type = QUEST_TYPE.ERADICATE) : QuestBroadcast(_quest_type) constructor {
	arg0 = _room;
	quest_type = _quest_type;
	
	static process = function(_room) {
		var _total = global.quest_tracker.total_quests;
		var _quests = global.quest_tracker.quests;
		
		// loop through quests
		for (var _i = 0; _i < _total; _i++) {
			var _q = _quests[_i];
			
			if (_q.quest_type == QUEST_TYPE.ERADICATE) {
				var _trackers_length = array_length(_q.trackers);
				
				// loop through trackers
				for (var _j = 0; _j < _trackers_length; _j++) {
					var _tracker = _q.trackers[_j];
					var _room_idx = asset_get_index(_tracker.tracker_id);
					var _room_name = room_get_name(_room_idx);
					if (_room == _room_name) {
						_tracker.amount_gotten = true;
						quest_check_for_success(_q);
					}
				}
			}
		}
	}
}

function EndFollowBroadcast(_npc, _quest_type = QUEST_TYPE.FOLLOW) : QuestBroadcast(_quest_type) constructor {
	arg0 = _npc;
	quest_type = _quest_type;
	
	static process = function(_npc) {
		var _quests = global.quest_tracker.quests;
		var _quests_length = array_length(global.quest_tracker.quests);
		
		// drill into quests
		for (var _i = 0; _i < _quests_length; _i++) {
			var _q = _quests[_i];
			
			// check if quest is a follow quest
			if (_q.quest_type == QUEST_TYPE.FOLLOW) {
				
				// drill into trackers
				var _trackers_length = array_length(_q.trackers);
				for (var _j = 0; _j < _trackers_length; _j++) {
					var _tracker = _q.trackers[_j];
					
					
					var _tracker_id = asset_get_index(_tracker.tracker_id);
					if (_tracker_id == _npc) {
						_tracker.amount_gotten = true;
						quest_check_for_success(_q);
						quest_update_npc_quest(_q.quest_start, _q.stage);
					}
				}
			}
		}
	}
}

#endregion

#region QUEST HELPERS

function quest_update_npc_quest(_npc, _stage) {
	if (instance_exists(_npc)) {
		_npc.quest.stage = _stage;
	}
}

function quest_check_for_success(_quest) {
	var _trackers_length = array_length(_quest.trackers);
				
	// loop through trackers
	for (var _i = 0; _i < _trackers_length; _i++) {
		var _tracker = _quest.trackers[_i];
		var _completed = true;
		
		switch(_quest.quest_type) {
			// boolean checks
			case QUEST_TYPE.TALK:
			case QUEST_TYPE.ERADICATE:
			case QUEST_TYPE.DISCOVER:
			case QUEST_TYPE.DEFEND:
			case QUEST_TYPE.ESCORT:
			case QUEST_TYPE.FOLLOW:
				if (!_tracker.amount_gotten) {
					_completed = false;
				}
			break;
			
			// amount checks
			case QUEST_TYPE.DISPATCH:
			case QUEST_TYPE.GATHER:
				if (_tracker.amount_needed == _tracker.amount_gotten) {
					_completed = false;
				}
			break;
		}
		if (_completed) { _quest.stage = QUEST_STAGE.SUCCESS; }
	}
}

function quest_complete(_quest_id, _npc) {
	var _q = global.quest_tracker.quests[_quest_id];
	var _rewards_length = array_length(_q.rewards);
	
	
	// provide reward
	for (var _i = 0; _i < _rewards_length; _i++) {
		var _reward = _q.rewards[_i];
		repeat(_reward.qty) {
			var _item = instance_create_layer(_npc.x,_npc.y,INSTANCE_LAYER,obj_parent_item, {
				category: _reward.category,
				item_id: _reward.item_id,
				despawn_time: 0,
			});	
		}
	}
	// check pre-requisites?
	quest_update_prerequisites(_quest_id);
	// play sound?
	// play animation?
}

function quest_update_prerequisites(_quest_id) {
	// after a quest is completed, check if any other quests had the completed quest as a prereq and set it to true
	var _quests = global.quest_tracker.quests;
	var _quests_length = array_length(global.quest_tracker.quests);
	
	// drill into quests array
	for (var _i = 0; _i < _quests_length; _i++) {
		var _q = _quests[_i];
		if (_q.stage != QUEST_STAGE.UNAVAILABLE) { continue; }
		var _prereqs_completed = true;
		
		// drill into quest prerequisites array
		var _prereqs_length = array_length(_q.prerequisites);
		for (var _j = 0; _j < _prereqs_length; _j++) {
			var _prereq = _q.prerequisites[_j];
			if (_prereq.stage != QUEST_STAGE.COMPLETED) {
				_prereqs_completed = false;
				break;
			}
		}
		
		// increment the quest stage from unavailable (0) to available (1)
		if (_prereqs_completed == true) {
			_q.stage = QUEST_STAGE.AVAILABLE;
		}
	}
}


#endregion

#region Archived Code

#endregion