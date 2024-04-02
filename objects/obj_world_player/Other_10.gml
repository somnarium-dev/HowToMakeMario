///@desc Custom Methods

//=================================================================================================
// INPUT HANDLING
//=================================================================================================

///@func generatePlayerInputs()
generatePlayerInputs = function()
{
	generateStandardInputs();

	input_run_pressed = false;
	input_run_held = false;
	input_run_released = false;
	
	input_jump_pressed = false;
	input_jump_held = false;
	input_jump_released = false;
	
	input_lr = 0;
	input_ud = 0;

	input_direction = 0;
	previous_input_direction = input_direction;
}

///@func readPlayerInput()
readPlayerInput = function()
{
	if (!global.accept_player_input) { return; }
	if (global.pause_during_transition) { return; }
	
	input_manager.run();
	
	input_run_pressed = run.checkPressed();
	input_run_held = run.check();
	input_run_released = run.checkReleased();
	
	input_jump_pressed = jump.checkPressed();
	input_jump_held = jump.check();
	input_jump_released = jump.checkReleased();
	
	input_lr = right.check() - left.check();
	input_ud = down.check() - up.check();
	
	if (input_lr != 0 || input_ud != 0)
	{
		previous_input_direction = input_direction;
		input_direction = point_direction(0,0, input_lr, input_ud);
	}
}

//=======================================================================================
// MOVEMENT CONTROL
//=======================================================================================

///@func tryToMove()
tryToMove = function()
{
	var attempted_to_move = (input_lr != 0 || input_ud != 0);
	var attempted_to_move_diagonally = (input_lr != 0 && input_ud != 0);
	
	// If not trying to move, return.
	if (!attempted_to_move)
	{ return false; }
	
	// Ensure this object only moves orthogonally.
	// If input is diagonal, horizontal movement takes precedent.
	move_direction = input_direction;
	
	if (attempted_to_move_diagonally)
	{ move_direction = point_direction(0,0, input_lr, 0); }
	
	// Check if it's possible to move.
	var movement_possible = permittedToMove();
	var not_blocked_by_obstacle = notBlockedByObstacle()
	
	if (movement_possible)
	&& (not_blocked_by_obstacle)
	{ 
		playSFX(sfx_mapmove);
		move_distance = movement_check_distance;
		move_x = lengthdir_x(1, move_direction);
		move_y = lengthdir_y(1, move_direction);
		return true;
	}
	
	// Otherwise, indicate the attempted move was not possible.
	if (bump_sound_timer == 0)
	{
		bump_sound_timer = bump_sound_buffer_timing;
		playSFX(sfx_bump);
	}
	
	return false;
}

///@func permittedToMove
permittedToMove = function()
{
	var check_x = x + lengthdir_x(movement_check_distance, move_direction);
	var check_y = y + lengthdir_y(movement_check_distance, move_direction);
	
	var moving_to_valid_destination = instance_position(check_x, check_y, obj_world_map_path);
	
	var current_level_indicator = instance_position(x, y, obj_parent_world_level_indicator);
	
	var permitted_to_move = true;
	
	// Check if there's a valid landing destination ahead.
	// If not, return false.
	if (!moving_to_valid_destination)
	{ permitted_to_move = false; }
	
	// If on top of a level indicator...
	if (current_level_indicator != noone)
	{
		var level_cleared = current_level_indicator.cleared;
		
		var previous_x = global.player_data[global.current_player].map_coordinates._previous_x;
		var previous_y = global.player_data[global.current_player].map_coordinates._previous_y;
		
		var moving_backward = (check_x == previous_x) && (check_y == previous_y);
		
		// If the level is not cleared, the player can only move backward.
		if (!level_cleared)
		&& (!moving_backward)
		{ permitted_to_move = false; }
	}
	
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
		return true;
	}
	
	return false;
}

///@func handleKickback()
handleKickback = function()
{
	if (x != kickback_x)
	|| (y != kickback_y)
	{
		var distance_to_destination = point_distance(x, y, kickback_x, kickback_y)
		
		if (distance_to_destination > move_speed)
		{
			var kickback_direction = point_direction(x, y, kickback_x, kickback_y);
			var next_x = x + lengthdir_x(move_speed, kickback_direction);
			var next_y = y + lengthdir_y(move_speed, kickback_direction);
			
			x = round(next_x);
			y = round(next_y);
		}
		
		else
		{
			x = kickback_x;
			y = kickback_y;
			
			updatePlayerMapCoordinates();
		}
		
		return false;
	}
	
	else
	{ return true; }
}

//=======================================================================================
// INTERNAL FUNCTIONALITY
//=======================================================================================

///@func updateMapSprites()
updateMapSprites = function()
{
	current_power = global.player_data[global.current_player].current_power;
	sprites = global.player_data[global.current_player].sprites[current_power];
	
	pin_sprite = sprites[player_state.pin];
	map_sprite = sprites[player_state.map];
}

///@func updateMapState(_new_state)
updateMapState = function(_new_state)
{
	global.player_data[global.current_player].map_state = _new_state;
	state_timer = 0;
}

//=======================================================================================
// EXTERNAL FUNCTIONALITY
//=======================================================================================

///@func updatePlayerMapCoordinates()
updatePlayerMapCoordinates = function()
{
	// Take the most recently recorded coordinates, and push the values to previous coordinates.
	// Then, overwrite those coordinates with current coordinates.
	
	var old_x = global.player_data[global.current_player].map_coordinates._x;
	var old_y = global.player_data[global.current_player].map_coordinates._y;
	
	global.player_data[global.current_player].map_coordinates._previous_x = old_x;
	global.player_data[global.current_player].map_coordinates._previous_y = old_y;
	
	global.player_data[global.current_player].map_coordinates._x = x;
	global.player_data[global.current_player].map_coordinates._y = y;
}

///@func getSelectedLevel()
getSelectedLevel = function()
{	
	var current_level_indicator = instance_position(x, y, obj_parent_world_level_indicator);
	
	// If not on top of a level indicator, return.
	if (current_level_indicator == noone)
	{ return; }
	
	target_level = current_level_indicator.level_contained;
}