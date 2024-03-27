///@desc State Machine

// Inherit the parent event
event_inherited();

state_machine[enemy_state.walk] = function()
{
	handleEnemyMovementAndCollision();
	
	if (hp < 0)
	{ 	
		playSFX(sfx_kick);
		sprite_index = spr_goomba_brown_stomped;
		updateObjectState(enemy_state.die);
	}
	
	if (jump_attack.registered)
	{ 	
		playSFX(sfx_stomp);
		sprite_index = spr_goomba_brown_stomped;
		updateObjectState(enemy_state.die);
	}
}

state_machine[enemy_state.die] = function()
{
	state_timer++;
	
	if (state_timer == death_sequence_timing)
	{ instance_destroy(); }
}