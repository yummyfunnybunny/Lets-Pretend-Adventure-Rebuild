if (other.faction == faction) { exit; }		// damage object belongs to same faction
if (other.id == creator) { exit; }			// player created this damage object
if (!check_z_overlap(other)) { exit; }		// no z-overlap
if (other.just_got_damaged) { exit; }		// player is temporarilly invincible from taking damage
if (other.main_state = other.main_state_death) { exit; }

knockback_apply(other, knockback_amount, other.knockback_reduction, point_direction(x,y,other.x,other.y));
other.player_take_damage(damage);
other.alarm[P_ALARM.DAMAGED] = FPS*3;


