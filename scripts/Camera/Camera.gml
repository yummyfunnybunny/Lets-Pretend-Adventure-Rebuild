function change_camera_mode(_mode, _target_x, _target_y){
	with(obj_con_camera) {
		mode = argument[0];
		
		switch(mode) {
			case camera_mode.move_to_target:
				target_x = argument[1];
				target_y = argument[2];
			break;
			
			case camera_mode.follow_object:
			case camera_mode.move_to_follow_object:
				following = argument[1];
			break;
		}
	}
}


function screen_shake(_magnitude, _magnitude_time){
	with (global.i_camera) {
		if (_magnitude > shake_remain) {
			shake_magnitude = _magnitude;
			shake_remain = shake_magnitude;
			shake_length = _magnitude_time;
		}
	}
}