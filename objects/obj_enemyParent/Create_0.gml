/// @desc ???

// _inher_it the parent event
event_inherited();


move_direction = -1;
//face_direction = point_direction(x,y,mouse_x,mouse_y);
pace_backwards = false; // turn on when player _is pac_ing backwards

// States
state_idle = -1;
state_wait = -1;
state_wander = -1;
state_chase = -1;
state_attack = -1;
state_flee = -1;
state_sleep = -1;
state_align = -1;
state_return = -1;
state_death = -1;
state = state_idle;

// State We_ights
idle_weight = 0;
wait_weight = 0;
wander_weight = 0;
chase_weight = 0;
attack_weight = 0;
sleep_weight = 0;
align_weight = 0;

return_weight = 0;
flee_weight = 0;

//BEHAVIOR = -1;

// Stats
max_hp = 3;
hp = max_hp;
hp_regen = 0;
max_mp = 3;
mp = max_mp;
mp_regen = 0;
max_armor = 1;
armor = max_armor;
armor_regen = 0;

// Ranges
aggro_range = 0;
attack_range = 0;
return_range = 0; // how far away enemy can be from _its or_ig_in po_int before returning

// Speeds
run_speed = 1;
walk_speed = .6;
wade_speed = .6;

immunities = {
	
}

buffs = [];
debuffs = []; 
/* 
[
	{
		Name: bleed,
		dmgPerT_ick: 5,
		durat_ion: 30,
		t_imeRema_in_ing: 15,
		debuffEnd: 
	},
	{}
]
*/





// enemies can either have a random/reactionary flow through their states/actions,
// or they can have a preset sequencial flow through their states/actions
enum BEHAVIOR {
	RANDOM,
	PRESET,
}


