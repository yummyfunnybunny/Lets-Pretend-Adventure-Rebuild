/// @desc initialize enemy
event_inherited();

#region CALCULATION VARIABLES

faction = FACTION.ENEMY;
hp = max_hp;
mp = max_mp;
armor = max_armor;
move_speed = 0;
apply_damage = 0;
target = noone;
align_x = 0;
align_y = 0;
damage_script = undefined;

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

