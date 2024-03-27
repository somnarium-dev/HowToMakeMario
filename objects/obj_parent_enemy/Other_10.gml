///@desc Custom Functions

//=================================================================================================
// INPUT
//=================================================================================================

///@func clearAIFrameInputs()
clearAIFrameInputs = function()
{
	ai_input_run_pressed = false;
	ai_input_run_held = false;
	ai_input_run_released = false;

	ai_input_jump_pressed = false;
	ai_input_jump_held = false;
	ai_input_jump_released = false;
}

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
	updateObjectPosition();
}

///@func determineTopHSpeed()
determineTopHSpeed = function()
{	
	//This space left empty by design.
}

//=================================================================================================
// STATE AND BEHAVIOR CONTROL
//=================================================================================================

///@func updateState(_new_state)
updateState = function(_new_state)
{
	state = _new_state;
}

///@func updateBehavior(_new_behavior)
updateBehavior = function(_new_behavior)
{
	behavior = _new_behavior;
	
	behavior_timer = 0;
}

//=================================================================================================
// MISC
//=================================================================================================

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