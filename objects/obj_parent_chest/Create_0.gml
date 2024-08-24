event_inherited();

#region SET VARIABLES

lock					= noone;
interact_type			= INTERACT_TYPE.INTERACT;
interact_target			= noone;
interact_range			= 1.5;
open_curve				= animcurve_get_channel(ac_curve_chest_opening,"curve1");
open_percent			= 0;
open_change				= 1/60;
image_speed				= 0;
image_index				= 0;

#endregion


#region ALARMS


#endregion



#region DEFAULT STATES

main_state_closed = function() {
	
}

main_state_opening = function() {

	// begin opening 
	open_percent += open_change;
	var _position = animcurve_channel_evaluate(open_curve, open_percent);
	image_index = image_number*_position;
	
	// end opening
	if (open_percent >= 1) {
		image_index = image_number-1;
		chest_drop_items();
		main_state = main_state_opened;
	}
}

main_state_opened = function() {
}

#endregion



#region HELPER FUNCTIONS

function chest_interact_set_target() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (main_state != main_state_closed) { exit; }
	if (!instance_exists(interact_target)) {
		if (instance_exists(obj_parent_player)){
			interact_target = instance_nearest(x,y,obj_parent_player);	
			show_debug_message("chest set interact target");
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

function chest_interact_range_check() {
	if (interact_type == INTERACT_TYPE.NONE) { exit; }
	if (main_state != main_state_closed) { exit; }
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.layer != layer) { exit; }
	var _dis = point_distance(x,y,interact_target.x,interact_target.y);
	if (_dis <= interact_range*COL_TILES_SIZE) {
		interact_target.interact_target = id;
	} else {
		if (interact_target.interact_target == id) { interact_target.interact_target = noone; }
	}
}

function chest_interact_draw_icon() {
	if (!instance_exists(interact_target)) { exit; }
	if (interact_target.interact_target != id) { exit; }
	if (main_state != main_state_closed) { exit; }
	
	draw_sprite(spr_interact_pickup,0,x,y-z_height - 8);
}

function chest_interact_input_progression() {
	if (main_state != main_state_closed) { exit; }
	
	if (main_state == main_state_closed) {
		// check if a key is needed
		// - yes -> check if player has key
			// - yes -> open check
			// - no -> don't open chest
		// - no -> open chest
		if (lock == noone) {
			main_state = main_state_opening;	
		} else {
			// do the check for the key	
		}
	}
}

function chest_drop_items() {
	var _len = array_length(item_drops);
	if (_len > 0) {
		for (var _i = 0; _i < _len; _i++) {
			repeat(item_drops[_i].qty) {
				var _item = instance_create_layer(x,y,INSTANCES_1_LAYER, obj_parent_item, {
					category: item_drops[_i].category,
					item_id: item_drops[_i].item_id,
				});
			}
		}
	}
}

#endregion

#region SET STARTING STATE

main_state = main_state_closed;

#endregion