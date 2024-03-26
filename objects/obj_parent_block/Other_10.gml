///@desc Custom Methods

///@func blockProcessHit()
blockProcessHit = function()
{
	if (process_hit)
	{
		show_debug_message($"BONK");
		
		state = block_state.animate_out;
		animate_toward = hit_from - 180;
	}
}

///@func blockAnimateOut()
blockAnimateOut = function()
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

///@func blockAnimateIn()
blockAnimateIn = function()
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