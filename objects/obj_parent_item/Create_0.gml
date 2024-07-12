/// @desc

// Inherit the parent event
event_inherited();

#region SET VARIABLES

//item_data				= {}		// object that holds all the item data
move_speed				= 0;
float_curve				= animcurve_get_channel(ac_curve_item_idle,"curve1");
float_percent			= 0;
float_change			= (1/120);
image_speed				= 0;


#endregion



#region STATES

main_state_spawn = function() {
	// runs the initial spawning funtionality
	// set random movement, distance, bounce, etc.
	if (alarm[1] == -1) {
		direction = random(259);
		move_speed = .5;
		//z_bottom = -2;
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

function item_check_despawn() {
	if (alarm[0] == 0) {
		main_state = main_state_despawn;	
	}
}

function item_float() {
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
	switch (category) {
		case "ammo":
			sprite_index = spr_item_drop_ammo;
			image_index = ds_grid_get(global.ammo_data, AMMO_DATA.DROP_IMG_IDX, item_id); 
		break;
		case "powerup":
			sprite_index = spr_item_drop_powerup;
			image_index = ds_grid_get(global.powerup_data, POWERUP_DATA.DROP_IMG_IDX, item_id); 
		break;
		case "consumable":
			sprite_index = spr_item_drop_consumable;
			image_index = ds_grid_get(global.consumable_data, CONSUMABLE_DATA.DROP_IMG_IDX, item_id); 
		break;
		case "collectible":
			sprite_index = spr_item_drop_collectible;
			image_index = ds_grid_get(global.collectible_data, COLLECTIBLE_DATA.DROP_IMG_IDX, item_id); 
		break;
		case "weapon":
			sprite_index = spr_item_drop_weapon;
			image_index = ds_grid_get(global.weapon_data, WEP_DATA.DROP_IMG_IDX, item_id); 
		break;
	}
}

function item_pickup() {
	switch (category) {
		case "ammo":		item_pickup_ammo();			break;
		case "powerup":		item_pickup_powerup();		break;
		case "consumable":	item_pickup_consumable();	break;	
		case "collectible": item_pickup_collectible();	break;	
		case "weapon":		item_pickup_weapon();		break;	
	}
}

function item_pickup_ammo() {
	var _ammo_type = ds_grid_get(global.ammo_data, AMMO_DATA.AMMO_TYPE, item_id);
	var _ammo_amt = ds_grid_get(global.ammo_data, AMMO_DATA.AMMO_AMT, item_id);
	switch (_ammo_type) {
		case "hp":			other.hp += _ammo_amt;			break;
		case "mo":			other.mp += _ammo_amt;			break;
		case "coins":		other.coins += _ammo_amt;		break;
		case "arrows":		other.arrows += _ammo_amt;		break;
		case "axes":		other.axes += _ammo_amt;		break;
		case "bullets":		other.bullets += _ammo_amt;		break;
	}
}

function item_pickup_powerup() {
	// apply powerup function
}

function item_pickup_consumable() {
	// add consumable to inventory
}

function item_pickup_collectible() {
	// add collectible to appropriate inventory section
}

function item_pickup_weapon() {
	// add weapon to inventory
}

#endregion

#region SET INITIAL STATE

main_state = main_state_spawn;
item_set_sprite();

#endregion

