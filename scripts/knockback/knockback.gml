
function knockback_apply(_obj, _knockback_amount, _knockback_reduction, _knockback_direction) {
	// applies knockback to entity
	_obj.move_speed = 0;
	_obj.x_speed = 0;
	_obj.y_speed = 0;
	_obj.knockback_x = lengthdir_x((_knockback_amount*_knockback_reduction),_knockback_direction);
	_obj.knockback_y = lengthdir_y((_knockback_amount*_knockback_reduction),_knockback_direction);
}

function knockback_update() {
	// updates knockback on entity
	if (knockback_x == 0 && knockback_y == 0) { exit; }
	show_debug_message("applying knockback");
	
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

function knockback_check() {
	// checks for any knockback on an entity
	if (abs(knockback_x) > 0 || abs(knockback_y) > 0) {return true; } else { return false; }
}