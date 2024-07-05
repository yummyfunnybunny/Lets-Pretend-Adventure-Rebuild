/// @desc initialize enemy
event_inherited();

#region CALCULATION VARIABLES

faction				= FACTION.ENEMY;		// set the faction of the instance
hp					= max_hp;				// set hp to max hp
mp					= max_mp;				// set mp to max mp
armor				= max_armor;			// set armor to max armor
move_speed			= 0;					// set max move speed
apply_damage		= 0;					// holds an object of all the damage specs when dealing damage to another instance 
target				= noone;				// id of current target to chase/attack
align_x				= 0;					// sets x-position to for aligning a certain way to target for attacks
align_y				= 0;					// sets y-position for aligning a certain way to target for attacks
damage_script		= undefined;			// 

// Alarms

enum ALARM {
	DEATH,
	STATE,
	DAMAGED,
	ATK_START,
	ATK_END,
	COUNT,
}


#endregion

#region FUNCTIONS

#endregion


