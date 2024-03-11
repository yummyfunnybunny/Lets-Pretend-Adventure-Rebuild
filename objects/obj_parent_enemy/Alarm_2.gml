/// @description just got damaged alarm

// prevents getting knockbacked while dead
if (nest_state != player_state_death) {
	just_got_damaged = false;
	apply_damage = 0;
}


