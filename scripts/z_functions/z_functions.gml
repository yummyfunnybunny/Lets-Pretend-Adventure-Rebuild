// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initialize_z_solid(_zSolid,_zHeight){
	zSolid = _zSolid;			// dictates if the object is indeed a solid object
	zBottom = 0;				// z coordinate of the bottom of the object
	zHeight = _zHeight			// how tall the object is
	zTop = zBottom-zHeight;		// z coordinates of the top of the object
	zFloor = 0;					// z coordinate of the current floor position below the object
	zRoof = -room_height;		// z coordinate of the current cieling aabove the target
}

function initialize_z_movement(_zGravity,_maxFallSpeed,_zStepUp,_zJumpSpeed,_zBounce,_zWeight){
	zGravity = _zGravity;			// equivilant of acceleration for x and y movement
	maxFallSpeed = _maxFallSpeed;	// maximum speed object can fall
	zStepUp = _zStepUp;				// how high of a wall the object can walk over before needing to jump
	zJumpSpeed = _zJumpSpeed;		// how high the object can jump
	zBounce = _zBounce;				// how much bounce there is when the object hits the ground
	zWeight = _zWeight;				// used in the bounce and knockback algorithms to dictate distances
	zSpeed = 0;						// current vertical speed of the object
	zPrevious = 0;					// objects previous z coordinate		
	onTopOf = noone;				// tells the object what object is above it, if any
	belowOf = noone;				// tells the object what object is below it, if any
}