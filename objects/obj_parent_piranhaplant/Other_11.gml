// Inherit the parent event

// Inherit the parent event
event_inherited();

state_machine[enemy_state.stand] = function()
{
	updateHeadSprite();
	
	inputToAdjustmentPixels();
	handleFireControl();
	
	handleEnemyMovementAndCollision();
}