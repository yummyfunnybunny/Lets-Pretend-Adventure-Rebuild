/// @desc init
event_inherited();

#region INIT ENEMY SET VARIABLES
/*
These variables are used inside functions for calculations or other purposes and 
do not need to be changed once set.

variables that need to be set an a per-enemy basis are all in the VARIABLE DEFINITIONS
*/

faction					= FACTION.ENEMY;		// set the faction of the instance
hp						= max_hp;				// set hp to max hp
mp						= max_mp;				// set mp to max mp
armor					= max_armor;			// set armor to max armor
move_speed				= 0;					// set max move speed
apply_damage			= 0;					// holds an object of all the damage specs when dealing damage to another instance 
target					= noone;				// id of current target to chase/attack
align_x					= 0;					// sets x-position to for aligning a certain way to target for attacks
align_y					= 0;					// sets y-position for aligning a certain way to target for attacks
extra_damage_check		= noone;				// use this to store a function to perform additional checks for unique enemies when taking damage

#endregion

#region INIT ALARMS
enum ALARM {
	DEATH,
	STATE,
	DAMAGED,
	ATK_START,
	ATK_END,
	COUNT,
}

#endregion

#region INIT ENEMY STATES

// these are default empty state functions
// the actual states are created in each enemy's create event.
// if an enemy does not have their own state funcion,
// they default to these empty state functions

// main states
main_state_unaware			= function(){
	// unuware main state controls all checks that need to be made while
	// the enemy is unaware of the player.
	// ex. aggro_range_check, return_origin_check
};
main_state_aware			= function(){
	// aware main state controls all checks that need to be made while
	// the enemy is aware of the player/
	// ex. attack_range_check, alignment checks, return_origin_check
};
main_state_death			= function(){
	// the death main_state controls the overall function of the enemy's death
	// there are many ways an enemy can die, but some of the functionality is always the same
	// the nest state will control the different ways an enemy can die (normal, pitfall, water, etc.);
	if (alarm[ALARM.DEATH] == -1) { alarm[ALARM.DEATH] = FPS * 3;}
	if (alarm[ALARM.DEATH] == 0) { 
		instance_destroy();	
	}
}

// unuware states
nest_state_idle				= function(){
	// the idle state controls how long the enemy will sit idly before 
	// going into a different state
	// idle state, unlike wait state, continues to make state-chage checks
	// and can be cancelled if any state-change checks are triggered
};
nest_state_wander			= function(){
	// wander is an unuware moving state that is random
};
nest_state_sleep			= function(){
	// sleep is basically a prolonged waiting state
	// the enemy will go into sleep animation and won't do most of their
	// unuware state-change checks, with some exceptions (alerted by allies, etc.)
};
nest_state_patrol			= function(){
	// patrol is an unuware moving state that follows a path
};
nest_state_return_origin	= function(){
	// return_origin is an unuware moving state that moves the enemy
	// back to its origin_x & origin_y
	// aggro range & attack range checks are not performed here
};

// aware states
nest_state_chase			= function(){
	// chase is an aware moving state that moves the enemy towards the player
};
nest_state_align			= function(){
	// align is an aware moving state that moves the enemy to
	// a particular point in alignment with the player
};
nest_state_flee				= function(){
	// flee is an aware moving state that moves the enemy away from the player
};
nest_state_attack			= function(){
	// attack is an aware state that triggeres one of the enemies attacks on their target
};

// death states
nest_state_death_normal		= function(){
	// death state is the normal way to die (on the ground)
	// animates the enemy in their normal fashion
};
nest_state_death_drown		= function(){
	// drown is the state that controls how an enemy dies when touching water
}
nest_state_death_pitfall	= function(){
	// pitfall controls how the enemy dies when touching a pitfall
}

// wild-card states (can belong to unaware or aware
choose_state				= function(){
	// choose state controls rolling the dice on all the available states
	// the enemy can choose to go into in whichever main state they are in
	// this can be used to randomly choose an unaware main state
	// or it can be useed to choose the next move the enemy will 
	// make while they are persuing/attacking the player (multiple attack choices, etc)
};
nest_state_wait				= function(){
	// wait is a bridge state between just performing an action and moving on to the next state
	// wait cancels most state-change-checks and cannot be skipped by the enemy
};
nest_state_hurt				= function(){
	// hurt state controls what happens to an enemy when they take damage
};
nest_state_react			= function(){
	// the react state controls an enemies reaction to things
	// ex. roaring when aggroed, saying something when they kill the player
};


#endregion

#region INIT ENEMY HELPER FUNCTIONS

