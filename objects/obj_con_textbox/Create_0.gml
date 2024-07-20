
#region SET VARIABLES




textbox_curve = animcurve_get_channel(ac_curve_textbox, "curve1");	// store the animation curve to use
textbox_percent = 0;									// stores the current percentage through the animation curve
page = 0;												// stores the current page of text to be displayed
text_count = 0;											// stores the current text count - incremented to get that type-writer effect
line_height = 16;										// set line height for the display text
padding = 8;											// treated exactly like css padding (inside offset)
margin_y = 16;											// margin between bottom of textbox and screen bottom
margin_x = COL_TILES_SIZE*8;							// margin between left/right side of textbox and screen edge
textbox_height = global.gui_height/4;					// height of the textbox
textbox_width = 0;										// current width of the textbox - this is what changes as it spawns and despawns
textbox_max_width = global.gui_width-(margin_x*2);		// max width of the textbox - this is what textbox_width will grow to

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

function textbox_draw_frame() {
	var _frame_x = global.gui_width/2-(textbox_width/2);
	var _frame_y = global.gui_height-textbox_height-16;
	draw_sprite_stretched(spr_textbox,0, _frame_x, _frame_y,textbox_width,textbox_height);
}

function textbox_draw_text() {
	if (main_state != main_state_display_text) { exit; }
	draw_set_font(fnt_text_10);	// set text font
	
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
	
	// reset text
	reset_text();
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