
event_inherited();

destination_x = 784;
destination_y = 384;
move_speed = 1;
//path = pth_platform1;
path = path_add();

mp_linear_path(path,destination_x,destination_y,move_speed, false);
my_path = path_start(path,move_speed,path_action_reverse,false);






