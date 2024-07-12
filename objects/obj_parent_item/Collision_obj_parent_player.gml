if (!check_z_overlap(other)) exit;
if (other.main_state == other.main_state_death) exit;
if (main_state != main_state_idle) exit;

// play sound
item_pickup();
instance_destroy();
