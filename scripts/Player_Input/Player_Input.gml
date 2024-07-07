
function player_update_input(){
	// moving
	left_input			= keyboard_check(vk_left);
	right_input			= keyboard_check(vk_right);
	up_input			= keyboard_check(vk_up);
	down_input			= keyboard_check(vk_down);
	
	jump_input			= keyboard_check_pressed(vk_space);
	
	// letter inputs
	a_input				= keyboard_check(ord("V"));
	
	b_input_pressed		= keyboard_check_pressed(ord("Z"));
	b_input_held		= keyboard_check(ord("Z"));
	b_input_released	= keyboard_check_released(ord("Z"));
	
	x_input_pressed		= keyboard_check_pressed(ord("X"));
	x_input_held		= keyboard_check(ord("X"));
	x_input_released	= keyboard_check_released(ord("X"));
	
	y_input_pressed		= keyboard_check_pressed(ord("C"));
	y_input_held		= keyboard_check(ord("C"));
	y_input_released	= keyboard_check_released(ord("C"));
}

function player_input_jump_check() {
	if (!on_ground) { exit; }
	if (jump_input) {
		last_safe_x = xprevious;
		last_safe_y = yprevious;
		z_speed = -z_jump_speed;
	}
}

function player_input_a_check() {
	// keyboard = V
}

function player_input_b_check() {
	// keyboard = Z
	if (b_input_pressed) {
		if (item_id_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
		player_use_equip_slot(equip_slots[EQUIP.B]);
	}
}

function player_input_x_check() {
	// keyboard = X
}

function player_input_y_check() {
	// keyboard = C	
}