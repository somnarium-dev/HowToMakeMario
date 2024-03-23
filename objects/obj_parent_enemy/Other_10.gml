///@desc Custom Functions

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