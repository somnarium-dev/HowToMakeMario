///@desc Custom Methods

//=================================================================================================
// INPUT HANDLING
//=================================================================================================

///@func readPlayerInput()
readPlayerInput = function()
{
	if (!global.accept_player_input) { return; }
	if (global.pause_during_transition) { return; }
	
	input_manager.run();
	
	input_run_pressed = run.check_pressed();
	input_run_held = run.check();
	input_run_released = run.check_released();
	
	input_jump_pressed = jump.check_pressed();
	input_jump_held = jump.check();
	input_jump_released = jump.check_released();
	
	input_lr = right.check() - left.check();
	input_ud = down.check() - up.check();
	
	if (input_lr != 0 || input_ud != 0)
	{
		previous_input_direction = input_direction;
		input_direction = point_direction(0,0, input_lr, input_ud);
	}
}

//=================================================================================================
// MOVEMENT AND COLLISION
//=================================================================================================

///@func handlePlayerMovementAndCollision()
handlePlayerMovementAndCollision = function()
{	
	determineTopHSpeed();
	
	handleGravity();
	
	handleHorizontalAcceleration(input_lr);
	handleVerticalAcceleration(input_jump_released);
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updatePlayerPosition();
	
	updatePLevel();
}

///@func determineTopHSpeed()
determineTopHSpeed = function()
{	
	if (can_reach_max_speed)
	{ current_top_speed = max_speed; }
	
	else if (input_run_held)
	&& (can_reach_run_speed)
	{ current_top_speed = run_speed; }
	
	else
	{ current_top_speed = walk_speed; }
}

///@func updatePlayerPosition()
updatePlayerPosition = function()
{
	if (!process_movement) { return; }
	
	starting_x = x;
	starting_y = y;
	
	attempted_movement_this_frame_x = horizontal_pixels_queued;
	attempted_movement_this_frame_y = vertical_pixels_queued;
	
	actual_movement_this_frame_x = 0;
	actual_movement_this_frame_y = 0;
	
	var h_sign = sign(h_speed);
	var v_sign = sign(v_speed);
	
	var h_adjustment = sign(horizontal_pixels_queued);
	var v_adjustment = sign(vertical_pixels_queued);
	
	var h_pixels = abs(horizontal_pixels_queued);
	var v_pixels = abs(vertical_pixels_queued);
	
	var repetitions = max(h_pixels, v_pixels);
	
	repeat (repetitions)
	{
		//If both queues have zeroed out, break.
		if (vertical_pixels_queued == 0)
		&& (horizontal_pixels_queued == 0)
		{ break; }
		
		//============
		// HORIZONTAL
		//============
		if (horizontal_pixels_queued != 0)
		{
			//If it's not possible to move in the direction queued*
			//AND that is the direction the player is intending to move
			//Zero out speed and queued pixels.
			if (checkForImpassable(x + h_adjustment, y))
			&& (h_sign == h_adjustment)
			{ 
				h_speed = 0;
				horizontal_pixels_queued = 0;
			}
			
			else
			{
				x += h_adjustment;
				actual_movement_this_frame_x += h_adjustment;
				horizontal_pixels_queued -= h_adjustment;
			}
		}
		
		//============
		// VERTICAL
		//============
		if (vertical_pixels_queued != 0)
		{	
			//If it's not possible to move in the direction queued*
			//AND that is the direction the player is intending to move
			//Zero out speed and queued pixels.
			if (checkForImpassable(x, y + v_adjustment))
			&& (v_sign == v_adjustment)
			{ 
				v_speed = 0;
				vertical_pixels_queued = 0;
			}
			
			//If bouncing on an enemy, handle that next.
			else if (shouldBounceOffOfEnemy(v_adjustment))
			{ bounceOffOfEnemy(v_adjustment); }
		
			else
			{ 
				y += v_adjustment;
				actual_movement_this_frame_y += v_adjustment;
				vertical_pixels_queued -= v_adjustment;
			}
		}
	}
}

///@func checkForHarmfulEnemyCollision()
checkForHarmfulEnemyCollision = function()
{
	var do_get_hurt = false;
	
	if (other.state == enemy_state.shell)
	{
		var h_sign = sign(other.x - x);
		var speed_sign = sign(other.h_speed);
		
		//An unmoving shell does not inflict damage.
		if (speed_sign == 0) { return; }
		
		//If the shell is moving toward the player,
		//Then take damage.
		if (speed_sign == (-1 * h_sign))
		{ do_get_hurt = true; }
	}
	
	//Basic bump damage.
	else if (other.state != enemy_state.die)
	&& ((other.y - y) < other.safe_stomp_height)
	{ do_get_hurt = true; }
	
	if (do_get_hurt)
	{ marked_for_death = true; }
}

///@func shouldBounceOffOfEnemy(_v_adjustment)
shouldBounceOffOfEnemy = function(_v_adjustment)
{	
	var enemy = instance_place(x, y + 1, obj_parent_enemy);
	
	//Reasons *not* to bounce:
	
	//There's not an enemy underneath you.
	if (enemy == noone)
	{ return false; }
	
	//You're moving the wrong way.
	if (_v_adjustment < 1)
	{ return false; }
	
	//Too low compared to enemy. You're taking damage from this.
	if ((enemy.y - y) < enemy.safe_stomp_height)
	{ return false; }
	
	//Enemy does not bounce you when jumped on.
	if (!enemy.bounce_when_jump_attacked)
	{ return false; }
	
	//The enemy is already dead.
	if (enemy.state == enemy_state.die)
	{ return false; }
	
	//*YOU* are already dead.
	if (marked_for_death)
	{ return false; }
	
	//Alright, looks like we're bouncing.
	return true;
}
	
