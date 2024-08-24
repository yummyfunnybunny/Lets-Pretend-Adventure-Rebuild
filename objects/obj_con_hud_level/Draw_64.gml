
if (global.game_paused == true) exit;
if (global.ui_type != UI_TYPE.LEVEL) exit;
if (!instance_exists(obj_player)) exit;
		
// hp bar
draw_sprite(spr_hp_bar,1,hp_x_start+padding,hp_y_start+padding);													// background
draw_sprite_ext(spr_hp_bar,2,hp_x_start+padding,hp_y_start+padding,obj_player.hp/obj_player.max_hp,1,0,c_white,1);	// health
draw_sprite_ext(spr_hp_bar,0,hp_x_start+padding,hp_y_start+padding,1,1,0,c_white,1);								// frame
	
// equipped frames
for (var _i = 0; _i < 2; _i++) {
	draw_sprite(spr_item_frame,0,equipped_slots_x_start-padding-(_i*equipped_slots_gap), equipped_slots_y_start+padding);	// B button
}
	
// equipped items
var _player_equipped_width = array_length(global.player.equipped[0]);
var _player_equipped = global.player.equipped[0];

// mainhand
var _offhand_id = _player_equipped[1].item_id;
if (_offhand_id != 0) {
	var _inv_img_idx = ds_grid_get(global.offhand_data, OFFHAND_DATA.INV_IMG_IDX, _offhand_id);
	draw_sprite_ext(spr_item_inv_mainhand, _inv_img_idx, equipped_slots_x_start-padding-(0*equipped_slots_gap), equipped_slots_y_start+padding, 2, 2, 0, c_white, 1);
}

// offhand
var _mainhand_id = _player_equipped[0].item_id;
if (_mainhand_id != 0) {
	var _inv_img_idx = ds_grid_get(global.mainhand_data, MAINHAND_DATA.INV_IMG_IDX, _mainhand_id);
	draw_sprite_ext(spr_item_inv_mainhand, _inv_img_idx,equipped_slots_x_start-padding-(1*equipped_slots_gap), equipped_slots_y_start+padding,2,2,0,c_white,1);
}

// input icons
for (var _i = 0; _i < 2; _i++) {
	var _idx = (_i == 0) ? 1 : 0;
	draw_sprite_ext(spr_button_input_icons,_idx,equipped_slots_x_start-padding-(_i*equipped_slots_gap)+equipped_input_offset_x, equipped_slots_y_start+padding+equipped_input_offset_y,1.5,1.5,0,c_white,1);	// A
}