function enemy_take_damage(_damage, _damage_type, _element_type, _special_effect) {
	if (just_got_damaged) { exit; }
	
	// check immunities
	if (damage_check_modifiers(_damage_type, _element_type, immune_array) == true) { _damage = 0; }
	
	// run extra damage check
	if (extra_damage_check) { script_execute(extra_damage_check); }
	
	// check resistances
	if (damage_check_modifiers(_damage_type, _element_type, resistance_array) == true) { _damage /= round(_damage*2); }
	
	// check vulnerabilities
	if (damage_check_modifiers(_damage_type, _element_type, vulnerable_array) == true) { _damage *= round(_damage*2); }
	
	// check armor
	_damage = damage_check_armor(_damage);
	
	// run special effect
	if (_special_effect) { script_execute(_special_effect); }
	
	// finalize damage
	if (_damage > 0) {
		hp -= _damage;
		just_got_damaged = true;
		alarm[ALARM.ATK_START] = -1;		// cancels an attack if one was underway
		alarm[ALARM.DAMAGED] = FPS*0.5;
		nest_state = nest_state_hurt;
		// play damage sound
	} else {
		// play block/resist/immune sound	
	}
	
}

function enemy_aggro_range_check(_main_state = main_state_aware,_nest_state = nest_state_chase){
	if (target == noone) exit;
	if (nest_state = nest_state_return_origin) { exit; }
	if (nest_state = nest_state_wait) { exit; }
	if (point_distance(x,y,target.x,target.y) <= aggro_range*COL_TILES_SIZE) {
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function enemy_origin_distance_check(_main_state = main_state_unaware, _nest_state = nest_state_return_origin) {
	if (nest_state == nest_state_return_origin) { exit; }
	if (nest_state = nest_state_wait) { exit; }
	if (point_distance(x,y,origin_x,origin_y) >= origin_range*COL_TILES_SIZE) {
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function enemey_attack_range_check(_main_state = main_state_aware, _nest_state = nest_state_attack) {
	if (target == noone) { exit; }
	if (nest_state == nest_state_sleep) { exit; }
	if (nest_state = nest_state_return_origin) { exit; }
	if (nest_state = nest_state_wait) { exit; }
	var _dis = point_distance(x,y,target.x,target.y);
	if (_dis <= attack_range*COL_TILES_SIZE) { 
		main_state = _main_state;
		nest_state = _nest_state;
	}
}

function enemy_set_target() {
	if (!instance_exists(target)) {
		if (instance_exists(obj_player)){
			target = instance_nearest(x,y,obj_player);	
		} else if (target != noone) {
			target = noone;
		}
	}
	
	if (instance_exists(target)) {
		if (target.main_state == obj_player.main_state_death) {
			if (target != noone) {
				target = noone;	
			}
		}
	}
	
}

function enemy_quadrant_check(_target) {
	// _obj = the object you are trying to check the quadrant you are in
	
	// grid legend
	//      13     16     6
	//        . 12 |  5 .     
	//          .  |  .   4    
	//     11     .|.         
	// 14 --------17----------  7
	//           . | .        
	//      8  .   |   .  1    
	//       .  9  |  2  .    
	//    10       15      3       

	var _delta_x = x - _target.x;
	var _delta_y = y - _target.y;
	var _delta_dif = abs(_delta_x) - abs(_delta_y);
	
	switch(sign(_delta_x)){
		// 1 = you are on the right side of the target on the x-axis
		case 1:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1:
					if (_delta_dif > 0) return 1; else
					if (_delta_dif < 0) return 2; else
					if (_delta_dif = 0) return 3; break;
				// -1 = you are above the target on the y-axis
				case -1:
					if (_delta_dif > 0) return 4; else
					if (_delta_dif < 0) return 5; else
					if (_delta_dif = 0) return 6; break;
				case 0: return 7; break;
			}
		break;
		//------------------------------------------------------------
		// -1 = you are on the left side of the target on the x-axis
		case -1:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1:
					if (_delta_dif > 0) return 8; else
					if (_delta_dif < 0) return 9; else
					if (_delta_dif = 0) return 10; break;
				// -1 = you are above the target on the y-axis
				case -1:
					if (_delta_dif > 0) return 11; else
					if (_delta_dif < 0) return 12; else
					if (_delta_dif = 0) return 13; break;
				case 0: return 14; break;
			}
		break;
		//------------------------------------------------------------
		// 0 = you are aligned to the target on the x-axis
		case 0:
			switch(sign(_delta_y)){
				// 1 = you are below the target on the y-axis
				case 1: return 15; break;
				// -1 = you are above the target on the y-axis
				case -1: return 16; break;
				// 0 = you are aligned with the target on the y-axis
				case 0: return 17; break;
			}
		break;
	}
}

#endregion

