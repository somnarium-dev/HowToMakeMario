///@desc State Machine

// Inherit the parent event
event_inherited();

//Awaiting a hit while filled.
state_machine[block_state.idle] = function()
{
	// Check if this block was triggered.
	blockDetectStrikes();
	
	// If it was, then transition to the animation state.
	if (strike_data.striker != noone)
	{
		sprite_index = hit_sprite;
		
		playSFX(sfx_bump);
		
		generateContents();
		
		animate_toward = strike_data.animation_direction;
		
		updateObjectState(block_state.animate_out);
	}
}

// Awaiting a hit.
state_machine[block_state.empty] = function()
{
	// Check if this block was triggered.
	blockDetectStrikes();
	
	// If it was, then transition to the animation state.
	if (strike_data.striker != noone)
	{
		sprite_index = hit_sprite;
		
		playSFX(sfx_bump);
		
		animate_toward = strike_data.animation_direction;
		
		updateObjectState(block_state.animate_out);
	}
}

//Animate away from the direction of a hit.
state_machine[block_state.animate_out] = function()
{	
	state_timer++;
	
	display_offset_x += lengthdir_x(1, animate_toward);
	display_offset_y += lengthdir_y(1, animate_toward);
	
	if (state_timer == animation_timing)
	{ updateObjectState(block_state.animate_in); }
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
		
		var new_state = block_state.idle;
		
		if (contents == noone)
		{ 
			new_state = block_state.empty;
			idle_sprite = hit_sprite;
			sprite_index = idle_sprite;
		}
		
		updateObjectState(new_state);
	}
}

//Self destruct
state_machine[block_state.destroyed] = function()
{
	instance_destroy();
}