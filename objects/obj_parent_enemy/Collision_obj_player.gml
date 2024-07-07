if (!check_z_overlap(other)) exit;
if (other.just_got_damaged) exit;
if (other.main_state == main_state_death) exit;
if (main_state == main_state_death) exit;

knockback_apply(other, knockback_amount, 1, point_direction(x,y,other.x,other.y));
other.player_take_damage(damage);
other.alarm[P_ALARM.DAMAGED] = FPS*3;

