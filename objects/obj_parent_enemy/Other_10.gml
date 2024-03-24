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
	state = _new_behavior;
	
	behavior_timer = 0;
}