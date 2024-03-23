///@desc Custom Functions

///@func handleEnemyMovementAndCollision()
handleEnemyMovementAndCollision = function()
{
	determineTopHSpeed();
	
	handleHorizontalAcceleration(ai_input_lr, accel_rate, decel_rate);
	handleVerticalAcceleration(ai_input_jump_released, decel_rate);
	
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updateObjectPosition();
}

//========================================================================================

///@func determineTopHSpeed()
determineTopHSpeed = function()
{	
	//This space left empty by design.
}