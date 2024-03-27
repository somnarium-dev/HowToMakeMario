///@desc Behavior Management
event_inherited();

behavior_machine[enemy_behavior.patrol] = function()
{
	if (failedToMoveHorizontally())
	{ ai_input_lr *= -1; }
}