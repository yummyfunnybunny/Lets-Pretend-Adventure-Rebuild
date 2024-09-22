/// @desc level manager

#region SET LEVEL VARIABLES

overlay_x_lerp = 0;
overlay_y_lerp = 0;

#endregion

#region CREATE LEVEL ESSENTIALS



// create the HUD Controller
if (!instance_exists(obj_con_hud_level)) {
	global.level_hud = instance_create_layer(0, 0, CONTROLLER_LAYER, obj_con_hud_level);
}

// create level menu controller
if (!instance_exists(obj_con_menu_level)) {
	global.level_menu = instance_create_layer(0,0, CONTROLLER_LAYER, obj_con_menu_level);
}

// create player at start of level
if (!instance_exists(obj_player)) {
	instance_create_layer(PLAYER_START_X, PLAYER_START_Y, INSTANCES_1_LAYER, obj_player);
}

// create camera at start of level
if (!instance_exists(obj_con_camera)) {
	global.camera = instance_create_layer(obj_player.x,obj_player.y,CONTROLLER_LAYER,obj_con_camera);	
}

// Depth Sorter 1
if (!layer_has_instance(layer_get_id(INSTANCES_1_LAYER),asset_get_index("obj_con_depth_sorter"))) {
	global.depth_sorter_1 = instance_create_layer(0, 0, INSTANCES_1_LAYER, obj_con_depth_sorter,{
	depth_layer: INSTANCES_1_LAYER
	});
}

// Depth Sorter 2
if (!layer_has_instance(layer_get_id(INSTANCES_2_LAYER),asset_get_index("obj_con_depth_sorter"))) {
	global.depth_sorter_2 = instance_create_layer(0, 0, INSTANCES_2_LAYER, obj_con_depth_sorter, {
	depth_layer: INSTANCES_2_LAYER
	});
}

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
		if (object_is_ancestor(object_index, obj_parent_prop)) { exit; }
		image_speed = 1;	
	}
}

function level_set_overlay() {
	var _layer = layer_get_id("overlay");
	var _bg_id = layer_background_get_id(_layer);
	
	if (_bg_id == -1) { exit; }
	
	var _sprite = layer_background_get_sprite(_bg_id);
	if (_sprite == -1) { exit; }
	var _name = sprite_get_name(_sprite);
	var _type = string_split(_name,"_");
	
	switch(_type[2]) {
		case "woods":
			overlay_x_lerp = 0.5;
			overlay_y_lerp = 0.5;
		break;
	}
	
	
}

function level_update_overlay() {
	var _layer = layer_get_id("overlay");
	var _bg_id = layer_background_get_id(_layer);
	
	if (_bg_id == -1) { exit; }
	
	if (overlay_x_lerp != 0 || overlay_y_lerp != 0) {
		layer_x(_layer, lerp(0,camera_get_view_x(global.camera.main_camera), overlay_x_lerp));
		layer_y(_layer, lerp(0,camera_get_view_y(global.camera.main_camera), overlay_y_lerp));
	}
}

#endregion

