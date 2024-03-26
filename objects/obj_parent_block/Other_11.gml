///@desc State Machine
state_machine = [];

//Awaiting a hit.
state_machine[block_state.idle] = function()
{
	blockProcessHit();
}

//Animate away from the direction of a hit.
state_machine[block_state.animate_out] = function()
{
	blockAnimateOut();
}

//Animate toward original position.
state_machine[block_state.animate_in] = function()
{
	blockAnimateIn();
}

//Self destruct
state_machine[block_state.destroyed] = function()
{
	instance_destroy();
}