
// == Initialize == 
// movement
xSpeed = 0;
ySpeed = 0;
maxSpeed = 2;
fric = 0.1;
accel = 0.2;

// set input
moveRight = ord("D");
moveLeft = ord("A");
moveUp = ord("W");
moveDown = ord("S");
jump = vk_space;
restart = vk_escape;

// z physics
initialize_z_solid(true,32);
initialize_z_movement(0.1,3,10,3,0,1);


