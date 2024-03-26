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
	state_timer++;
	
	display_offset_x += lengthdir_x(1, animate_toward);
	display_offset_y += lengthdir_y(1, animate_toward);
	
	if (state_timer == animation_timing)
	{
		state = block_state.animate_in;
		state_timer = 0;
	}
}

//Animate toward original position.
state_machine[block_state.animate_in] = function()
{
	state_timer++;
	
	display_offset_x -= lengthdir_x(1, animate_toward);
	display_offset_y -= lengthdir_y(1, animate_toward);
	
	if (state_timer == animation_timing)
	{
		state = block_state.idle;
		state_timer = 0;
		
		process_hit = false;
	}
}

//Self destruct
state_machine[block_state.destroyed] = function()
{
	instance_destroy();
}