/// @description damage enemies

if (other.faction == faction) { exit; }		// damage object belongs to same faction
if (other.id == creator) { exit; }			// player created this damage object
if (!check_z_overlap(other)) { exit; }		// no z-overlap
if (other.just_got_damaged) { exit; }		// player is temporarilly invincible from taking damage

knockback_apply(other, knockback_amount, other.knockback_reduction, point_direction(x,y,other.x,other.y));
other.enemy_take_damage(damage, damage_type, element_type, special_effect);
//other.alarm[P_ALARM.DAMAGED] = FPS*.5;

// apply damage
/*
if (check_z_overlap(other)) {
	if (other.apply_damage == 0) {
		other.apply_damage = {
			faction: faction,
			damager: id,
			damager_creator: creator,
			damage_type: damage_type,
			damage: damage,
			knockback_amount: knockback_amount,
		}
	}
}
*/

/*
// make any checks that would prevent ANY damage/knockback from being applied
if (check_z_overlap(other)) {
	if (creator != other.id) {
		if (faction != other.faction) {
			if (other.just_got_damaged == false) {
				other.apply_damage = {
					faction: faction,
					damager: id,
					damager_creator: creator,
					damage_type: damage_type,
					damage: damage,
					knockback_amount: knockback_amount,
				}
			}
		}
	}
}


