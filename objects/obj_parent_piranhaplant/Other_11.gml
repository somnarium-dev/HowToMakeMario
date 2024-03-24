// Inherit the parent event
event_inherited();

state_machine[enemy_state.stand] = function()
{
	updateSpitterHeadSprite();
	
	inputToAdjustmentPixels();
	handleFireControl();
	
	handleEnemyMovementAndCollision();
}