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
	
	handleHorizontalAcceleration(ai_input_lr, accel_rate, decel_rate);
	handleVerticalAcceleration(ai_input_jump_released, decel_rate);
	handleInflictedAcceleration(decel_rate);
	
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

///@func getProximityToNearestPlayer()
getProximityToNearestPlayer = function()
{
	var nearest_player = instance_nearest(x, y, obj_parent_player);
	
	var directional = -1;
	var horizontal = -1;
	var vertical = -1;
	
	if (nearest_player != noone)
	{
		directional = point_distance(x, y, nearest_player.x, nearest_player.y);
		horizontal = abs(x - nearest_player.x);
		vertical = abs(y - nearest_player.y);
	}
	
	directional_distance_to_nearest_player = directional;
	horizontal_distance_to_nearest_player = horizontal;
	vertical_distance_to_nearest_player = vertical;
}