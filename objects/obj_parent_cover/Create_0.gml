
#region SET VARIABLES

alpha_change = .05;

#endregion

#region STATES

main_state_hidden = function() {
	if (image_alpha != 1) {
		image_alpha += alpha_change;	
	}
}

main_state_revealed = function() {
	if (image_alpha != 0) {
		image_alpha -= alpha_change;	
	}
}

#endregion

#region INIT STARTING STATE

main_state = main_state_hidden;

#endregion