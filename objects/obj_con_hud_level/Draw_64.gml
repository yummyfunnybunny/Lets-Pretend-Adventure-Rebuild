
if (global.game_paused == true) exit;
if (global.ui_type != UI_TYPE.LEVEL) exit;
if (!instance_exists(obj_player)) exit;
		
// hp bar
draw_sprite(spr_hp_bar,1,16,16);													// background
draw_sprite_ext(spr_hp_bar,2,16,16,obj_player.hp/obj_player.max_hp,1,0,c_white,1);	// health
draw_sprite_ext(spr_hp_bar,0,16,16,1,1,0,c_white,1);								// frame
	
// equipped frame
draw_sprite(spr_hud_equipped_frame,0,496, 16);	// B button
draw_sprite(spr_hud_equipped_frame,0,544, 16);	// X button
draw_sprite(spr_hud_equipped_frame,0,592, 16);	// Y button
	
	
// equipped items
var _start_x = 512;
var _start_y = 32;
for (var _i = 0; _i < array_length(obj_player.equip_slots); _i++;) {
	if (obj_player.equip_slots[_i] != 0) {
		var _sprite = asset_get_index(ds_grid_get(global.item_data,ITEM_COLUMN.SPRITE_INDEX,obj_player.equip_slots[_i]));
		var _sprite_index = ds_grid_get(global.item_data,ITEM_COLUMN.IMAGE_INDEX,obj_player.equip_slots[_i]);
		draw_sprite(_sprite,_sprite_index,_start_x+(48*_i),_start_y);
	}
}
	
// input icons
draw_sprite_ext(spr_button_input_icons,1,496, 48,1.5,1.5,0,c_white,1);	// B
draw_sprite_ext(spr_button_input_icons,2,544, 48,1.5,1.5,0,c_white,1);	// X
draw_sprite_ext(spr_button_input_icons,3,592, 48,1.5,1.5,0,c_white,1);	// Y