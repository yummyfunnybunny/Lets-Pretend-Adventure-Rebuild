
event_inherited();

#region SET VARIABLES

//stats
hp = max_hp;
armor = max_armor;
extra_damage_check = noone;
just_got_damaged = false;
move_speed = 0;

//item_drops = [];

#endregion


#region ALARMS



#endregion



#region SET STATES

// main states
main_state_alive =  function(){}
main_state_death = function(){
	if (alarm[0] == -1) {
		//global.enemy_count--;
		x_speed = 0;
		y_speed = 0;
		move_speed = 0;
		//image_index = 0;
		alarm[0] = 1;
	}
	
	// destroy enemy
	if (alarm[0] == 0) {
		prop_drop_items();
		instance_destroy();
	}
}

// nest states
nest_state_idle = function(){}
nest_state_hurt = function(){
	if (knockback_check()) { exit; }
	nest_state = nest_state_idle;
}
nest_state_death_normal = function(){}
nest_state_death_drown = function(){}
nest_state_death_pitfall = function(){}

#endregion



#region HELPER FUNCTIONS

function prop_drop_items() {
	var _len = array_length(item_drops);
	if (_len > 0) {
		// set drops
		for (var _i = 0; _i < _len; _i++) {
			repeat(item_drops[_i].qty) {
				var _item = instance_create_layer(x,y,INSTANCES_1_LAYER, obj_parent_item, {
					category: item_drops[_i].category,
					item_id: item_drops[_i].item_id,
				});
			}
		}
	} else {
		// random drops
		
	}
}

function prop_take_damage(_damage, _damage_type, _element_type, _special_effect) {
	//show_debug_message("taking damage");
	if (just_got_damaged) { exit; }
	
	// check immunities
	if (damage_check_modifiers(_damage_type, _element_type, damage_immunities, element_immunities) == true) { _damage = 0; }
	
	// run extra damage check
	if (extra_damage_check) { script_execute(extra_damage_check); }
	
	// check resistances
	if (damage_check_modifiers(_damage_type, _element_type, damage_resistances, element_resistances) == true) { _damage /= round(_damage*2); }
	
	// check vulnerabilities
	if (damage_check_modifiers(_damage_type, _element_type, damage_vulnerabilities, element_vulnerabilities) == true) { _damage *= round(_damage*2); }
	
	// check armor
	_damage = damage_check_armor(_damage);
	
	// run special effect
	if (_special_effect) { script_execute(_special_effect); }
	
	// finalize damage
	if (_damage > 0) {
		show_debug_message("taking damage");
		show_debug_message(hp);
		hp -= _damage;
		just_got_damaged = true;
		//alarm[ALARM.ATK_START] = -1;		// cancels an attack if one was underway
		alarm[1] = FPS*0.5;
		//alarm[ALARM.STATE] = 1;
		nest_state = nest_state_hurt;
		
		// play damage sound
	} else {
		// play block/resist/immune sound	
	}
}

function prop_knockback_check() {
	if (knockback_check() == true) {
		if (nest_state != nest_state_hurt) { nest_state = nest_state_hurt; }	
	} else {
		if (nest_state == nest_state_hurt) {
			nest_state = nest_state_idle;
		}
	}
}

function prop_death_check() {
	if (nest_state = nest_state_hurt) { exit; }
	if (main_state = main_state_death) { exit; }
	if (hp <= 0) {
		main_state = main_state_death;
		nest_state = nest_state_death_normal;
	}	
}

function prop_update_terrain_state() {
	var _terrain = tilemap_get_at_pixel(global.collision_map,x,y);

	// Shallow Water
	if (_terrain == 2) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.SHALLOW_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.SHALLOW_WATER) { terrain_state = TERRAIN_TYPE.NONE }
		
	}
	
	// Deep Water
	if (_terrain == 3) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.DEEP_WATER; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.DEEP_WATER) { terrain_state = TERRAIN_TYPE.NONE } 
		
	}
	
	// ladder
	if (_terrain == 4) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.LADDER; }
	} else {
		if (terrain_state == TERRAIN_TYPE.LADDER) { terrain_state = TERRAIN_TYPE.NONE }
	}
	
	// Tall Grass
	if (_terrain == 5) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.TALL_GRASS; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.TALL_GRASS) { terrain_state = TERRAIN_TYPE.NONE } 
	}

	// PitFall
	if (_terrain == 6) {
		if (!on_ground) { exit; }
		if (terrain_state != TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.PITFALL; }
	} else { 
		if (terrain_state == TERRAIN_TYPE.PITFALL) { terrain_state = TERRAIN_TYPE.NONE }
	}
}

function prop_terrain_effect() {
	switch (terrain_state) {
		case TERRAIN_TYPE.SHALLOW_WATER: 
			main_state = main_state_death;
			nest_state = nest_state_death_drown;
		break;
		case TERRAIN_TYPE.DEEP_WATER:	
			main_state = main_state_death;
			nest_state = nest_state_death_drown;
		break;
		case TERRAIN_TYPE.LADDER:		
					
		break;
		case TERRAIN_TYPE.TALL_GRASS:	
				
		break;
		case TERRAIN_TYPE.PITFALL:		
			main_state = main_state_death;
			nest_state = nest_state_death_pitfall;		
		break;
		default: /* nothing */ break;
	}
}



#endregion



#region STARTING STATE

main_state = main_state_alive;
nest_state = nest_state_idle;

#endregion