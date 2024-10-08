/// @desc

// Inherit the parent event
event_inherited();

#region SET VARIABLES

//item_data				= {}		// object that holds all the item data
move_speed				= 0;
float_curve				= animcurve_get_channel(ac_curve_item_idle,"curve1");
float_percent			= 0;
float_change			= float_amount;
image_speed				= 0;
interact_target			= noone;
interact_range			= 1;

#endregion



#region STATES

main_state_spawn = function() {
	// runs the initial spawning funtionality
	// set random movement, distance, bounce, etc.
	if (alarm[1] == -1) {
		direction = random(259);
		move_speed = run_speed;
		on_ground = false;
		z_speed = -z_jump_speed;
		alarm[1] = -2;
	}
	
	if (alarm[1] == -2 && on_ground) {
		move_speed = 0;
		alarm[1] = -1;
		if (despawn_time > 0) { alarm[0] = FPS * despawn_time; } // setting to 0 disables the despawn timer
		main_state = main_state_idle;
		
	}
}

main_state_idle = function() {
	// the normal state that the item sits in while waiting for despawn
	// or to be picked up by the player

	// float item up and down
	item_float();
	
}

main_state_despawn = function() {
	// run the despawn state once the timer runs out
	
	// set fade out timer
	if (alarm[1] == -1) {
		alarm[1] = FPS * 1;
	}
	
	item_float();
	
	// fade out
	image_alpha = ((alarm[1]*100)/60)/100;
	
	// destroy item
	if (alarm[1] == 0) {
		instance_destroy();	
	}
}

#endregion



#region HELPER FUNCTIONS

function item_update_movement() {
	if (knockback_check()) { exit; }
	x_speed = lengthdir_x(move_speed, direction);
	y_speed = lengthdir_y(move_speed, direction);
}

function item_check_for_empty_bag_slot() {
	var _bag = global.player.bag;
	var _bag_w = array_length(global.player.bag[0]);
	var _bag_h = array_length(global.player.bag);
	for (var _i = 0; _i < _bag_h; _i++) {
		for (var _j	= 0; _j < _bag_w; _j++) {
			if (_bag[_i][_j].item_id == 0) {
				return _bag[_i][_j];
			}
		}
	}
	return false;
}

function item_interact_input_progression() {
	// search bag for empty slot
	var _empty_slot = item_check_for_empty_bag_slot();
	
	// if there is an empty slot, add item to bag
	if (_empty_slot != false) {
		// set bag slot to item picked up
		_empty_slot.category = category;
		_empty_slot.item_id = item_id;
		
		// send broadcast
		var _broadcast = new ItemPickupBroadcast(category, item_id, "gather");
		array_push(global.quest_tracker.broadcast_receiver, _broadcast);
	
		// TODO - play sound
	
		// destroy item
		instance_destroy();
		
	} else {
		// no empty slots, can't pick up
		// - play sound effect?
	}
}

function item_set_interact_type() {
	switch(category) {
		case "ammo" : 
		case "powerup":
			interact_type = INTERACT_TYPE.NONE; break;
		case "mainhand":
		case "offhand":
		case "armor":
		case "boots":
		case "trinket":
		case "collectible":
		case "consumable":
			interact_type = INTERACT_TYPE.PICKUP; break;
	}
}

function item_check_despawn() {
	if (alarm[0] == 0) {
		main_state = main_state_despawn;	
	}
}

function item_float() {
	if (float_change == 0) { exit; }
	// float item up and down
	float_percent += float_change;
	if (float_percent >= 1) {
		float_change = -(1/120);
	}
	if (float_percent <= 0) {
		float_change = (1/120);	
	}
	var _position = animcurve_channel_evaluate(float_curve, float_percent);
	z_bottom = -1 * (8 * _position);
}

function item_set_sprite() {
	var _dataset = get_dataset(category);
	var _img_idx_col = enum_get_drop_img_idx(category);
	var _sprite = asset_get_index($"spr_item_drop_{category}");
	sprite_index = _sprite;
	image_index = ds_grid_get(_dataset,_img_idx_col, item_id);
}

function item_pickup() {
	switch (category) {
		case "ammo":		item_pickup_ammo();			break;
		case "powerup":		item_pickup_powerup();		break;
	}
}

function item_pickup_ammo() {
	var _ammo_type = ds_grid_get(global.ammo_data, AMMO_DATA.AMMO_TYPE, item_id);
	var _ammo_amt = ds_grid_get(global.ammo_data, AMMO_DATA.AMMO_AMT, item_id);
	var _p = global.player;
	switch (_ammo_type) {
		case "hp":			_p.stats.hp += _ammo_amt;			break;
		case "mp":			_p.stats.mp += _ammo_amt;			break;
		case "coins":		_p.ammo.coins += _ammo_amt;			break;
		case "arrows":		_p.ammo.arrows += _ammo_amt;		break;
		case "axes":		_p.ammo.axes += _ammo_amt;			break;
		case "bullets":		_p.ammo.bullets += _ammo_amt;		break;
	}
}

function item_pickup_powerup() {
	// apply powerup function
}

function item_interact_set_target() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (main_state != main_state_idle) { exit; }
	if (!instance_exists(interact_target)) {
		if (instance_exists(obj_parent_player)){
			interact_target = instance_nearest(x,y,obj_parent_player);	
		} else if (interact_target != noone) {
			interact_target = noone;
		}
	}
	
	if (instance_exists(interact_target)) {
		if (interact_target.main_state == obj_parent_player.main_state_death) {
			if (interact_target != noone) { interact_target = noone; }
		}
	}
}

function item_interact_check_interact_range() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	var _dis = point_distance(x,y,interact_target.x,interact_target.y);
	if (_dis <= interact_range*COL_TILES_SIZE) {
		interact_target.interact_target = id;
	} else {
		if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
	}
}

function item_interact_draw_icon() {
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.interact_target != id) { exit; }
	
	switch(interact_type) {
		case INTERACT_TYPE.PICKUP: draw_sprite(spr_interact_pickup,-1,x,y-z_height);	break;
	}
}

function item_drift_to_player() {
	if (main_state == main_state_spawn) { exit; }
	if (interact_type != INTERACT_TYPE.NONE) { exit; }
	
	var _player = instance_nearest(x,y,obj_parent_player);
	var _dis = point_distance(x,y,_player.x, _player.y);
	if (_dis <= COL_TILES_SIZE*1.5) {
		alarm[0] = alarm_get(0);
		if (run_speed != 1) { run_speed = 1.5; }
		direction = point_direction(x,y,_player.x,_player.y);
		x_speed += lengthdir_x(run_speed, direction);
		y_speed += lengthdir_y(run_speed, direction);
	}
	
}

#endregion

#region SET INITIAL STATE

main_state = main_state_spawn;
item_set_sprite();
item_set_interact_type();

#endregion

