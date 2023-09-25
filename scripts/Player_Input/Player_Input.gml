/// @desc ???
// if (self.state == player_state_death) ex_it;


function player_update_input(){
	// == Update _inputs ==
	left_input			= keyboard_check(vk_left) || keyboard_check(ord("A"));
	right_input			= keyboard_check(vk_right) || keyboard_check(ord("D"));
	up_input			= keyboard_check(vk_up) || keyboard_check(ord("W"));
	down_input			= keyboard_check(vk_down) || keyboard_check(ord("S"));
	interact_input		= keyboard_check(ord("V")) || mouse_check_button_pressed(mb_right);
	attack_input		= keyboard_check(ord("C")) || mouse_check_button_pressed(mb_left);
	jump_input			= keyboard_check(vk_space);
	restart_input		= keyboard_check(vk_escape);
	
}

// Restart Game
function player_reset() {
	if (restart_input){
		game_restart();
	}
}

function player_move() {
	if (right_input - left_input != 0 || down_input - up_input != 0) {
			
	}
}

function player_jump() {
	if (jump_input) {
		last_safe_x = x_prev;
		last_safe_y = y_prev;
		z_speed = -z_jump_speed;
		state = player_state_jump;
	}
}

function player_attack() {
	if (attack_input) {
		state = player_state_attack;
	}
}

function player__interact() {
	if (interact_input) {
		state = player_state__interact;
	}
}