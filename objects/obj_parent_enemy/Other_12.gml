///@desc Behavior Management

// Inherit the parent event
event_inherited();

behavior_machine[enemy_behavior.idle] = function()
{ }

behavior_machine[enemy_behavior.patrol] = function()
{
	// Stop trying to move if dead.
	if (hp < 1)
	{ ai_input_lr = 0; }
	
	// Otherwise, turn around when bumping walls.
	else if (failedToMoveHorizontally())
	{ ai_input_lr *= -1; }
}