
// draw background
//draw_sprite_ext(spr_main_menu_bg,0,0,0,2,2,0,c_white,1);

draw_sprite_ext(spr_dimmer,0,0,0,40,23,0,c_white,.5);

// set text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_text_24);

// draw quit button
if (button_selected == 0) {
	draw_sprite(spr_menu_button,1,room_width/2,room_height-48);
	draw_text_color(room_width/2, room_height-72, "Quit",c_black,c_black,c_black,c_black,1);
} else {
	draw_sprite(spr_menu_button,0,room_width/2,room_height-48);
	draw_text_color(room_width/2, room_height-72, "Quit",c_white,c_white,c_white,c_white,1);	
}



// draw settings button
if (button_selected == 1) {
	draw_sprite(spr_menu_button,1,room_width/2, room_height-128);
	draw_text_color(room_width/2,room_height-152, "Settings", c_black,c_black,c_black,c_black,1);
} else {
	draw_sprite(spr_menu_button,0,room_width/2,room_height-128);
	draw_text_color(room_width/2, room_height-152, "Settings",c_white,c_white,c_white,c_white,1);
}


// draw load game button
if (button_selected == 2) {
	draw_sprite(spr_menu_button,1,room_width/2,room_height-208);
	draw_text_color(room_width/2,room_height-232, "Load Game",c_black,c_black,c_black,c_black,1);
} else {
	draw_sprite(spr_menu_button,0,room_width/2,room_height-208);
	draw_text_color(room_width/2, room_height-232, "Load Game",c_white,c_white,c_white,c_white,1);
}


// draw new game button
if (button_selected == 3) {
	draw_sprite(spr_menu_button,1,room_width/2,room_height-288);
	draw_text_color(room_width/2, room_height-312, "New Game",c_black,c_black,c_black,c_black,1);
} else {
	draw_sprite(spr_menu_button,0,room_width/2,room_height-288);
	draw_text_color(room_width/2, room_height-312, "New Game",c_white,c_white,c_white,c_white,1);
}

// reset text
reset_text();