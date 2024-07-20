/// @desc - Update Menu



// Update The Menu
if (!global.game_paused) { exit; }
if (global.ui_type != UI_TYPE.LEVEL) exit;

//if (global.game_paused) {

// update menu input
right_input = keyboard_check_pressed(vk_right);
left_input = keyboard_check_pressed(vk_left);
up_input = keyboard_check_pressed(vk_up);
down_input = keyboard_check_pressed(vk_down);
right_bumper = keyboard_check_pressed(ord("E"));
left_bumper = keyboard_check_pressed(ord("Q"));
a_input = keyboard_check_pressed(ord("V"));
b_input = keyboard_check_pressed(ord("C"));
x_input = keyboard_check_pressed(ord("X"));
y_input = keyboard_check_pressed(ord("Z"));
	
	
	
// switch between menus with bumper input
if (right_bumper) {
	if (current_menu_page == MENU_TYPE.QUESTS) { current_menu_page = MENU_TYPE.MAP; } else { current_menu_page++;}
	menu_set_selector();
}
if (left_bumper) {
	if (current_menu_page == MENU_TYPE.MAP) { current_menu_page = MENU_TYPE.QUESTS; } else { current_menu_page--;}
	menu_set_selector();
}
	
// update the active menu
switch (current_menu_page) {
	//case MENU_TYPE.ITEMS:		menu_update_items();		break;
	case MENU_TYPE.BEASTIARY:	menu_update_beastiary();	break;
	case MENU_TYPE.MAP:			menu_update_map();			break;
	case MENU_TYPE.SYSTEM:		menu_update_system();		break;
	case MENU_TYPE.CHARACTER:	menu_update_character();	break;
	case MENU_TYPE.QUESTS:		menu_update_quests();		break;
}



//}
