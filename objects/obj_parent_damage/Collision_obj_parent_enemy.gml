if (damage_pre_damage_check() == false) { exit; }

knockback_apply(other, knockback_amount, other.knockback_reduction, point_direction(creator.x,creator.y,other.x,other.y));
other.enemy_take_damage(damage, damage_type, element_type, special_effect);
