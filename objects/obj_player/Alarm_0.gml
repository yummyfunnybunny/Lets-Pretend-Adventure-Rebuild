/// @desc Death T_imer
// how long are you dead before restart_ing

if (hp <= 0) {
	// Game Over
	game_restart();
} else {
	state = player_state_respawn;
}