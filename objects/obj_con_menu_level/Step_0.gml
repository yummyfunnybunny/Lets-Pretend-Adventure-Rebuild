/// @desc - Update Menu

// Set Input For Opening Menu
menu_input = keyboard_check_pressed(ord("P"));

// Update Menu open/close Input
if (menu_input) {
	global.game_paused *= -1;
}

// Update The Open Menu
if (global.game_paused == 1) {
	
	// update menu input
	right_input = keyboard_check_pressed(vk_right);
	left_input = keyboard_check_pressed(vk_left);
	up_input = keyboard_check_pressed(vk_up);
	down_input = keyboard_check_pressed(vk_down);
	right_bumper = keyboard_check_pressed(ord("E"));
	left_bumper = keyboard_check_pressed(ord("Q"));
	b_input = keyboard_check_pressed(ord("Z"));
	x_input = keyboard_check_pressed(ord("X"));
	y_input = keyboard_check_pressed(ord("C"));
	
	
	
	// switch between menus with bumper input
	if (right_bumper) {
		if (current_menu == MENU.SYSTEM) { current_menu = MENU.MAP; } else { current_menu++;}
		menu_set_selector();
	}
	if (left_bumper) {
		if (current_menu == MENU.MAP) { current_menu = MENU.SYSTEM; } else { current_menu--;}
		menu_set_selector();
	}
	
	// update the active menu
	switch (current_menu) {
		case MENU.ITEMS:		menu_update_items();		break;
		case MENU.BEASTIARY:	menu_update_beastiary();	break;
		case MENU.MAP:			menu_update_map();			break;
		case MENU.SYSTEM:		menu_update_system();		break;
	}
}
