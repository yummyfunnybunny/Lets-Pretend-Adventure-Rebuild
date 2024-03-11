/// @desc

// Inherit the parent event
event_inherited();

// update collision
entity_collision();

// update_speed
if (move_speed > 0) {
	move_speed -= .025;	
}

// update image
if (move_speed > 0) {
	image_speed = move_speed;	
} else {
	image_speed = 0;	
}

// apply speed to x/y
if (move_speed != 0) {
	x += lengthdir_x(move_speed,direction);
	y += lengthdir_y(move_speed,direction);
}

// -- Hor_izontal collision_map Check --
var _bbox_width_half = (bbox_right-bbox_left)/2;
var _bbox_height_half = (bbox_bottom-bbox_top)/2;
var _xx = _bbox_width_half*sign(x_speed);
var _yy = _bbox_height_half*sign(y_speed);
	
// Walls - collide with walls from the collision_map
if (tilemap_get_at_pixel(global.collision_map, x+_xx+x_speed, y) == 1 ||
	tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y-_bbox_height_half) == 1 ||
	tilemap_get_at_pixel(global.collision_map,x+_xx+x_speed,y+_bbox_height_half) == 1) {
		if (tilemap_get_at_pixel(global.collision_map, x+_xx+sign(x_speed), y) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y-_bbox_height_half) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_xx+sign(x_speed),y+_bbox_height_half) == 1) {
			
			// hit wall on the left side of the object
			/*
			if (sign(x_speed) == -1){
				
			} else {
					
			}
			*/
			
			direction += 180;
		} else {
			x_speed = sign(x_speed);
		}
}

if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+y_speed) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x-_bbox_width_half,y+_yy+y_speed) == 1 ||
		tilemap_get_at_pixel(global.collision_map,x+_bbox_width_half,y+_yy+y_speed) == 1){
		if (tilemap_get_at_pixel(global.collision_map,x,y+_yy+sign(y_speed)) == 1 ||
			tilemap_get_at_pixel(global.collision_map,x-_bbox_width_half,y+_yy+sign(y_speed)) == 1 ||
			tilemap_get_at_pixel(global.collision_map,x+_bbox_width_half,y+_yy+sign(y_speed)) == 1){
			direction += 180;
		} else {
			y_speed = sign(y_speed);	
		}
	}
	
// die when touching shallow water, deep water, and pitfalls
if (tilemap_get_at_pixel(global.collision_map,x,y) == 2 ||
	tilemap_get_at_pixel(global.collision_map,x,y) == 3 ||
	tilemap_get_at_pixel(global.collision_map,x,y) == 6) {
	if (z_bottom == -1) {
		var _tile = tilemap_get_at_pixel(global.collision_map,x,y);
		var _death_sprite;
		switch (_tile) {
			case 2: _death_sprite = spr_splash;
			case 3: _death_sprite = spr_splash; break;
			case 6: _death_sprite = spr_pitfall; break;
		}
		pather_delete(pather_object);
		instance_destroy();	
		instance_create_layer(x,y,global.main_layer,obj_object_death, {
			sprite_index: _death_sprite
		});
	}
}