
function apply_knockback(_obj, _knockback_amount, _knockback_reduction, _knockback_direction) {
	_obj.move_speed = 0;
	_obj.x_speed = 0;
	_obj.y_speed = 0;
	_obj.knockback_x = lengthdir_x((_knockback_amount*_knockback_reduction),_knockback_direction);
	_obj.knockback_y = lengthdir_y((_knockback_amount*_knockback_reduction),_knockback_direction);
}

function entity_update_knockback() {
	// apply knockback to speed
	if (knockback_x != 0) { x_speed = knockback_x; }
	if (knockback_y != 0) { y_speed = knockback_y; }
	
	// reduce knockback
	if (knockback_x != 0) knockback_x = lerp(knockback_x,0, .2);
	if (knockback_y != 0) knockback_y = lerp(knockback_y,0, .2);
	
	// turn knockback off once its slow enough
	if (abs(knockback_x) < 1 && abs(knockback_x) > 0 &&
		abs(knockback_y) < 1 && abs(knockback_y) > 0) {
		knockback_x = 0;
		knockback_y = 0;
		x_speed = 0;
		y_speed = 0;
	}
}

function check_knockback_is_0() {
	if (knockback_x	== 0 && knockback_y == 0) return true; else return false;
}

/*
function scr_throw_object(_kb, _kb_x, _kb_r) {
	var _dir = point_direction(x,y,mouse_x,mouse_y);	// set knockback direction
	x_kb = lengthdir_x(((_kb*_kb_x)*_kb_r),_dir);		// X knockback
	y_kb = lengthdir_y(((_kb*_kb_x)*_kb_r),_dir);		// Y knockback
}