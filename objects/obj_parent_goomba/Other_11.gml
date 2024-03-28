///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[enemy_state.walk] = function()
{
	processDamage();
	
	handleEnemyMovementAndCollision();
}

state_machine[enemy_state.die] = function()
{	
	handleEnemyMovementAndCollision();
}

state_machine[enemy_state.stomped] = function()
{
	state_timer++;
	
	if (state_timer == death_sequence_timing)
	{ instance_destroy(); }
}

//=======================================================================================
// STATE TRANSITIONS
//=======================================================================================

///@func checkIfDead()
checkIfDead = function()
{
	if (hp < 0)
	{
		if (damage_data.inflicted_type = damage_type.jump)
		{ standardStompTransition(); }
		
		else
		{ standardDeathTransition(); }
	}
}