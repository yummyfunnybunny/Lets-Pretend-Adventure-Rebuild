/// @desc initialize

// Inherit the parent event
event_inherited();

#region FUNCTIONS

function enemy_turtle1_damage() {
	if (has_shell == true) {
		if (damage_modifier(apply_damage.damage_type, id, shell_immune_array) == false) {
			// remove shell
			var _dir = point_direction(target.x,target.y,x,y);
			shell_id = instance_create_layer(x,y,global.main_layer,obj_shell,{
				direction: _dir + (choose(65,-65)),
				creator: id
			});
			origin_x = shell_id.x;
			origin_y = shell_id.y;
			sprite_idle = spr_turtle1_idle2;
			sprite_move = spr_turtle1_move2;
			has_shell = false;
			enemy_end_damage(0);
		} else {
			// immune = true - no damage - finalize
			enemy_end_damage(0);
		}
	} else {
		// no shell - apply damage
		var _damage = apply_damage.damage;
		// check vulnerabilities
		if (damage_modifier(apply_damage.damage_type, id, vulnerable_array) == true) { _damage *= round(_damage*2); }
		// check resistances
		if (damage_modifier(apply_damage.damage_type, id, resistance_array) == true) {	_damage /= round(_damage*2); }
		enemy_end_damage(_damage);
	}
}

#endregion

#region CALCULATION VARIABLES

has_shell = true;
shell_immune_array = [DAMAGE_TYPE.SLASH];
shell_id = noone;
damage_script = enemy_turtle1_damage;

#endregion










