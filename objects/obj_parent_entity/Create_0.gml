

#region CALCULATION VARIABLES

// z-axis
z_top				= z_bottom - z_height;		// gives us the top of the instance
z_floor				= -1;						// sets the current floor
z_roof				= -room_height;				// sets the current roof
z_speed				= 0;						// current vertical speed
z_prev				= -1;						// previous z-position
on_top_of			= noone;					// id of instance we are above, used to altar z_floor
below_of			= noone;					// id of instance we are below, used to alar z_roof
on_ground			= true;						// boolean - are we on the ground or not
//z_height			= 0;						// sets the height of the instance on the z-axis
//z_gravity			= 0.5;						// sets how quickly instance falls when in the air


// basics
x_speed				= 0;						// current x-axis speed
y_speed				= 0;						// current y-axis speed
knockback_x			= 0;						// current x-axis knockback speed
knockback_y			= 0;						// current y-axis knockback speed
knockback_z			= 0;						// current z-axis knockback speed
origin_x			= x;						// starting x-position
origin_y			= y;						// starting y-position
pather_object		= noone;					// id of the pathing object to follow when using paths
just_got_damaged	= 0;						// starts temporary invulnerability after taking damage

//shadow_index		= -1;						// sets the sprite index for the shadow; -1 = no shadow
//shadow_always		= false;					// sets wheter or not to always show shadow
//entity_solid		= false;					// sets whether entity detects collisions with other instances



#endregion

#region FUNCTIONS

#endregion

