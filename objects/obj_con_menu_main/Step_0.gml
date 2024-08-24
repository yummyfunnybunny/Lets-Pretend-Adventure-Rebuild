/// @desc


left_input			= keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"));
right_input			= keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"));
up_input			= keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
down_input			= keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
select_input		= keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);

if (up_input) { button_selected ++; }
if (down_input) { button_selected --; }

if (button_selected > 3) button_selected = 0;
if (button_selected < 0) button_selected = 3;

if (select_input) {
	switch(button_selected) {
		case 0:		game_end();						break;
		case 1:		show_message("nothing yet");	break;
		case 2:		show_message("nothing yet");	break;
		case 3:		room_goto(rm_shady_woods);		break;
	}
}

