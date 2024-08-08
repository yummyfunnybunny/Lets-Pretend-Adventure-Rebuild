
function weighted_chance(_op1 = noone, _wt1 = 0, 
						 _op2 = noone, _wt2 = 0, 
						 _op3 = noone, _wt3 = 0, 
						 _op4 = noone, _wt4 = 0, 
						 _op5 = noone, _wt5 = 0, 
						 _op6 = noone, _wt6 = 0,
						 _op7 = noone, _wt7 = 0) {

	// Reset Needed Variables
	//if (argument_count > 0)		{ _op1 = argument[0];  }
	//if (argument_count > 1)		{ _wt1 = argument[1];  }
	//if (argument_count > 2)		{ _op2 = argument[2];  }
	//if (argument_count > 3)		{ _wt2 = argument[3];  }
	//if (argument_count > 4)		{ _op3 = argument[4];  }
	//if (argument_count > 5)		{ _wt3 = argument[5];  }
	//if (argument_count > 6)		{ _op4 = argument[6];  }
	//if (argument_count > 7)		{ _wt4 = argument[7];  }
	//if (argument_count > 8)		{ _op5 = argument[8];  }
	//if (argument_count > 9)		{ _wt5 = argument[9];  }
	//if (argument_count > 10)	{ _op6 = argument[10]; }
	//if (argument_count > 11)	{ _wt6 = argument[11]; }

	// set each item choice to roll on
	var _option;
	_option[0] = _op1;
	_option[1] = _op2;
	_option[2] = _op3;
	_option[3] = _op4;
	_option[4] = _op5;
	_option[5] = _op6;
	_option[5] = _op7;

	// set the total number of choices
	var _option_count = array_length(_option);

	// Set the weight for each choice
	var _weight;
	_weight[0] = _wt1;
	_weight[1] = _wt2;
	_weight[2] = _wt3;
	_weight[3] = _wt4;
	_weight[4] = _wt5;
	_weight[5] = _wt6;
	_weight[5] = _wt7;

	// Calculate the sum of all weights
	var _sum = 0;
	for(var _i = 0; _i < _option_count; _i++){
	  _sum += _weight[_i];
	}

	// Get a random number called "k"
	// This number will actually be 0, 1, 2, or 3, with a distribution based on the weights we've set
	var _rand = random(_sum);
	var _k = 0;
	for(var _i = _weight[0]; _i < _rand; _i += _weight[_k]){
	  _k++;
	}

	// Choose the item based on "k"
	var _option_picked = _option[_k];

	// Return the chosen option
	return _option_picked;
}

