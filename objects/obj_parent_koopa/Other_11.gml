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
	image_speed = abs(shell_direction);
	
	setSpriteDirectionPerLRInput(shell_direction);
	
	handleEnemyMovementAndCollision();
	
	if (failedToMoveHorizontally())
	{ playSFX(sfx_bump); } 
	
	checkIfJumpedOn();
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
	if (damage_data.inflicted_type == damage_type.jump)
	|| (damage_data.inflicted_type == damage_type.touch)
	{	
		handleShellKick();
		
		//If not shelled:
		if (state == enemy_state.walk)
		{
			can_strike_objects = {above: true, below: false, left: true, right: true};
			updateObjectState(enemy_state.shell);
		}
	}
}