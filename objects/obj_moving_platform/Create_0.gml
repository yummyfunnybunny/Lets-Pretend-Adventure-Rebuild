
event_inherited();
//_in_it_ial_ize_z_sol_id(8);
//_in_it_ial_ize_z_movement(0,0,0,0,0,0);
//_in_it_ial_ize_movement(1);

origin_x = x;
origin_y = y;
returning = 0

destination_x = 784;
destination_y = 384;
spd = 1;
path = path_add();
path = pth_platform1;

mp_linear_path(path,destination_x,destination_y,spd, false);
path_start(path,spd,path_action_reverse,false);






