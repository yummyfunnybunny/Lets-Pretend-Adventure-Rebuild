

if (check_z_overlap(other) == true && other.just_got_damaged == false) {
	other.just_got_damaged = true;
	enemy_apply_damage_to_player(damage);
	apply_knockback(other, knockback_amount, 1, 1);
	other.alarm[2] = FPS*1;
}



