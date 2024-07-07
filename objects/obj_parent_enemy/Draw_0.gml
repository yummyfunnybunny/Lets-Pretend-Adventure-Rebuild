/// @desc



if (global.debugger) {
	
	var _main_state;
	switch(main_state){
		case main_state_unaware:			_main_state = "unaware";		break;	
		case main_state_aware:				_main_state = "aware";			break;	
		default:							_main_state = "unknown";		break;	
	}
	
	var _nest_state;
	switch(nest_state) {
		case nest_state_idle:				_nest_state = "idle";			break;	
		case nest_state_wander:				_nest_state = "wander";			break;	
		case nest_state_wait:				_nest_state = "wait";			break;	
		case nest_state_sleep:				_nest_state = "sleep";			break;	
		case nest_state_chase:				_nest_state = "chase";			break;
		case nest_state_attack:				_nest_state = "attack";			break;
		case nest_state_flee:				_nest_state = "flee";			break;	
		case nest_state_death_normal:		_nest_state = "death normal";	break;	
		case nest_state_hurt:				_nest_state = "hurt";			break;
		case nest_state_return_origin:		_nest_state = "return origin";	break;	
		case nest_state_align:				_nest_state = "align";			break;	
		default:							_nest_state = "unknown";		break;	
	}
	
	draw_set_font(fnt_debugger);
	draw_text(x + 16,y-32, "main_state= " + string(_main_state));
	draw_text(x + 16,y-16, "nest_state = " + string(_nest_state));
	//draw_text(x + 16,y, "z_floor " + string(z_floor));
	//draw_text(x + 16,y+16, "kb y = " + string(knockback_y));
	
	draw_circle_color(x,y,aggro_range*COL_TILES_SIZE,c_yellow,c_yellow,true);
	draw_circle_color(x,y,attack_range*COL_TILES_SIZE,c_red,c_red,true);
	
	// origin
	draw_sprite_ext(spr_marker,0,origin_x,origin_y,1,1,0,c_red,1);
	
	// border box
	//draw_rectangle(bbox_left,bbox_top+z_bottom,bbox_right,bbox_bottom+z_bottom, true);
	draw_ellipse(bbox_left,bbox_top+z_bottom,bbox_right,bbox_bottom+z_bottom, true);
}

// Inherit the parent event
event_inherited();