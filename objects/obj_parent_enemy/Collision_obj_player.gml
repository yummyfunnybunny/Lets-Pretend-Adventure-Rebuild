if (check_z_overlap(other) == true) {
	if (other.just_got_damaged == false) {
		if (nest_state != enemy_state_death) {
			other.just_got_damaged = true;
			enemy_apply_damage_to_player(damage);
			apply_knockback(other, knockback_amount, 1, point_direction(x,y,other.x,other.y));
			other.alarm[2] = FPS*1;
		}
	}
}



