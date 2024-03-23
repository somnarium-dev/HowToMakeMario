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
	
	handleHorizontalAcceleration(input_lr, global.player_1.accel_rate, global.player_1.decel_rate);
	handleVerticalAcceleration(input_jump_released, 0);
	
	handleInflictedAcceleration(global.player_1.decel_rate);
	
	handlePixelAccumulation();
	updateObjectPosition();
	
	updatePLevel();
}

///@func determineTopHSpeed()
determineTopHSpeed = function()
{	
	if (can_reach_max_speed)
	{ current_top_speed = global.player_1.max_speed; }
	
	else if (input_run_held)
	&& (can_reach_run_speed)
	{ current_top_speed = global.player_1.run_speed; }
	
	else
	{ current_top_speed = global.player_1.walk_speed; }
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
		{
			should_reduce_charge = true;
		}
		
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

///@func updateState(_new_state)
updateState = function(_new_state, _change_sprite = true)
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