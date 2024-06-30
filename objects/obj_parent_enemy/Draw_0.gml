/// @desc

// Inherit the parent event
event_inherited();

if (global.debugger) {
	
	var _main_state;
	switch(main_state){
		case enemy_state_unaware:			_main_state = "unaware";		break;	
		case enemy_state_aware:				_main_state = "aware";			break;	
		default:							_main_state = "unknown";		break;	
	}
	
	var _nest_state;
	switch(nest_state) {
		case enemy_state_idle:				_nest_state = "idle";			break;	
		case enemy_state_wander:			_nest_state = "wander";			break;	
		case enemy_state_wait:				_nest_state = "wait";			break;	
		case enemy_state_sleep:				_nest_state = "sleep";			break;	
		case enemy_state_chase:				_nest_state = "chase";			break;
		case enemy_state_attack:			_nest_state = "attack";			break;
		case enemy_state_flee:				_nest_state = "flee";			break;	
		case enemy_state_death:				_nest_state = "death";			break;	
		case enemy_state_hurt:				_nest_state = "hurt";			break;
		case enemy_state_return_origin:		_nest_state = "return origin";	break;	
		case enemy_state_align:				_nest_state = "align";			break;	
		default:							_nest_state = "unknown";		break;	
	}
	
	draw_set_font(fnt_debugger);
	draw_text(x + 16,y-32, "main_state= " + string(_main_state));
	draw_text(x + 16,y-16, "nest_state = " + string(_nest_state));
	draw_text(x + 16,y, "z_floor " + string(z_floor));
	//draw_text(x + 16,y+16, "kb y = " + string(knockback_y));
	
	draw_circle_color(x,y,aggro_range*COL_TILES_SIZE,c_yellow,c_yellow,true);
	draw_circle_color(x,y,attack_range*COL_TILES_SIZE,c_red,c_red,true);
	
	draw_sprite_ext(spr_marker,0,origin_x,origin_y,1,1,0,c_red,1);
}