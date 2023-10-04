// == _in_it_ial_ize == 
event_inherited();

state = player_state_free;
move_direction = -1;
face_direction = point_direction(x,y,mouse_x,mouse_y);
pace_backwards = false; // turn on when player _is pac_ing backwards

//_image Control
sprite_idle = spr_player_idle1;
sprite_run = spr_player_run;
sprite_walk = spr_player_walk;
sprite_pace_backwards = spr_player_pace_backwards;
sprite_jump = spr_player_jump;
sprite_fall = spr_player_fall;
sprite_hurt = spr_player_hurt;
sprite_climb = spr_player_climb;
sprite_pitfall = spr_player_pitfall;
sprite_drown = spr_player_drown;
sprite_attack = spr_player_attack_sword;
sprite_death = spr_player_death;

last_safe_x = x;
last_safe_y = y;
tile = noone;
//localFrame = 0; // use th_is to specif_ically set the _image _index of the players current spr_ite
