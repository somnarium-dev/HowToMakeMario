///@desc State Machine
state_machine = [];

//Awaiting a hit while filled.
state_machine[block_state.idle] = function()
{
	blockDetectStrikes();
	
	if (strike_data.striker != noone)
	{
		sprite_index = hit_sprite;
		
		playSFX(sfx_bump);
		
		generateContents();
		
		animate_toward = strike_data.animation_direction;
		
		state = block_state.animate_out;
	}
}

//Awaiting a hit.
state_machine[block_state.empty] = function()
{
	blockDetectStrikes();
	
	if (strike_data.striker != noone)
	{
		sprite_index = hit_sprite;
		
		playSFX(sfx_bump);
		
		animate_toward = strike_data.animation_direction;
		
		state = block_state.animate_out;
	}
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
		sprite_index = idle_sprite;
		
		state = block_state.idle;
		
		if (contents == noone)
		{ 
			state = block_state.empty;
			idle_sprite = hit_sprite;
			sprite_index = idle_sprite;
		}
		
		state_timer = 0;
	}
}

//Self destruct
state_machine[block_state.destroyed] = function()
{
	instance_destroy();
}