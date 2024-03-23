///@desc State Management
state_machine = [];

state_machine[enemy_state.stand] = function()
{
	handleEnemyMovementAndCollision();
}

state_machine[enemy_state.walk] = function()
{
	handleEnemyMovementAndCollision();
}

state_machine[enemy_state.die] = function()
{
	
}