// == initialize Game Manager ==

global.game_paused = false;
global.debugger = false;
global.main_layer = "Instances";

// -- MACROS --
#macro COL_TILES_SIZE 16
#macro FPS game_get_speed(gamespeed_fps)

/// -- initialize path finding grid --

// set the size of each individual cell in the grid
global.path_grid_cell_size = 8;

// set the grid to the size of the room
//global.path_grid_width = room_width div global.path_grid_cell_size;
//global.path_grid_height = room_height div global.path_grid_cell_size;

// create the grid
//global.path_grid = mp_grid_create(0,0,global.path_grid_width,global.path_grid_height,global.path_grid_cell_size,global.path_grid_cell_size);

// Create the Camera Controller
global.Camera = instance_create_layer(0, 0, layer,obj_con_camera);

// create the UI Controller
global.ui = instance_create_layer(0, 0, layer, obj_con_ui);

// set game speed




