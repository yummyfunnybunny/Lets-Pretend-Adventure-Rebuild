


/*
function _in_it_ial_ize_z_sol_id(_z_height){
	z_bottom		= -1;				// z coord_inate of the bottom of the object
	z_height		= _z_height			// how tall the object _is
	z_top		= z_bottom-z_height;	// z coord_inates of the top of the object
	z_floor		= -1;				// z coord_inate of the current floor pos_it_ion below the object
	z_roof		= -room_height;		// z coord_inate of the current c_iel_ing aabove the target
}

function _in_it_ial_ize_z_movement(_z_grav_ity,_z_max_fall_speed,_z_step_up,_z_jump_speed,_zBounce,_zWe_ight){
	z_grav_ity		= _z_grav_ity;		// equ_iv_ilant of acceleration for x and y movement
	z_max_fall_speed	= _z_max_fall_speed;	// max_imum speed object can fall
	z_step_up			= _z_step_up;			// how h_igh of a wall the object can walk over before need_ing to jump
	z_jump_speed		= _z_jump_speed;		// how h_igh the object can jump
	zBounce			= _zBounce;			// how much bounce there _is when the object h_its the ground
	zWe_ight			= _zWe_ight;			// used _in the bounce and knockback algor_ithms to d_ictate d_istances
	z_speed			= 0;				// current vert_ical speed of the object
	z_prev		= 0;				// objects prev_ious z coord_inate		
	on_top_of			= noone;			// tells the object what object _is above _it, if any
	below_of			= noone;			// tells the object what object _is below _it, if any
	on_ground		= true;				// tells you if the object _is on the ground or not
}

