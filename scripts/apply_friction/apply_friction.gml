
function apply_friction(_input1, _input2, _speed){
	if (!_input1 && !_input2 || _input1 && _input2){
		return sign(_speed)*fric;	
	}else{
		return 0;
	}
}