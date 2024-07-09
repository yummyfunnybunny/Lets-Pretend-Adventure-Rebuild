// Inherit the parent event
event_inherited();
if (main_state == main_state_death) exit;
enemy_collide_with_player(main_state_unaware, nest_state_wait);