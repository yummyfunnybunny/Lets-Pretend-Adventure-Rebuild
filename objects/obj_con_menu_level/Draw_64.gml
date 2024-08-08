/// @desc draw menu

// draw game menu
if (global.game_paused) {

	switch(current_menu_page) {
		//case MENU_TYPE.ITEMS:		menu_draw_items();			break;
		case MENU_TYPE.BEASTIARY:	menu_draw_beastiary();		break;
		case MENU_TYPE.MAP:			menu_draw_map();			break;
		case MENU_TYPE.SYSTEM:		menu_draw_system();			break;
		case MENU_TYPE.CHARACTER:	menu_draw_character();		break;
		case MENU_TYPE.QUESTS:		menu_draw_quests();			break;
		
	}
}