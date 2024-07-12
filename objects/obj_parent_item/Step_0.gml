/// @desc
event_inherited();

script_execute(main_state);
item_check_despawn();

entity_collision();
x_speed = lengthdir_x(move_speed, direction);
y_speed = lengthdir_y(move_speed, direction);