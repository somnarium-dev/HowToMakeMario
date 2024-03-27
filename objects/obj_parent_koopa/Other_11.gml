///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[enemy_state.walk] = function()
{
	setSpriteDirectionPerLRInput(ai_input_lr);
	
	handleEnemyMovementAndCollision();
	
	checkIfJumpedOn();
}

state_machine[enemy_state.shell] = function()
{
	if (shell_direction != 0)
	{ sprite_horizontal_direction = shell_direction;}
	
	image_speed = abs(shell_direction);
	
	checkIfJumpedOn();
	
	handleEnemyMovementAndCollision();
	
	if (failedToMoveHorizontally())
	{ playSFX(sfx_bump); } 
}

state_machine[enemy_state.die] = function()
{
	state_timer++;
	
	if (state_timer == death_sequence_timing)
	{ instance_destroy(); }
}

//=============================================================================
// STATE TRANSITIONS
//=============================================================================

///@func checkIfJumpedOn()
checkIfJumpedOn = function()
{	
	if (jump_attack.registered)
	{
		handleShellBounce();
		
		//If not shelled:
		if (state == enemy_state.walk)
		{ updateObjectState(enemy_state.shell); }
	}
}