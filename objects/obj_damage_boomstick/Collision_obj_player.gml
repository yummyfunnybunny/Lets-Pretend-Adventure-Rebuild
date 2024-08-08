/// @description Insert description here
// You can write your code in this editor

if (creator != other.id) {
if (other.just_got_damaged == false) {
	knockback_apply(other, knockback_amount, 1, 1);
	enemy_apply_damage_to_player(damage);
	//other.hp -= damage;
	other.just_got_damaged = true;
	other.alarm[2] = FPS*1;
}
}

if (creator != other.id) {
	if (damage_type == DAMAGE_TYPE.PIERCE) {
		instance_destroy();	
	}
}



