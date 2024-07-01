
if (global.game_paused == 1) exit;
if (ui_type) == "level" {
	
	if (instance_exists(obj_player)) {
		
		// draw hp bar
		draw_sprite(spr_hp_bar,1,16,16);
		draw_sprite_ext(spr_hp_bar,0,16,16,1,1,0,c_white,1);
	
		// draw weapons equipped
		draw_sprite(spr_hud_equipped_frame,0,496, 16);	// b button
		draw_sprite(spr_hud_equipped_frame,0,544, 16);	// y button
		draw_sprite(spr_hud_equipped_frame,0,592, 16);	// x button
	
	
		// draw equipped items
		var _start_x = 512;
		var _start_y = 32;
		for (var _i = 0; _i < array_length(obj_player.equipped_items); _i++;) {
			if (obj_player.equipped_items[_i] != 0) {
				var _sprite = asset_get_index(ds_grid_get(global.item_data,ITEM_COLUMN.SPRITE_INDEX,obj_player.equipped_items[_i]));
				var _sprite_index = ds_grid_get(global.item_data,ITEM_COLUMN.IMAGE_INDEX,obj_player.equipped_items[_i]);
				draw_sprite(_sprite,_sprite_index,_start_x+(48*_i),_start_y);
			}
		}
	
		// draw equipped item button input icons
		draw_sprite_ext(spr_button_input_icons,2,592, 48,1.5,1.5,0,c_white,1);
		draw_sprite_ext(spr_button_input_icons,3,544, 48,1.5,1.5,0,c_white,1);
		draw_sprite_ext(spr_button_input_icons,1,496, 48,1.5,1.5,0,c_white,1);
	
	
		//draw_sprite(spr_char_screen,0, 96,96);
	}
}