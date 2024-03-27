state_machine = []

state_machine[item_from_block_state.idle] = function()
{
	handleItemBoxContentsMovementAndCollision();
}