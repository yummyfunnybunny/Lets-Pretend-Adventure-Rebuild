/// @desc level manager

#region CREATE LEVEL ESSENTIALS



// create the HUD Controller
if (!instance_exists(obj_con_hud_level)) {
	global.level_hud = instance_create_layer(0, 0, layer, obj_con_hud_level);
}

// create level menu controller
if (!instance_exists(obj_con_menu_level)) {
	global.level_menu = instance_create_layer(0,0, layer, obj_con_menu_level);
}

// create player at start of level
if (!instance_exists(obj_player)) {
	instance_create_depth(PLAYER_START_X, PLAYER_START_Y, INSTANCE_DEPTH, obj_player);
}

// create camera at start of level
if (!instance_exists(obj_con_camera)) {
	global.camera = instance_create_depth(obj_player.x,obj_player.y,INSTANCE_DEPTH,obj_con_camera);	
}

// create quest tracker
//if (!instance_exists(obj_con_quests)) {
//	global.quest_tracker = instance_create_layer(x,y,INSTANCE_LAYER,obj_con_quests);	
//}

#endregion


#region LEVEL HELPER FUNCTIONS

function level_pause_game() {
	with (all) {
		if (object_index == obj_parent_item) { exit; }
		image_speed = 0;	
	}
}

function level_resume_game() {
	with (all) {
		if (object_index == obj_parent_item) { exit; }
		image_speed = 1;	
	}
}

#endregion