///@func bounceOffOfEnemy()
bounceOffOfEnemy = function()
{
	var enemy = instance_place(x, y + 1, obj_parent_enemy);
	
	var new_v_speed;
	
	//Clear the vertical pixel queue.
	vertical_pixels_queued = 0;
	
	//Handle the bounce height.
	if (input_jump_held)
	{ new_v_speed = -stat_block.jump_strength; }
	
	else
	{ new_v_speed = -stat_block.flat_bounce_strength; }
	
	//Inform the victim.		
	enemy.jump_attack.registered = true;
	enemy.jump_attack.attacker = id;
	
	//Update v speed.
	v_speed = new_v_speed;
}

///@func updatePLevel()
updatePLevel = function()
{	
	var current_speed = abs(h_speed);
	
	if (input_run_held)
	&& (current_speed >= global.player_1.run_speed)
	&& (checkForImpassable(x, y + 1))
	{ plevel_charge += plevel_charge_rate; }
	
	else
	{
		var should_reduce_charge = false;
		
		if (plevel_charge != plevel_charge_max)
		|| (checkForImpassable(x, y + 1))
		{ should_reduce_charge = true; }
		
		if (should_reduce_charge)
		{ plevel_charge--; }
	}
	
	plevel_charge = clamp(plevel_charge, 0, plevel_charge_max);
	
	global.player_1.plevel = plevel_charge div plevel_pip_value;
}

//=================================================================================================
// STATE TRANSITION
//=================================================================================================

///@func atMaxPLevel()
atMaxPLevel = function()
{
	if (global.player_1.plevel >= global.plevel_max)
	{ return true; }
	
	return false;
}

///@func updatePlayerState(_new_state)
updatePlayerState = function(_new_state, _change_sprite = true)
{	
	state = _new_state;
	
	if (_change_sprite)
	{ sprite_index = sprites[state]; }
	
	can_reach_max_speed = array_contains(states_that_can_accelerate_to_max_speed, state);
	can_reach_run_speed = array_contains(states_that_can_accelerate_to_run_speed, state);
	cap_to_top_speed = array_contains(states_that_cap_to_top_speed, state);
}

//=================================================================================================
// INTERNAL FUNCTIONALITY
//=================================================================================================

///@func updateSprites()
updateSprites = function()
{
	sprites = global.player_1.sprites[current_power];
	mask_index = sprites[player_state.mask];
}


//=================================================================================================
// INTERNAL FUNCTIONALITY - DEATH SEQUENCE
//=================================================================================================

///@func processDeathSequencing()
processDeathSequencing = function()
{
	timer--;
	
	if (death_sequence_phase == 2)
	{
		handlePlayerMovementAndCollision();
	}
	
	if (timer == 0)
	{ 
		if (death_sequence_phase == 2)
		{ transitionIrisToRoom(Initializer, true, true, false); }
		
		if (death_sequence_phase == 1)
		{
			death_sequence_phase = 2;
			timer = global.death_pause_timing.play_off_length;
			
			if (y < room_height + 32)
			{ v_speed = -4; }
		}
	}
}

///@func ceaseAllMovement()
ceaseAllMovement = function()
{
	inflicted_h_gravity = 0;
	inflicted_v_gravity = 0;

	h_speed = 0;
	v_speed = 0;

	inflicted_h_speed = 0;
	inflicted_v_speed = 0;

	horizontal_pixels_accumulated = 0;
	vertical_pixels_accumulated = 0;

	adjustment_h_pixels = 0;
	adjustment_v_pixels = 0;

	horizontal_pixels_queued = 0;
	vertical_pixels_queued = 0;
}

///@func clearAllInputVariables()
clearAllInputVariables = function()
{
	input_run_pressed = false;
	input_run_held = false;
	input_run_released = false;
	
	input_jump_pressed = false;
	input_jump_held = false;
	input_jump_released = false;
	
	input_lr = 0;
	input_ud = 0;
}

///@func applyPauseForDeathSequence()
applyPauseForDeathSequence = function()
{
	applyPauseTypeTo(pause_types.player_death_pause, obj_parent_enemy);
	applyPauseTypeTo(pause_types.player_death_pause, obj_parent_projectile);
	applyPauseTypeTo(pause_types.player_death_pause, obj_parent_block);
	applyPauseTypeTo(pause_types.player_death_pause, obj_parent_collectible);
}

//=================================================================================================
// DEBUG RELATED
//=================================================================================================

///@func updateAllNearbyCollisions()
updateAllNearbyCollisions = function()
{
	all_nearby_collisions[0]	= checkForImpassable(x + 1, y);
	all_nearby_collisions[45]	= checkForImpassable(x + 1, y - 1);
	all_nearby_collisions[90]	= checkForImpassable(x, y - 1);
	all_nearby_collisions[135]	= checkForImpassable(x - 1, y - 1);
	all_nearby_collisions[180]	= checkForImpassable(x - 1, y);
	all_nearby_collisions[225]	= checkForImpassable(x - 1, y + 1);
	all_nearby_collisions[270]	= checkForImpassable(x, y + 1);
	all_nearby_collisions[315]	= checkForImpassable(x + 1, y + 1);
}