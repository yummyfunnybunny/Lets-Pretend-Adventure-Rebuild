
event_inherited();

returning = 0

destination_x = 784;
destination_y = 384;
spd = 1;
path = path_add();
path = pth_platform1;

mp_linear_path(path,destination_x,destination_y,spd, false);
path_start(path,spd,path_action_reverse,false);






