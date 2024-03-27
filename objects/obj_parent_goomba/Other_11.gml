// Inherit the parent event
event_inherited();

state_machine[enemy_state.walk] = function()
{
	handleEnemyMovementAndCollision();
	
	var jump_attacked = jumpAttackDetection(sprite_height - 2);
	
	if (jump_attacked)
	{ 
		playSFX(sfx_stomp);
		
		state = enemy_state.die;
		ai_input_lr = 0;
		sprite_index = spr_goomba_brown_stomped;
	}
}

state_machine[enemy_state.die] = function()
{
	state_timer++;
	
	if (state_timer == death_sequence_timing)
	{ instance_destroy(); }
}