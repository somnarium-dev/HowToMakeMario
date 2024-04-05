///@desc Custom Methods

//=======================================================================================
// MOVEMENT
//=======================================================================================

///@func tryToMoveMapEnemy()
tryToMoveMapEnemy = function()
{
	// If there are no shuffle moves remaining,
	// And this is not an invalid final position,
	// Then stop trying to move.
	var on_top_of_a_level = place_meeting(x, y, obj_parent_world_level_indicator);
	var on_top_of_another_enemy = place_meeting(x, y, obj_parent_world_enemy);
		
	if (shuffle_moves_remaining < 1)
	&& (!on_top_of_a_level)
	&& (!on_top_of_another_enemy)
	{ return false; }
	
	// Check if it's possible to move.
	var movement_ready = false;
	
	var movement_possible = false;
	var not_blocked_by_obstacle = false;
	
	var random_move_direction = irandom_range(0, 3) * 90;
	
	for (var i = 0; i < 4; i++;)
	{
		move_direction = (random_move_direction + (90 * i)) mod 360;
		
		movement_possible = permittedToMove();
		not_blocked_by_obstacle = notBlockedByObstacle()
	
		if (movement_possible)
		&& (not_blocked_by_obstacle)
		{ 
			movement_ready = true;
			break;
		}
	}
	
	// If there's a valid direction to move in, prepare to do so.
	if (movement_ready)
	{
		playSFX(sfx_skid);
		move_distance = movement_check_distance;
		move_x = lengthdir_x(1, move_direction);
		move_y = lengthdir_y(1, move_direction);
		return true;
	}
	
	// Otherwise, time to stop trying.
	return false;
}

///@func permittedToMove
permittedToMove = function()
{
	var check_x = x + lengthdir_x(movement_check_distance, move_direction);
	var check_y = y + lengthdir_y(movement_check_distance, move_direction);
	
	var moving_to_valid_destination = instance_position(check_x, check_y, obj_world_map_path);
	
	var permitted_to_move = true;
	
	// Check if there's a valid landing destination ahead.
	// If not, return false.
	if (!moving_to_valid_destination)
	{ permitted_to_move = false; }
	
	return permitted_to_move;
}

///@func notBlockedByObstacle
notBlockedByObstacle = function()
{
	var check_x = x + lengthdir_x(obstacle_check_distance, move_direction);
	var check_y = y + lengthdir_y(obstacle_check_distance, move_direction);
	
	// First check for a literal obstacle.
	var obstacle_detected = place_meeting(check_x, check_y, obj_parent_world_obstacle);
	
	// If one was not found,
	// Then check to see if there's a path in this direction.
	if (!obstacle_detected)
	{ 
		// If there is NOT, then an obstacle HAS been detected.
		obstacle_detected = !place_meeting(check_x, check_y, obj_world_map_path);
	}
	
	// Invert the return.
	// We are ensuring there is NOT an obstacle ahead.
	return !obstacle_detected;
}

///@func processMapMovement()
processMapMovement = function()
{	
	if (move_distance > 0)
	{
		move_distance -= move_speed;
		x += move_x * move_speed;
		y += move_y * move_speed;
	}
	
	if (move_distance < 1)
	{
		move_x = 0;
		move_y = 0;
		shuffle_moves_remaining--;
		return true;
	}
	
	return false;
}

//=======================================================================================
// DISPLAY
//=======================================================================================

///@func autoshiftSpriteHorizontally()
autoshiftSpriteHorizontally = function()
{	
	h_display_offset_accumulated += h_display_offset_step;
	
	if (h_display_offset_accumulated >= 1)
	{
		if (h_display_offset == max_h_display_offset)
		|| (h_display_offset == -max_h_display_offset)
		{ sprite_horizontal_direction *= -1; }
		
		h_display_offset_accumulated = 0;
		h_display_offset += sprite_horizontal_direction;
	}
}

///@func resetHorizontalSpriteShift()
resetHorizontalSpriteShift = function()
{
	if (h_display_offset != 0)
	{
		h_display_offset = 0;
		h_display_offset_accumulated = 0;
	}
}

//=======================================================================================
// DATA
//=======================================================================================

///@func updateEnemyMapCoordinates()
updateEnemyMapCoordinates = function()
{
	global.world_data[global.world].enemies[enemy_index].coordinates._x = x;
	global.world_data[global.world].enemies[enemy_index].coordinates._y = y;
}

