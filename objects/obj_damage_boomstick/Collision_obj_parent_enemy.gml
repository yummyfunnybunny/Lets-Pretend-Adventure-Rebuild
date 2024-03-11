/// @description damage enemies

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


