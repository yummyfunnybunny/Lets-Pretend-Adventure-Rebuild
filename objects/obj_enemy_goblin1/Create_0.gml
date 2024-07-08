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

#endregion

#region SET NEST STATES

choose_state = function() {
	var _chosen_state = weighted_chance(nest_state_idle, idle_weight, nest_state_wander, wander_weight);
	main_state = main_state_unaware;
	nest_state = _chosen_state;
}

nest_state_wait = function() {
	if (image_speed != 1) image_speed = 1;
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		choose_state();
	}
}

nest_state_idle = function() {
	if (image_speed != 1) image_speed = 1;
	
	// begin idle
	if (alarm[ALARM.STATE] == -1) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		alarm[ALARM.STATE] = FPS * 2;
	}
	
	// end idle
	if (alarm[ALARM.STATE] == 0) {
		choose_state();
	}
}

nest_state_wander = function() {
	
	// set image
	if (image_speed != 1) image_speed = 1;
	
	// begin wander
	if (alarm[ALARM.STATE] == -1) {
		alarm[ALARM.STATE] = FPS * 2;
		direction = choose (0,45,90,135,180,225,270,315);
		move_speed = walk_speed;
	}
	
	// TODO - avoid water, pitfalls, and walls
	
	// end wander
	if (alarm[ALARM.STATE] == 0) {
		move_speed = 0;
		x_speed = 0;
		y_speed = 0;
		choose_state();
	}
}

nest_state_chase = function() {
	if (!instance_exists(target)) { exit; }
	direction = point_direction(x,y,target.x,target.y);
	if (move_speed != run_speed) move_speed = run_speed;
}

nest_state_hurt = function() {
	if (knockback_check()) { exit; }
	//if (knockback_check() == true) {
		//goblin1_choose_state();	
		nest_state = nest_state_wait;
	//}	
}

nest_state_flee = function() {
	// run away from target
	// search for hiding spots?
	// run towards allied units
		// once allied units are found, attack player again
}

nest_state_return_origin = function() {
	
	// create pather
	if (!pather_object) {
		pather_object = instance_create_depth(x,y,INSTANCE_DEPTH,obj_con_pather,{
			creator: id,
			path: noone,
			move_speed: run_speed,
			target_x: origin_x,
			target_y: origin_y,
			path_end_action: path_action_stop,
		});
	}
	
	// follow pather
	if (pather_object) {
		//if (target != pather_object) { target = pather_object; }
		if (move_speed != run_speed) { move_speed = run_speed; }
		direction = point_direction(x,y,pather_object.x,pather_object.y);
	}
	
	// end once origin is reached
	if (point_distance(x,y,origin_x,origin_y) <= COL_TILES_SIZE) {
		instance_destroy(pather_object);
		pather_object = noone;
		main_state = main_state_unaware;
		nest_state = nest_state_wait;
	}
}

#endregion

#region SET STARTING STATES

main_state = main_state_unaware;
nest_state = nest_state_idle;

#endregion