///@desc Behavior Management
event_inherited();

behavior_machine[enemy_behavior.attack] = function()
{
	//Turn around when bumping walls.
	if (failedToMoveHorizontally())
	{ shell_direction *= -1; }
	
	ai_input_lr = shell_direction;
}

behavior_machine[enemy_behavior.patrol] = function()
{
	//Stop trying to move if shelled.
	if (damage_data.inflicted_type = damage_type.jump)
	{ updateObjectBehavior(enemy_behavior.attack); }
	
	//Otherwise, turn around when bumping walls.
	else if (failedToMoveHorizontally())
	{ ai_input_lr *= -1; }
}