
if (damage_pre_damage_check() == false) { exit; }
show_debug_message("applying damage");

knockback_apply(other, knockback_amount, other.knockback_reduction, point_direction(x,y,other.x,other.y));
other.prop_take_damage(damage, damage_type, element_type, special_effect);