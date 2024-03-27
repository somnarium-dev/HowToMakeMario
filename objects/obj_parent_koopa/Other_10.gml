///@desc Custom Methods

// Inherit the parent event
event_inherited();

///@func handleShellBounce()
handleShellBounce = function()
{	
	playSFX(sfx_kick);
	
	move_through_enemies = true;
		
	current_top_speed = shell_speed;
		
	sprite_index = sprites.shell;
	image_speed = 0;
	image_index = 0;
	
	if (state == enemy_state.shell)
	{
		var new_direction = -1 * sign(damage_data.attacker.x - x);
			
		if (new_direction == 0)
		{ new_direction = damage_data.attacker.sprite_horizontal_direction; }
			
		if (shell_direction == 0)
		{ shell_direction = new_direction}
			
		else
		{ shell_direction = 0; } 
	}
		
	clearDamageData();
}