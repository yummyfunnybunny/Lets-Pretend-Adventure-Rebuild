/// @desc

// Inherit the parent event
event_inherited();

#region SET MAIN STATES

main_state_unaware = function() {
	enemy_aggro_range_check();
	enemy_origin_distance_check();
}

main_state_aware = function() {
	enemey_attack_range_check();
	enemy_origin_distance_check();
}

main_state_death = function() {
	
}
#endregion

#region SET NEST STATES
choose_state = function(){
	var _chosen_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	main_state = main_state_unaware;
	nest_state = _chosen_state;
};
main_state_unaware			= function(){
	enemy_aggro_range_check();
	enemy_origin_distance_check();
};
main_state_aware			= function(){
	enemey_attack_range_check();
	enemy_origin_distance_check();
};

nest_state_wait				= function(){};
nest_state_idle				= function(){};
nest_state_wander			= function(){};
nest_state_sleep			= function(){};
nest_state_patrol			= function(){};

nest_state_chase			= function(){};
nest_state_attack			= function(){};
nest_state_flee				= function(){};
nest_state_align			= function(){};

nest_state_return_origin	= function(){};
nest_state_death			= function(){};
nest_state_hurt				= function(){};
nest_state_react			= function(){};

#endregion

#region SET STARTING STATES

main_state = main_state_unaware;
nest_state = nest_state_idle;

#endregion