/// @desc draw menu

// draw game menu
if (global.game_paused == 1) {
	show_debug_message("should be drawing menu");
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