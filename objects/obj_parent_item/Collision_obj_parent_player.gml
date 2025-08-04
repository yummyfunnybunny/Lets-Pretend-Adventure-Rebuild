if (!check_z_overlap(id, other)) exit;
if (other.main_state == other.main_state_death) exit;
if (main_state != main_state_idle) exit;
if (interact_type == INTERACT_TYPE.PICKUP) { exit; }	// dont automatically pickup unless its ammo

// play sound
item_pickup();
instance_destroy();
