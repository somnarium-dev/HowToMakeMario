event_inherited();

///@func handleItemBoxContentsMovementAndCollision()
handleItemBoxContentsMovementAndCollision = function()
{	
	handleGravity();
	
	handleHorizontalAcceleration(ai_input_lr);
	handleVerticalAcceleration(ai_input_jump_released);
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updateObjectPosition();
}