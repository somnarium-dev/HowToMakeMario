// Inherit the parent event
event_inherited();

//Awaiting a hit while filled.
state_machine[block_state.idle] = function()
{
	blockDetectStrikes();
	
	state_timer++;
	
	if (state_timer >= waste_coins_timer)
	&& (coins_remaining < starting_coins)
	&& (coins_remaining > 1)
	{ coins_remaining = 1; }
	
	if (strike_data.striker != noone)
	{
		sprite_index = hit_sprite;
		
		playSFX(sfx_bump);
		
		generateContents();
		
		animate_toward = strike_data.animation_direction;
		
		state_timer = 0;
		
		state = block_state.animate_out;
	}
}