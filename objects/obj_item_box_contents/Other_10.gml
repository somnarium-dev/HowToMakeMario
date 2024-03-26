event_inherited();

///@func handleItemBoxContentsMovementAndCollision()
handleItemBoxContentsMovementAndCollision = function()
{	
	handleGravity();
	
	handleHorizontalAcceleration(ai_input_lr, accel_rate, decel_rate);
	handleVerticalAcceleration(ai_input_jump_released, decel_rate);
	handleInflictedAcceleration(global.player_1.decel_rate);
	
	handlePixelAccumulation();
	updateObjectPosition();
}