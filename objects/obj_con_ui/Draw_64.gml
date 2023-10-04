
if (ui_type) == "level" {
	
	draw_sprite_ext(spr_hp_bar,1,16,16, obj_player.hp/obj_player.max_hp, .5, 0, c_white, 1);
	draw_sprite_ext(spr_hp_bar,0,16,16,1,.5,0,c_white,1);
	draw_sprite(spr_weapon_equipped,0,592, 16);
	draw_sprite(spr_weapon_equipped,0,544, 16);
	
	draw_sprite(spr_char_screen,0, 96,96);
}