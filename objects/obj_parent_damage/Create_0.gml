event_inherited();

#region INIT DAMAGE SET VARIABLES

if (damage_object_duration != 0) { alarm[0] = FPS * damage_object_duration; }
image_rotation = 0;

#endregion

#region INIT DAMAGE HELPER FUNCTIONS

function damage_pre_damage_check() {
	if (!check_z_overlap(other)) { return false; }		// no z-overlap
	show_debug_message("passed z overlap");
	if (other.id == creator) { return false; }			// player created this damage object
	if (other.faction == faction && other.faction != FACTION_TYPE.NONE) { return false; }		// damage object belongs to same faction
	if (object_is_ancestor(other.object_index, obj_parent_prop)) {
		if (other.can_kill == false) { return false; }
	}
	if (other.just_got_damaged) { return false; }		// player is temporarilly invincible from taking damage
	if (other.main_state = other.main_state_death) { return false; }	// entity is already dead
	if (other.layer != layer) { exit; }					// not on the same level
	return true;
}

function damage_wall_check() {
	var _terrain = tilemap_get_at_pixel(global.collision_map,x,y);
	
	// Shallow Water
	if (_terrain == 1) {
		instance_destroy();
	}
}

function damage_ground_check() {
	if (on_ground == true) {
		instance_destroy();	
	}
}

function damage_rotate_image() {
	if (image_rotation == 0) { exit; }
	image_angle += image_rotation;	
}

function damage_set_rotation() {
	switch(direction) {
		case 0: image_rotation = -15;	break;
		case 90: image_rotation = -15;	break;
		case 180: image_rotation = 15;	break;
		case 270: image_rotation = 15;	break;
	}	
}

#endregion