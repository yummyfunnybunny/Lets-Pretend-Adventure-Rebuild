function bounding_box_overlap_check(_axis, _checker, _target) {
	// axis: x or y axis
	// checker: the one who we need the results for
	// target: the one we're checking against
	
	// set variables 
	var _ctop = _checker.bbox_top;
	var _cbot = _checker.bbox_bottom;
	var _ttop = _target.bbox_top;
	var _tbot = _target.bbox_bottom;
	
	var _cleft = _checker.bbox_left;
	var _cright = _checker.bbox_right;
	var _tleft = _target.bbox_left;
	var _tright = _target.bbox_right;
	
	// perform the check
	switch(_axis) {
		case "x":
			if (_ctop <= _tbot && _cbot >= _ttop) { return true; } else {  return false; }
		
		case "y":
			if (_cleft <= _tright && _cright >= _tleft) { return true; } else {  return false; }
		
		case "xy":
			if (_ctop <= _tbot && _cbot >= _ttop ||
				_cleft <= _tright && _cright >= _tleft) { return true; } else {  return false; }
	}
}

//function bounding_box_check(_entity_collided) {
	
//	// save bound_ing boxes of coll_id_ing _instance
//	var _bbox_right = _entity_collided.bbox_right;
//	var _bbox_left = _entity_collided.bbox_left;
//	var _bbox_bottom = _entity_collided.bbox_bottom;
//	var _bbox_top = _entity_collided.bbox_top;
	
//	// perform the check
//	if (bbox_left <= _bbox_right && bbox_left >= _bbox_left ||
//		bbox_right >= _bbox_left && bbox_right <= _bbox_right ||
//		bbox_bottom <= _bbox_bottom && bbox_bottom >= _bbox_top ||
//		bbox_top >= _bbox_top  && bbox_top <= _bbox_bottom) {
//		// there _is overlap, so return true
//		return true;
//	}else {
//		// there _is NO overlap, so return false
//		return false;	
//	}
//}