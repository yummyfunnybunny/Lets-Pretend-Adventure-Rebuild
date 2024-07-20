
function player_update_input(){
	// moving
	left_input			= keyboard_check(vk_left);
	right_input			= keyboard_check(vk_right);
	up_input			= keyboard_check(vk_up);
	down_input			= keyboard_check(vk_down);
	
	jump_input			= keyboard_check_pressed(vk_space);
	
	// letter inputs
	a_input_pressed		= keyboard_check_pressed(ord("V"));
	
	b_input_pressed		= keyboard_check_pressed(ord("C"));
	b_input_held		= keyboard_check(ord("C"));
	b_input_released	= keyboard_check_released(ord("C"));
	
	x_input_pressed		= keyboard_check_pressed(ord("X"));
	x_input_held		= keyboard_check(ord("X"));
	x_input_released	= keyboard_check_released(ord("X"));
	
	y_input_pressed		= keyboard_check_pressed(ord("Z"));
	y_input_held		= keyboard_check(ord("Z"));
	y_input_released	= keyboard_check_released(ord("Z"));
}

function player_input_jump_check() {
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (jump_input) {
		last_safe_x = xprevious;
		last_safe_y = yprevious;
		z_speed = -z_jump_speed;
	}
}

function player_input_a_check() {
	// keyboard = V
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (a_input_pressed) {
		player_use_mainhand(global.player.equipped[0][0]);
		//player_use_equip_slot(equip_slots[EQUIP.B]);
	}
}

function player_input_b_check() {
	// keyboard = C
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (!on_ground) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (nest_state == nest_state_hurt) { exit; }
	if (b_input_pressed) {
		player_use_offhand(global.player.equipped[0][1]);
	}
}

function player_input_x_check() {
	// keyboard = X
	if (!interact_target) { exit; }
	if (x_input_pressed) {
		// will need to dynamically choose what to do here later...
		with (interact_target) {
			if (object_is_ancestor(object_index,obj_parent_npc)) {
				npc_interact_input_progression();
			} else if (object_index == obj_parent_item) {
				item_interact_input_progression();
			}
			//nest_state = nest_state_interact;
		}
	}
}

function player_input_y_check() {
	// keyboard = Z
	if (nest_state == nest_state_hurt) { exit; }
	if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER || terrain_state == TERRAIN_TYPE.TALL_GRASS) { exit; }
	if (nest_state == nest_state_climb) { exit; }
	if (!on_ground) { exit; }
	if (item_used != noone) { exit; }		// exit if another item is already being used (MIGHT DELETE)
	if (y_input_pressed) {
	}
}