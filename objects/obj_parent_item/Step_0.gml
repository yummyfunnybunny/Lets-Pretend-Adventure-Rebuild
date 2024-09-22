/// @desc
event_inherited();

if (global.game_paused) { exit; }

script_execute(main_state);
item_check_despawn();
item_interact_set_target();
item_interact_check_interact_range();
item_drift_to_player();

entity_collision();

item_update_movement();
//item_drift_to_player();
//x_speed = lengthdir_x(move_speed, direction);
//y_speed = lengthdir_y(move_speed, direction);