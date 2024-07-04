/// @desc

#region DEBUGGING

/*
for (var _i = 0; _i < array_length(obj_player.equipped_items); _i++;) {
	var _item_to_show = obj_player.equipped_items[_i];
	var drawX = (32 + (_i * 48));
	var drawY = (32 + (_i * 16));
	draw_set_font(fnt_display_data);
	draw_text(drawX, drawY, _item_to_show);
}
*/
/*
for (var xx = 0; xx < ds_grid_width(beastiary); xx ++){
	for (var yy = 0; yy < ds_grid_height(beastiary); yy ++) {
		statToShow = beastiary[# xx, yy];
		
		var drawX = (32 + (xx * 48));
		var drawY = (32 + (yy * 16));
		
		draw_set_font(fnt_display_data);
		draw_text(drawX, drawY, statToShow);
	}
}
*/

#endregion



// draw game menu
if (global.game_paused == 1) {
	
	switch(current_menu) {
		case MENU.ITEMS:
			menu_draw_items();
		break;
		
		case MENU.BEASTIARY:
			menu_draw_beastiary();
		break;
		
		case MENU.MAP:
			menu_draw_map();
		break;
		
		case MENU.SYSTEM:
			menu_draw_system();
		break;
	}
	
	
}

function menu_draw_items() {
	// draw background
	draw_sprite_ext(spr_menu_screen,1,0,0,1,1,0,c_white,1);
	
	// draw weapons
	var _weapons = obj_player.weapons;
	var _weapon_slots_x = 360;
	var _weapon_slots_y = 98;
	var _weapon_length = ds_grid_width(_weapons);
	for(var _i = 0; _i < _weapon_length; _i++;) {
		if (ds_grid_get(_weapons,_i,0) != 0) {
			// draw Item Sprite
			draw_sprite(spr_inv_weapon,global.item_data[# ITEM_COLUMN.IMAGE_INDEX,_weapons[# _i,0]],_weapon_slots_x+(48*_i),_weapon_slots_y);
			// draw equipped input icon
			var _equipped_input = check_if_equipped(ds_grid_get(_weapons,_i,0));
			if (_equipped_input != -1) {
				draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_weapon_slots_x-8)+(48*_i),_weapon_slots_y+8,1.5,1.5,0,c_white,1);
			}
		} else draw_sprite(spr_inv_weapon,0,_weapon_slots_x+(48*_i),_weapon_slots_y);
	}
	

	
	// draw items
	var _items = obj_player.items;
	var _item_slots_x = 360;
	var _item_slots_y = 184;
	for(var _col = 0; _col < ds_grid_width(_items); _col++;) {
		for (var _row = 0; _row < ds_grid_height(_items); _row++;) {
			if (_items[# _col,_row] != 0) {
				// draw item sprite
				draw_sprite(spr_inv_item,global.item_data[# ITEM_COLUMN.IMAGE_INDEX,_items[# _col,_row]],_item_slots_x+(48*_col),_item_slots_y+(32*_row));
				// draw equipped input icon
				var _equipped_input = check_if_equipped(ds_grid_get(_items,_col,_row));
				if (_equipped_input != -1) {
					draw_sprite_ext(spr_button_input_icons, _equipped_input+1,(_item_slots_x-8)+(48*_col),(_item_slots_y+8)+(32*_row),1.5,1.5,0,c_white,1);
				}
			} else draw_sprite(spr_inv_item,0,_item_slots_x+(48*_col),_item_slots_y+(32*_row));
		}
	}
	// draw selector and item text
	if (alarm[0] == -1) {
		draw_sprite(spr_menu_selector,0,selector_start_x + (48*current_slot_x), selector_start_y + (32*current_slot_y));
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		switch(current_items) {
			case INVENTORY.WEAPONS:
				if (obj_player.weapons[# current_slot_x,current_slot_y] != 0) {
					draw_set_font(fnt_menu_item_name);
					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
					draw_set_font(fnt_menu_item_description);
					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.weapons,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
				}
			break;
			
			case INVENTORY.ITEMS:
				if (obj_player.items[# current_slot_x,current_slot_y] != 0) {
					draw_set_font(fnt_menu_item_name);
					var _item_name = ds_grid_get(global.item_data,ITEM_COLUMN.NAME, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-48,_item_name);
					draw_set_font(fnt_menu_item_description);
					var _item_description = ds_grid_get(global.item_data,ITEM_COLUMN.DESCRIPTION, ds_grid_get(obj_player.items,current_slot_x,current_slot_y));
					draw_text(display_get_gui_width()/2, display_get_gui_height()-24,_item_description);
				}
			break;
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}


function menu_draw_beastiary() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,2,0,0,1,1,0,c_white,1);
	
	// draw whichever page you're currently on
	var _starting_page_row = (beastiary_current_page*5)-5;
	var _ending_page_row = min(beastiary_current_page*5,ds_grid_height(beastiary));
	
	// draw beastiary ds grid based on the page you're on
	for (var _row = _starting_page_row; _row < _ending_page_row; _row++) {
		for (var _col = 0; _col < ds_grid_width(beastiary); _col++) {
			var _draw_y = (84+(48*(_row-((beastiary_current_page-1)*5))));
			
			// draw category titles
			if (is_string(ds_grid_get(beastiary,_col,_row))) {
				draw_set_font(fnt_beastiary_category_name);
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				var _category_title = ds_grid_get(beastiary,_col,_row);
				_category_title = string_ucfirst(_category_title);
				draw_text(48+(32*_col),_draw_y,_category_title);
			}
			// draw enemy grid sprites
			if (is_real(ds_grid_get(beastiary,_col,_row)) && ds_grid_get(beastiary,_col,_row) != 0) {
				var _sprite = asset_get_index(ds_grid_get(global.enemy_data,ENEMY_COLUMN.GRID_SPRITE,ds_grid_get(beastiary,_col,_row)));
				var _sprite_index = global.enemy_data[# ENEMY_COLUMN.GRID_SPRITE_INDEX, ds_grid_get(beastiary, _col, _row)];
				draw_sprite(_sprite, _sprite_index, 64+(56*_col),_draw_y);
			}
		}
	}
	
	// draw beastiary selector
	if (alarm[0] == -1) {
		var _draw_y = (84+(48*(current_slot_y-((beastiary_current_page-1)*5))));
		draw_sprite(spr_menu_selector,selector_sprite, selector_start_x+(current_slot_x*56), _draw_y);		
	}
	// draw selected enemy info
	if (alarm[0] == -1) {
		// draw enemy title
		draw_set_font(fnt_menu_enemy_name);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var _enemy_name = ds_grid_get(global.enemy_data,ENEMY_COLUMN.NAME,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_text(480,72,_enemy_name);

		// draw enemy sprite
		var _display_sprite = ds_grid_get(global.enemy_data,ENEMY_COLUMN.DISPLAY_SPRITE,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		if (_display_sprite != "none") {
			_display_sprite = asset_get_index(_display_sprite);
			var _sprite_height = sprite_get_height(_display_sprite);
			draw_sprite_ext(_display_sprite,0,480,138+_sprite_height,2,2,0,c_white,1);	
		}
		
		// draw enemy description
		var _enemy_description = ds_grid_get(global.enemy_data,ENEMY_COLUMN.DESCRIPTION,ds_grid_get(beastiary,current_slot_x,current_slot_y));
		draw_set_font(fnt_menu_enemy_description);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(355,202,_enemy_description);
		
		// draw enemy locales
		
	}
	// draw scroll knob
		var _knob_position = ((beastiary_current_page - 1)/(beastiary_pages-1));
		draw_sprite(spr_beastiary_scroller,0,23,90+(_knob_position*188));
}

function menu_draw_map() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,0,0,0,1,1,0,c_white,1);
}

function menu_draw_system() {
	
	// draw background
	draw_sprite_ext(spr_menu_screen,3,0,0,1,1,0,c_white,1);
}
