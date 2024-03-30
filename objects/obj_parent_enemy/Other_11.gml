///@desc State Management

// Inherit the parent event
event_inherited();

state_machine[enemy_state.stand] = function()
{ handleEnemyMovementAndCollision(); }

state_machine[enemy_state.walk] = function()
{ handleEnemyMovementAndCollision(); }

state_machine[enemy_state.die] = function()
{ handleEnemyMovementAndCollision(); }

//=============================================================================
// STATE TRANSITIONS
//=============================================================================

///@func standardDeathTransition()
standardDeathTransition = function()
{
	playSFX(sfx_kick);
	
	// "Jump" upward and flip the sprite over.
	// Collision detection is disabled, so the object will fall out of view.
	bounce_attacker_when_jump_attacked = false;
	process_collision_detection = false;
	
	sprite_vertical_direction = -1;
	image_speed = 0;
	
	v_speed = -death_pop_strength;
	
	updateObjectState(enemy_state.die);
}

///@func standardStompTransition()
standardStompTransition = function()
{
	playSFX(sfx_stomp);
	
	bounce_attacker_when_jump_attacked = false;
	
	sprite_index = sprites.stomped;
	
	updateObjectState(enemy_state.stomped);
}