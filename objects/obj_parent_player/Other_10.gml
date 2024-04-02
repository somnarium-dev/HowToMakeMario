///@desc Custom Methods

// Inherit the parent event
event_inherited();

//=================================================================================================
// INPUT HANDLING
//=================================================================================================

///@func generatePlayerInputs()
generatePlayerInputs = function()
{
	generateStandardInputs();

	input_run_pressed = false;
	input_run_held = false;
	input_run_released = false;
	
	input_jump_pressed = false;
	input_jump_held = false;
	input_jump_released = false;
	
	input_lr = 0;
	input_ud = 0;

	input_direction = 0;
	previous_input_direction = input_direction;
}

///@func readPlayerInput()
readPlayerInput = function()
{
	if (!global.accept_player_input) { return; }
	if (global.pause_during_transition) { return; }
	
	input_manager.run();
	
	input_run_pressed = run.checkPressed();
	input_run_held = run.check();
	input_run_released = run.checkReleased();
	
	input_jump_pressed = jump.checkPressed();
	input_jump_held = jump.check();
	input_jump_released = jump.checkReleased();
	
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
	
	//Reset tracking.
	starting_x = x;
	starting_y = y;
	
	attempted_movement_this_frame_x = horizontal_pixels_queued;
	attempted_movement_this_frame_y = vertical_pixels_queued;
	
	actual_movement_this_frame_x = 0;
	actual_movement_this_frame_y = 0;
	
	//Prepare.
	var h_sign = sign(h_speed);
	var v_sign = sign(v_speed);
	
	var h_adjustment = sign(horizontal_pixels_queued);
	var v_adjustment = sign(vertical_pixels_queued);
	
	var h_pixels = abs(horizontal_pixels_queued);
	var v_pixels = abs(vertical_pixels_queued);
	
	var repetitions = max(h_pixels, v_pixels);
	
	// While pixels remain in a given queue:
	
	// If it's not possible to move in the direction queued
	// AND that is the direction this object is intending to move
	// Zero out speed and queued pixels.
	
	// Next, handle direction specific checks for interruptions.
	
	// Otherwise, move one pixel in the specified direction.
	
	repeat (repetitions)
	{
		// If both queues have zeroed out, break.
		if (vertical_pixels_queued == 0)
		&& (horizontal_pixels_queued == 0)
		{ break; }
		
		//============
		// HORIZONTAL
		//============
		if (horizontal_pixels_queued != 0)
		{
			// Stop if the next pixel is impassable.
			if (checkForImpassable(x + h_adjustment, y))
			&& (h_sign == h_adjustment)
			{ 
				h_speed = 0;
				horizontal_pixels_queued = 0;
			}
			
			// If not otherwise interrupted, move.
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
			// Stop if the next pixel is impassable.
			if (checkForImpassable(x, y + v_adjustment))
			&& (v_sign == v_adjustment)
			{ 
				v_speed = 0;
				vertical_pixels_queued = 0;
			}
			
			// If this object should bounce on an enemy, handle that next.
			else if (shouldBounceOffOfEnemy(v_adjustment))
			{ bounceOffOfEnemy(v_adjustment); }
		
			// If not otherwise interrupted, move.
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
	var this_damage_type = damage_type.none;
	var this_damage = 0;
	var this_attacker = noone;
	
	// Damage from shells.
	if (other.state == enemy_state.shell)
	{
		var h_sign = sign(other.x - x);
		var speed_sign = sign(other.h_speed);
		
		// An unmoving shell does not inflict damage.
		if (speed_sign == 0) { return; }
		
		// If the shell is moving toward the player,
		// Then take damage.
		if (speed_sign == (-1 * h_sign))
		&& ((other.y - y) < other.safe_stomp_height)
		{ 
			this_damage_type = damage_type.shell;
			this_damage = other.touch_damage_power;
			this_attacker = other.id;
		}
	}
	
	// Basic bump damage.
	else if (other.state != enemy_state.die)
	&& (other.state != enemy_state.stomped)
	&& ((other.y - y) < other.safe_stomp_height)
	{ 
		this_damage_type = damage_type.touch;
		this_damage = other.touch_damage_power;
		this_attacker = other.id;
	}
	
	damage_data = { inflicted_type: this_damage_type, inflicted_power: this_damage, attacker: this_attacker };
}

///@func shouldBounceOffOfEnemy(_v_adjustment)
shouldBounceOffOfEnemy = function(_v_adjustment)
{	
	var enemy = instance_place(x, y + 1, obj_parent_enemy);
	
	// Reasons *not* to bounce:
	if (enemy == noone) // There's not an enemy underneath you.
	|| (_v_adjustment < 1) // You're moving the wrong way.
	|| ((enemy.y - y) < enemy.safe_stomp_height) // Too low compared to enemy, unsafe.
	|| (!enemy.bounce_attacker_when_jump_attacked) // Enemy does not bounce you when jumped on.
	|| (state == player_state.die) // You are dead.
	{ return false; }
	
	// Alright, looks like we're bouncing.
	return true;
}
	
///@func bounceOffOfEnemy()
bounceOffOfEnemy = function()
{	
	// Clear the vertical pixel queue.
	vertical_pixels_queued = 0;
	
	// Handle the bounce height.
	var new_v_speed = -stat_block.flat_bounce_strength;
	
	if (input_jump_held)
	{ new_v_speed = -stat_block.jump_strength; }
	
	v_speed = new_v_speed;
	
	// Inform the victim.		
	var enemy = instance_place(x, y + 1, obj_parent_enemy);

	enemy.damage_data.inflicted_type = damage_type.jump;
	enemy.damage_data.inflicted_power = 1;
	enemy.damage_data.attacker = id;
}

///@func updatePLevel()
updatePLevel = function()
{	
	var current_speed = abs(h_speed);
	
	if (input_run_held)
	&& (current_speed >= run_speed)
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
	
	stat_block.plevel = plevel_charge div plevel_pip_value;
}

//=================================================================================================
// STATE TRANSITION
//=================================================================================================

///@func processDamage()
processDamage = function()
{
	checkIfDamaged();
	checkIfDead();
}

///@func checkIfDamaged()
checkIfDamaged = function()
{
	if (damage_data.inflicted_type == damage_type.none)
	{ return; }
	
	hp -= damage_data.inflicted_power;
	
	clearDamageData();
	
	damaged_this_frame = true;
}

///@func checkIfDead()
checkIfDead = function()
{
	if (y > room_height + 32)
	{ hp = 0; }

	if (hp < 1)
	|| (marked_for_death)
	{
		if (state != player_state.die)
		{ transitionToDeathState(); }
	}
}

///@func atMaxPLevel()
atMaxPLevel = function()
{
	if (stat_block.plevel >= global.plevel_max)
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
// OBJECT INTERACTIONS
//=================================================================================================

///@func checkForShellKicks()
checkForShellKicks = function()
{
	if (other.state == enemy_state.shell)
	&& ((other.y - y) < other.safe_stomp_height)
	&& (other.shell_direction == 0)
	{
		// Handle this object's display.
		kicking = true;
		kick_timer = 0;
		sprite_index = sprites[player_state.kick]
		
		// Inform the victim.		
		other.damage_data.inflicted_type = damage_type.touch;
		other.damage_data.inflicted_power = 1;
		other.damage_data.attacker = id;
	}
}

//=================================================================================================
// INTERNAL FUNCTIONALITY
//=================================================================================================

///@func updateStats()
updateStats = function()
{
	h_startup_boost = stat_block.h_startup_boost;

	accel_rate = stat_block.accel_rate;
	decel_rate = stat_block.decel_rate;

	walk_speed = stat_block.walk_speed;
	run_speed = stat_block.run_speed;
	max_speed = stat_block.max_speed;

	current_top_speed = walk_speed;

	jump_strength = stat_block.jump_strength;
	moving_jump_strength = stat_block.moving_jump_strength;
}

///@func updateSprites()
updateSprites = function()
{
	sprites = stat_block.sprites[current_power];
	mask_index = sprites[player_state.mask];
}

///@func manageKickSprite()
manageKickSprite = function()
{
	if (kicking)
	&& (sprite_index != sprites[state])
	{ 
		kick_timer++; 
		if (kick_timer >= kick_timer_max)
		{ sprite_index = sprites[state]; }
	}
}

//=================================================================================================
// INTERNAL FUNCTIONALITY - DEATH SEQUENCE
//=================================================================================================

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