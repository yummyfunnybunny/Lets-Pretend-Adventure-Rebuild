

function weighted_chance() {
	//-------------------------------------
	//	== Weighted Chance ==
	//-------------------------------------
	///@param op1
	///@param wt1
	///@param op2
	///@param wt2
	///@param op3
	///@param wt3
	///@param op4
	///@param wt4
	///@param op5
	///@param wt5
	///@param op6
	///@param wt6
	//-------------------------------------

	// Set Default Values
	var _op1 = noone;
	var _wt1 = 0;
	var _op2 = noone;
	var _wt2 = 0;
	var _op3 = noone;
	var _wt3 = 0;
	var _op4 = noone;
	var _wt4 = 0;
	var _op5 = noone;
	var _wt5 = 0;
	var _op6 = noone;
	var _wt6 = 0;

	// Reset Needed Variables
	if (argument_count > 0)		{ _op1 = argument[0];  }
	if (argument_count > 1)		{ _wt1 = argument[1];  }
	if (argument_count > 2)		{ _op2 = argument[2];  }
	if (argument_count > 3)		{ _wt2 = argument[3];  }
	if (argument_count > 4)		{ _op3 = argument[4];  }
	if (argument_count > 5)		{ _wt3 = argument[5];  }
	if (argument_count > 6)		{ _op4 = argument[6];  }
	if (argument_count > 7)		{ _wt4 = argument[7];  }
	if (argument_count > 8)		{ _op5 = argument[8];  }
	if (argument_count > 9)		{ _wt5 = argument[9];  }
	if (argument_count > 10)	{ _op6 = argument[10]; }
	if (argument_count > 11)	{ _wt6 = argument[11]; }

	// set each item choice to roll on
	var _option;
	_option[0] = _op1;
	_option[1] = _op2;
	_option[2] = _op3;
	_option[3] = _op4;
	_option[4] = _op5;
	_option[5] = _op6;

	// set the total number of choices
	var _option_count = array_length(_option);

	// Set the weight for each choice
	var _weight;
	_weight[0] = _wt1;
	_weight[1] = _wt2;
	_weight[2] = _wt3;
	_weight[3] = _wt4;
	_weight[4] = _wt5;
	_weight[5] = _wt6;

	// Calculate the sum of all weights
	var _sum = 0;
	for(var _i = 0; _i < _option_count; _i++){
	  _sum += _weight[_i];
	}

	// Get a random number called "k"
	// This number will actually be 0, 1, 2, or 3, with a distribution based on the weights we've set
	var _rand = random(_sum);
	var _k = 0;
	for(var _i = _weight[0]; _i < _rand; _i += _weight[_k]){
	  _k++;
	}

	// Choose the item based on "k"
	var _option_picked = _option[_k];

	// Return the chosen option
	return _option_picked;


}