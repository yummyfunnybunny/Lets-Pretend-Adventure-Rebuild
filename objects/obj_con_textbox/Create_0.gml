
#region SET VARIABLES

//depth = -y - 20000;				// set depth
//creator = noone;					// stores ID of the entity that created this textbox
//text = "";							// stores the current text to be displayed in the textbox
page = 0;							// stores the current page of text to be displayed
text_count = 0;						// stores the current text count - incremented to get that type-writer effect
//textbox_title = noone;				// stores the title for this textbox 
show_debug_message(text_to_display);

textbox_curve = animcurve_get_channel(ac_curve_textbox, "curve1");
textbox_percent = 0;
textbox_width = 0;

line_height = 16;											// set line height for the display text
padding = 8;												// treated exactly like css padding (inside offset)
margin_y = 16;												// margin between bottom of textbox and screen bottom
margin_x = COL_TILES_SIZE*8;								// margin between left/right side of textbox and screen edge
textbox_height = global.gui_height/4;
textbox_max_width = global.gui_width-(margin_x*2);

#endregion

#region ALARMS



#endregion

#region STATES

main_state_spawn = function() {

	// begin spawn
	if (textbox_percent < 1) {
		textbox_percent += 1/60;	
	}
	
	var _position = animcurve_channel_evaluate(textbox_curve, textbox_percent);
	textbox_width = textbox_max_width * _position;
	
	// end spawn
	if (textbox_percent >= 1) {
	//if (textbox_width >= textbox_max_width) {
		textbox_width = textbox_max_width;
		main_state = main_state_display_text;
	}
}
main_state_display_text = function() {
	// this is when text is being displayed
	
	
}

main_state_despawn = function() {
	
	// begin despawn
	if (textbox_percent > 0) {
		textbox_percent -= 1/60;
	}
	
	var _position = animcurve_channel_evaluate(textbox_curve, textbox_percent);
	textbox_width = textbox_max_width * _position;
	
	// end despawn
	if (textbox_percent <= 0) {
		// may have to run other things here
		// - update quests?
		instance_destroy();
	}
}

#endregion

#region HELPER SCRIPTS

//function textbox_draw_box(_sprite, _x1, _y1, _x2, _y2) {
//	// == Nine Slice Box Stretch ==
//	var _size = sprite_get_width(_sprite)/3;	// grid size of the 9 slice text box being used
//	var _w = _x2 - _x1;								// width of the text box
//	var _h = _y2 - _y1;								// height of the text box

//	// Draw Middle
//	draw_sprite_part_ext(_sprite,0,_size,_size,1,1,_x1+_size,_y1+_size,_w-(_size*2),_h-(_size*2),c_white,1);

//	// Draw Corneres
//	// top left
//	draw_sprite_part(_sprite,0,0,0,_size,_size,_x1,_y1);
//	// top right
//	draw_sprite_part(_sprite,0,_size*2,0,_size,_size,_x1+_w-_size,_y1);
//	// bottom left
//	draw_sprite_part(_sprite,0,0,_size*2,_size,_size,_x1,_y1+_h-_size);
//	// bottom right
//	draw_sprite_part(_sprite,0, _size*2,_size*2,_size,_size,_x1+_w-_size,_y1+_h-_size);

//	// Draw Edges 
//	// left edge
//	draw_sprite_part_ext(_sprite,0,0,_size,_size,1,_x1,_y1+_size,1,_h-(_size*2),c_white,1);
//	// right edge
//	draw_sprite_part_ext(_sprite,0,_size*2,_size,_size,1,_x1+_w-_size,_y1+_size,1,_h-(_size*2),c_white,1);
//	// top edge
//	draw_sprite_part_ext(_sprite,0,_size,0,1,_size,_x1+_size,_y1,_w-(_size*2),1,c_white,1);
//	// bottom edge
//	draw_sprite_part_ext(_sprite,0,_size,_size*2,1,_size,_x1+_size,_y1+_h-(_size),_w-(_size*2),1,c_white,1);
//}

//function textbox_create_text_box() {
//	// set room boundaries
//	var _gs				= grid_size/4;
//	var _left_bound		= (x - (_gs*15));
//	var _right_bound	= (x + (_gs*15)) - room_width;
//	var _top_bound		= (y - (_gs*10)) - sprite_height;
//	// keep text box inside the room
//	if (_left_bound		> 0) { _left_bound = 0;}
//	if (_right_bound	< 0) {_right_bound = 0;}
//	if (_top_bound		> 0) {_top_bound = 0;}
//	// create text box and set initializing variables
//	obj_text_box = instance_create_layer(x+abs(_left_bound)-_right_bound,y+abs(_top_bound),"text",con_text_box);
//	obj_text_box.creator = id;
//	obj_text_box.name = obj_title;
//	quest_text_update();
//}

function textbox_draw_frame() {
	var _frame_x = global.gui_width/2-(textbox_width/2);
	var _frame_y = global.gui_height-textbox_height-16;
	draw_sprite_stretched(spr_textbox,0, _frame_x, _frame_y,textbox_width,textbox_height);
}

function textbox_draw_text() {
	if (main_state != main_state_display_text) { exit; }
	draw_set_font(fnt_textbox);	// set text font
	
	// imcrement text_count
	if (text_count < string_length(text_to_display[page])){ text_count += 0.5;}
	var _text_part = string_copy(text_to_display[page],1,text_count);
	
	// title
	var _title_x = global.gui_width/2-(textbox_width/2);
	var _title_y = global.gui_height-textbox_height-16;
	
	draw_set_colour(c_yellow);
	draw_text(_title_x+padding,_title_y+padding,textbox_title);
	draw_set_colour(c_white);
	
	// text
	var _text_x = (global.gui_width/2)-(textbox_width/2)+padding;
	var _text_y = global.gui_height-textbox_height-margin_y+padding+24;
	draw_text_ext(_text_x,_text_y,_text_part,16,textbox_width-margin_y);	
}

function textbox_draw_input_icon() {
	if (main_state != main_state_display_text) { exit; }
	var _icon_x = (global.gui_width/2);
	var _icon_y = global.gui_height-margin_y;
	draw_sprite_ext(spr_button_input_icons,0,_icon_x, _icon_y, 1.5, 1.5, 0, c_white, 1);	
}

#endregion

#region STARTING STATE

main_state = main_state_spawn;

#endregion