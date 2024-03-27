///@desc Custom Functions

//=================================================================================================
// MOVEMENT AND COLLISION
//=================================================================================================

///@func handleEnemyMovementAndCollision()
handleEnemyMovementAndCollision = function()
{
	determineTopHSpeed();
	
	handleGravity();
	
	handleHorizontalAcceleration(ai_input_lr);
	handleVerticalAcceleration(ai_input_jump_released);
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updateEnemyPosition();
}

///@func updateEnemyPosition
updateEnemyPosition = function ()
{
	if (!process_movement) { return; }
	
	starting_x = x;
	starting_y = y;
	
	attempted_movement_this_frame_x = horizontal_pixels_queued;
	attempted_movement_this_frame_y = vertical_pixels_queued;
	
	actual_movement_this_frame_x = 0;
	actual_movement_this_frame_y = 0;
	
	var h_sign = sign(h_speed);
	var v_sign = sign(v_speed);
	
	var h_adjustment = sign(horizontal_pixels_queued);
	var v_adjustment = sign(vertical_pixels_queued);
	
	var h_pixels = abs(horizontal_pixels_queued);
	var v_pixels = abs(vertical_pixels_queued);
	
	var repetitions = max(h_pixels, v_pixels);
	
	repeat (repetitions)
	{
		//If both queues have zeroed out, break.
		if (vertical_pixels_queued == 0)
		&& (horizontal_pixels_queued == 0)
		{ break; }
		
		//============
		// HORIZONTAL
		//============
		if (horizontal_pixels_queued != 0)
		{
			//If it's not possible to move in the direction queued*
			//AND that is the direction this object is intending to move
			//Zero out speed and queued pixels.
			if (checkForImpassable(x + h_adjustment, y))
			|| (checkForCollisionWithAnotherEnemy(x + h_adjustment, y))
			{
				if (h_sign == h_adjustment)
				{ 
					h_speed = 0;
					horizontal_pixels_queued = 0;
				}
			}
			
			else
			{
				x += h_adjustment;
				actual_movement_this_frame_x += h_adjustment;
				horizontal_pixels_queued -= h_adjustment;
			}
		}
		
		//============
		// VERTICAL
		//============
		if (vertical_pixels_queued != 0)
		{
			//If it's not possible to move in the direction queued*
			//AND that is the direction the player is intending to move
			//Zero out speed and queued pixels.
			if (checkForImpassable(x, y + v_adjustment))
			&& (v_sign == v_adjustment)
			{ 
				v_speed = 0;
				vertical_pixels_queued = 0;
			}
		
			else
			{ 
				y += v_adjustment;
				actual_movement_this_frame_y += v_adjustment;
				vertical_pixels_queued -= v_adjustment;
			}
		}
	}
}

///@func determineTopHSpeed()
determineTopHSpeed = function()
{	
	//This space left empty by design.
}

//=================================================================================================
// MISC
//=================================================================================================

///@func clearRegisteredJumpAttack()
clearRegisteredJumpAttack = function()
{
	jump_attack.registered = false;
	jump_attack.attacker = noone;
}

///@func failedToMoveHorizontally()
failedToMoveHorizontally = function()
{	
	show_debug_message($"attempted: {attempted_movement_this_frame_x}, actual: {actual_movement_this_frame_x}");
	
	if (attempted_movement_this_frame_x != 0)
	&& (actual_movement_this_frame_x == 0)
	{ return true; }
	
	return false;
}

///@func failedToMoveVertically()
failedToMoveVertically = function()
{
	if (attempted_movement_this_frame_y > 0)
	&& (actual_movement_this_frame_y == 0)
	{ return true; }
	
	return false;
}

///@func getProximityToNearestPlayer()
getProximityToNearestPlayer = function()
{
	var nearest_player = instance_nearest(x, y, obj_parent_player);
	
	var direct_distance = -1;
	var x_distance = -1;
	var y_distance = -1;
	
	if (nearest_player != noone)
	{
		direct_distance = point_distance(x, y, nearest_player.x, nearest_player.y);
		
		x_distance = abs(nearest_player.x - x);
		y_distance = abs(nearest_player.y - y);
	}
	
	directional_distance_to_nearest_player = direct_distance;
	x_distance_to_nearest_player = x_distance;
	y_distance_to_nearest_player = y_distance;
}