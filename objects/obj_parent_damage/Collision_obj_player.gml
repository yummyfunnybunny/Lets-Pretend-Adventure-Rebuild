//damage_player_collision();

if (other.faction == faction) { exit; }		// damage object belongs to same faction
if (other.id == creator) { exit; }			// player created this damage object
if (!check_z_overlap(other)) { exit; }		// no z-overlap
if (other.just_got_damaged) { exit; }		// player is temporarilly invincible from taking damage

knockback_apply(other, knockback_amount, other.knockback_reduction, point_direction(x,y,other.x,other.y));
other.player_take_damage(damage);
other.alarm[P_ALARM.DAMAGED] = FPS*3;

/*
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


