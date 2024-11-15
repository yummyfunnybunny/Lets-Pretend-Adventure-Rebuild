event_inherited();

#region SET VARIABLES
//weapon_data = noone;
//creator = noone;
//faction = noone;

#endregion

#region SET STATES

main_state_alive = function() {
	if (alarm[PROP_ALARM.DEATH] = -1) {
		alarm[PROP_ALARM.DEATH] = FPS * 3;	
	}
	if (alarm[PROP_ALARM.DEATH] == 0) {
		// create the explosion damage object
		main_state = main_state_death;
	}
}

main_state_death = function() {
	prop_create_explosion();
	instance_destroy();
}

#endregion

#region HELPER FUNCTIONS

function prop_create_explosion() {
	// get all needed data to pass to damage object
	var _category = weapon_data.category;
	var _weapon_id = weapon_data.item_id;
	
	
	// get the DB and data types to pull from
	var _dataset = get_dataset(_category);
	var _dmg_type_data = enum_get_dmg_type(_category);
	var _elmt_type_data = enum_get_elmt_type(_category);
	var _dmg_amt_data = enum_get_dmg_amt(_category);
	var _kb_data = enum_get_knockback(_category);
	var _effect_data = enum_get_effect(_category);
	var _wep_type_data = enum_get_wep_type(_category);
	var _dmg_obj_spr_data = enum_get_dmg_obj_spr(_category);
	var _dmg_spr_idx_data = enum_get_dmg_spr_idx(_category);
	
	// get variables to pass to the damage object
	//var _faction = faction;
	//var _creator = creator;
	//var _face_dir = face_direction;
	var _dmg_type = ds_grid_get(_dataset, _dmg_type_data, _weapon_id);
	var _element_type = ds_grid_get(_dataset, _elmt_type_data, _weapon_id);
	var _dmg_amt = ds_grid_get(_dataset, _dmg_amt_data, _weapon_id);
	var _knockback =  ds_grid_get(_dataset, _kb_data, _weapon_id);
	var _special_effect = ds_grid_get(_dataset, _effect_data, _weapon_id);
	
	// determine which damage object to create
	var _wep_type = ds_grid_get(_dataset, _wep_type_data, _weapon_id);
	_wep_type = asset_get_index("obj_damage_" + string(_wep_type));
	
	// get the sprite to set for the damage object
	var _sprite = ds_grid_get(_dataset, _dmg_spr_idx_data, _weapon_id);
	_sprite = asset_get_index(_sprite);
	if (!_sprite) { _sprite = asset_get_index("spr_damage_melee"); }
	
	
	// create the damage object
	instance_create_layer(x, y, layer, obj_damage_explosion, {
		faction: faction,
		creator: creator,
		image_angle: 0,
		direction: 0,
		sprite_index: _sprite,
		damage_type: _dmg_type,
		element_type: _element_type,
		damage: _dmg_amt,
		knockback_amount: _knockback,
		special_effect: _special_effect,
	});	
}

#endregion

#region STARTING STATE

main_state = main_state_alive;

#endregion