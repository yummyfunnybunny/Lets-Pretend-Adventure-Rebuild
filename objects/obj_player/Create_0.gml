
// == Initialize == 
// movement
initialize_movement(2);




// set input
moveRight = ord("D");
moveLeft = ord("A");
moveUp = ord("W");
moveDown = ord("S");
jump = vk_space;
restart = vk_escape;

// z physics
initialize_z_solid(true,32);
initialize_z_movement(0.1,3,8,3,0,1);