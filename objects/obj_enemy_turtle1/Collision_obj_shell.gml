/// @desc find turtle shell

if (other.id == shell_id && nest_state = enemy_state_return_origin) {
	instance_destroy(other);
	shell_id = noone;
	has_shell = true;
	origin_x = 0;
	origin_y = 0;
	pather_delete(pather_object);
	sprite_idle = spr_turtle1_idle;
	sprite_move = spr_turtle1_move;
	nest_state = enemy_state_wait;	
	main_state = enemy_state_unaware;
}

