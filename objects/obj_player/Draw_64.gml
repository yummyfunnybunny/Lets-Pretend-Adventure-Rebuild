
// == DRAW DEBUGGING ==
draw_text(16,16*1,"xSpeed: " + string(xSpeed));
draw_text(16,16*2,"moveRight: " + string(keyboard_check(moveRight)));
draw_text(16,16*3,"moveLeft: " + string(keyboard_check(moveLeft)));

draw_text(16,16*5,"ySpeed: " + string(ySpeed));
draw_text(16,16*6,"moveDown: " + string(keyboard_check(moveDown)));
draw_text(16,16*7,"moveUp: " + string(keyboard_check(moveUp)));

draw_text(16,16*9,"zSpeed: " + string(zSpeed));
draw_text(16,16*10,"zBottom: " + string(zBottom));
draw_text(16,16*11,"zTop: " + string(zTop));
draw_text(16,16*12,"zFloor: " + string(zFloor));
draw_text(16,16*13,"zRoof: " + string(zRoof));
draw_text(16,16*14,"onGround: " + string(onGround));
draw_text(16,16*15,"onTopOf: " + string(onTopOf));
draw_text(16,16*16,"belowOf: " + string(belowOf));

draw_text(16,16*19,"accel: " + string(accel));
draw_text(16,16*20,"fric: " + string(fric));



