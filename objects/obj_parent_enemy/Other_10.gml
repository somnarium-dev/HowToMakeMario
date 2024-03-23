///@desc Custom Functions

///@func handleEnemyMovementAndCollision()
handleEnemyMovementAndCollision = function()
{
	determineTopHSpeed();
	
	handleHorizontalAcceleration(ai_input_lr, accel_rate, decel_rate);
	handleVerticalAcceleration();
	
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updateObjectPosition();
}

///@func determineTopHSpeed();
determineTopHSpeed = function()
{
}

///@func handleVerticalAcceleration()
handleVerticalAcceleration = function()
{
}