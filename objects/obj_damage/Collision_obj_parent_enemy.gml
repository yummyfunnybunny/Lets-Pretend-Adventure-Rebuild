/// @description damage enemies

if (creator != other.id) {
if (other.just_got_damaged == false) {
	apply_knockback(other, knockback_amount, 1, 1);
	other.hp -= damage;
	other.just_got_damaged = true;
	other.alarm[2] = FPS*.1;
	other.state = enemy_state_wait;
}
}

