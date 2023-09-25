/// @desc ???


// fl_ip _image to xScale
function player_flip_image() {
	if (face_direction >= 270 && face_direction <= 360 ||
		face_direction >= 0 && face_direction < 90) { 
		image_xscale = 1; 
	} else { 
		image_xscale = -1; 
	}
}

// fl_ip _image to xScale
/*
function player_flip_image() {
	if (face_direction >= 270 && face_direction <= 360 ||
		face_direction >= 0 && face_direction < 90) { 
		image_xscale = 1; 
	} else { 
		image_xscale = -1; 
	}
}