function reset_text() {
	draw_set_font(DEFAULT_FONT);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function get_dataset(_category) {
	switch(_category) {
		case "none":		return noone;					break;
		case "ammo":		return global.ammo_data;		break;
		case "armor":		return global.armor_data;		break;
		case "boots":		return global.boots_data;		break;
		case "collectible": return global.collectible_data;	break;
		case "consumable":	return global.consumable_data;	break;
		case "enemy":		return global.enemy_data;		break;
		case "powerup":		return global.powerup_data;		break;
		case "quest":		return global.quest_data;		break;
		case "trinket":		return global.trinket_data;		break;
		case "mainhand":	return global.mainhand_data;	break;
		case "offhand":		return global.offhand_data;		break;
	}
}

function enum_get_drop_img_idx(_category) {
	switch(_category) {
		case "ammo":		return AMMO_DATA.DROP_IMG_IDX;			break;
		case "armor":		return ARMOR_DATA.DROP_IMG_IDX;			break;
		case "boots":		return BOOTS_DATA.DROP_IMG_IDX;			break;
		case "collectible": return COLLECTIBLE_DATA.DROP_IMG_IDX;	break;
		case "consumable":	return CONSUMABLE_DATA.DROP_IMG_IDX;	break;
		case "powerup":		return POWERUP_DATA.DROP_IMG_IDX;		break;
		case "trinket":		return TRINKET_DATA.DROP_IMG_IDX;		break;
		case "mainhand":	return MAINHAND_DATA.DROP_IMG_IDX;		break;
		case "offhand":		return OFFHAND_DATA.DROP_IMG_IDX;		break;
	}
}

function enum_get_inv_img_idx(_category) {
	switch (_category) {
		case "armor":		return ARMOR_DATA.INV_IMG_IDX;			break;
		case "boots":		return BOOTS_DATA.INV_IMG_IDX;			break;
		case "collectible": return COLLECTIBLE_DATA.INV_IMG_IDX;	break;
		case "consumable":	return CONSUMABLE_DATA.INV_IMG_IDX;		break;
		case "trinket":		return TRINKET_DATA.INV_IMG_IDX;		break;
		case "mainhand":	return MAINHAND_DATA.INV_IMG_IDX;		break;
		case "offhand":		return OFFHAND_DATA.INV_IMG_IDX;		break;
	}
}

function enum_get_rarity(_category) {
	switch(_category) {
		case "armor":		return ARMOR_DATA.RARITY;			break;
		case "boots":		return BOOTS_DATA.RARITY;			break;
		case "collectible": return COLLECTIBLE_DATA.RARITY;		break;
		case "consumable":	return CONSUMABLE_DATA.RARITY;		break;
		case "trinket":		return TRINKET_DATA.RARITY;			break;
		case "mainhand":	return MAINHAND_DATA.RARITY;		break;
		case "offhand":		return OFFHAND_DATA.RARITY;			break;
	}
}

function enum_get_dmg_type(_category) {
	switch(_category){
		case "mainhand":	return MAINHAND_DATA.DMG_TYPE;		break;
		case "offhand":		return OFFHAND_DATA.DMG_TYPE;		break;
	}
}

function enum_get_elmt_type(_category){
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.ELMT_TYPE;		break;
		case "offhand":		return OFFHAND_DATA.ELMT_TYPE;		break;	
	}
}

function enum_get_dmg_amt(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.DMG_AMT;		break;
		case "offhand":		return OFFHAND_DATA.DMG_AMT;		break;		
	}
}

function enum_get_knockback(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.KNOCKBACK;		break;
		case "offhand":		return OFFHAND_DATA.KNOCKBACK;		break;		
	}
}

function enum_get_effect(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.EFFECT;		break;
		case "offhand":		return OFFHAND_DATA.EFFECT;			break;		
	}
}

function enum_get_wep_type(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.WEP_TYPE;		break;
		case "offhand":		return OFFHAND_DATA.WEP_TYPE;		break;		
	}
}

function enum_get_dmg_obj_spr(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.WEP_TYPE;		break;
		case "offhand":		return OFFHAND_DATA.WEP_TYPE;		break;		
	}
}

function enum_get_dmg_spr_idx(_category) {
	switch(_category) {
		case "mainhand":	return MAINHAND_DATA.DMG_SPR_IDX;		break;
		case "offhand":		return OFFHAND_DATA.DMG_SPR_IDX;		break;		
	}
}

function enum_get_item_name(_category) {
	switch(_category) {
		case "mainhand":		return MAINHAND_DATA.NAME;
		case "offhand":			return OFFHAND_DATA.NAME;
		case "armor":			return ARMOR_DATA.NAME;
		case "boots":			return BOOTS_DATA.NAME;
		case "collectible":		return COLLECTIBLE_DATA.NAME;
		case "consumable":		return CONSUMABLE_DATA.NAME;
		case "trinket":			return TRINKET_DATA.NAME;
	}
}

function enum_get_item_id(_category) {
	switch(_category) {
		case "mainhand":		return MAINHAND_DATA.ID;
		case "offhand":			return OFFHAND_DATA.ID;
		case "armor":			return ARMOR_DATA.ID;
		case "boots":			return BOOTS_DATA.ID;
		case "collectible":		return COLLECTIBLE_DATA.ID;
		case "consumable":		return CONSUMABLE_DATA.ID;
		case "trinket":			return TRINKET_DATA.ID;
	}
}
