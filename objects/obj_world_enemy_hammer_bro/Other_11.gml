///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[enemy_map_state.idle] = function()
{
	autoshiftSpriteHorizontally();
}

state_machine[enemy_map_state.shuffle] = function()
{
	resetHorizontalSpriteShift();
	image_speed = 1;
	
	var can_move = tryToMoveMapEnemy();
	
	if (can_move)
	{ state = enemy_map_state.move; }
	
	else
	{
		updateEnemyMapCoordinates()
		state = enemy_map_state.idle;
	}
}

state_machine[enemy_map_state.move] = function()
{
	setSpriteDirectionPerLRInput(move_x);
	image_speed = 2;
	
	var finished_moving = processMapMovement();
	
	if (finished_moving)
	{ state = enemy_map_state.shuffle; }
}