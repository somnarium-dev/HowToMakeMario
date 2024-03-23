///@desc Custom Methods

///@func updateSprites()
updateSprites = function()
{
	sprites = global.player_1.sprites[current_power];
	mask_index = sprites[player_state.mask];
}

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
///@func handlePlayerMovementAndCollision()
handlePlayerMovementAndCollision = function()
{
	determineTopHSpeed();
	
	handleGravity();
	
	handleHorizontalAcceleration();
	handleInflictedHorizontalAcceleration();
	handleHorizontalPixelAccumulation();
	
	handleVerticalAcceleration();
	handleInflictedVerticalAcceleration()
	handleVerticalPixelAccumulation();
	
	updateObjectPositionIncrementally();
	
	updatePLevel();
}

///@func handleHorizontalAcceleration()
handleHorizontalAcceleration = function()
{
	if (!process_acceleration) { return; }
	
	//Handle acceleration;
	var absolute_speed = abs(h_speed);
	var h_sign = sign(h_speed);
	
	if (absolute_speed < current_top_speed)
	{ 
		var adjustment = (input_lr * global.player_1.accel_rate);
		
		var new_speed = h_speed + adjustment;
		
		if (abs(new_speed) > current_top_speed)
		{ new_speed = input_lr * current_top_speed; }
	
		h_speed = new_speed;
	}
	
	//Update tracking.
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
	
	//Handle deceleration.
	if (absolute_speed != 0)
	&& (cap_to_top_speed)
	{
		if (input_lr == 0)
		|| (absolute_speed > current_top_speed)
		{
			if (absolute_speed > global.player_1.decel_rate)
			{
				adjustment = h_sign * global.player_1.decel_rate;
				
				new_speed = h_speed - adjustment;
			}
		
			else
			{ new_speed = 0; }
			
			h_speed = new_speed;
		}
	}
	
	//Update tracking.
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
	
	//Handle braking.
	if (absolute_speed != 0)
	{
		if (input_lr != 0)
		&& (input_lr != h_sign)
		{
			if (absolute_speed > global.player_1.decel_rate)
			{ h_speed -= h_sign * global.player_1.decel_rate; }
		
			else
			{ h_speed = 0; }
		}
	}
}

///@func handleInflictedHorizontalAcceleration()
handleInflictedHorizontalAcceleration = function()
{
	if (!process_inflicted_acceleration) { return; }
	
	//Prepare.
	var new_speed = inflicted_h_speed;
	var absolute_speed = abs(new_speed);
	
	//Handle deceleration.
	if (absolute_speed > global.player_1.decel_rate)
	{ new_speed += ((sign(new_speed) * -1) * global.player_1.decel_rate); }
		
	else
	{ new_speed = 0; }
	
	//Set new speed.
	inflicted_h_speed = new_speed;
}

///@func handleHorizontalPixelAccumulation()
handleHorizontalPixelAccumulation = function()
{
	if (!process_pixel_accumulation) { return; }
	
	var combined_h_speed = h_speed + inflicted_h_speed;
	
	//Accumulate and queue pixels.
	horizontal_pixels_accumulated += combined_h_speed;
	
	var integer_pixels = horizontal_pixels_accumulated div 1;
	horizontal_pixels_accumulated -= integer_pixels;
	
	horizontal_pixels_queued += integer_pixels;
	
	var integer_adjustment_pixels = adjustment_h_pixels div 1;
	adjustment_h_pixels -= integer_adjustment_pixels;
	
	horizontal_pixels_queued += integer_adjustment_pixels;
	
	//If it's not possible to move in the queued direction,
	//clear the variables to prevent issues.
	var h_sign = sign(horizontal_pixels_queued);
	
	if (checkForImpassable(x + h_sign, y))
	{
		h_speed = 0;
		inflicted_h_speed = 0;
		
		horizontal_pixels_accumulated = 0;
		horizontal_pixels_queued = 0;
	}
}

///@func handleVerticalAcceleration()
handleVerticalAcceleration = function()
{
	if (!process_acceleration) { return; }
	
	//Handle acceleration;
	var absolute_speed = abs(v_speed);
	var v_sign = sign(v_speed);
	
	var g_power = abs(inflicted_v_gravity);
	var g_sign = sign(inflicted_v_gravity);
	var terminal_velocity = global.gravity_data[gravity_context].terminal_velocity;
	
	if (v_speed < terminal_velocity)
	{ 
		var adjustment = (g_sign * g_power);
		
		var new_speed = v_speed + adjustment;
		
		if (abs(new_speed) > terminal_velocity)
		{ new_speed = g_sign * terminal_velocity; }
	
		v_speed = new_speed;
	}
	
	//Update tracking.
	v_sign = sign(v_speed);
	absolute_speed = abs(v_speed);
	
	//Handle short jumping.
	if (input_jump_released)
	&& (v_sign != 0)
	&& (v_sign != g_sign)
	{ v_speed = 0; }
	
	//Update tracking.
	v_sign = sign(v_speed);
	absolute_speed = abs(v_speed);
	
	//Handle deceleration.
	if (absolute_speed != 0)
	{
		if (g_sign == 0)
		|| (g_sign != v_sign)
		|| (absolute_speed > terminal_velocity)
		{
			if (absolute_speed > global.player_1.decel_rate)
			{ v_speed += ((-1 * v_sign) * global.player_1.decel_rate); }
		
			else
			{ v_speed = 0; }
		}
	}
}

///@func handleInflictedVerticalAcceleration()
handleInflictedVerticalAcceleration = function()
{
	if (!process_inflicted_acceleration) { return; }
	
	//Prepare.
	var new_speed = inflicted_v_speed;
	var absolute_speed = abs(new_speed);
	
	//Handle deceleration.
	if (absolute_speed > global.player_1.decel_rate)
	{ new_speed += ((sign(new_speed) * -1) * global.player_1.decel_rate); }
		
	else
	{ new_speed = 0; }
	
	//Set new speed.
	inflicted_v_speed = new_speed;
}

///@func handleVerticalPixelAccumulation()
handleVerticalPixelAccumulation = function()
{	
	if (!process_pixel_accumulation) { return; }
	
	var combined_v_speed = v_speed + inflicted_v_speed
	
	//Accumulate and queue vertical pixels.
	vertical_pixels_accumulated += combined_v_speed;
	
	var integer_pixels = vertical_pixels_accumulated div 1;
	vertical_pixels_accumulated -= integer_pixels;
	
	vertical_pixels_queued += integer_pixels;
	
	var integer_adjustment_pixels = adjustment_v_pixels div 1;
	adjustment_v_pixels -= integer_adjustment_pixels;
	
	vertical_pixels_queued += integer_adjustment_pixels;
	
	//If it's not possible to move in the queued direction,
	//clear the variables to prevent issues.
	var v_sign = sign(vertical_pixels_queued);
	
	if (checkForImpassable(x, y + v_sign))
	{
		v_speed = 0;
		inflicted_v_speed = 0;
		
		vertical_pixels_accumulated = 0;
		vertical_pixels_queued = 0;
	}
}

///@func handleDiagonalMovement()
handleDiagonalMovement = function()
{
	if (!process_movement) { return; }
	
	//Determine the number of diagonal pixels.
	//A diagonal pixel is when we have at least one horizontal and one
	//vertical pixel to cover at the same time.
	
	//We're going to handle those pixels by alternating between
	//horizontal and vertical checks.
	
	var horizontal_sign = sign(horizontal_pixels_queued);
	var vertical_sign = sign(vertical_pixels_queued);
	
	var abs_horizontal_pixels_queued = abs(horizontal_pixels_queued);
	var abs_vertical_pixels_queued = abs(vertical_pixels_queued);
	
	var diagonal_pixels = min(abs_horizontal_pixels_queued, abs_vertical_pixels_queued);
	
	repeat (diagonal_pixels)
	{
		handleHorizontalMovement(horizontal_sign);
		handleVerticalMovement(vertical_sign);
	}
}

///@func handleHorizontalMovement(_pixels);
handleHorizontalMovement = function(_pixels)
{
	if (!process_movement) { return; }
	
	var repetitions = abs(_pixels);
	var adjustment = sign(_pixels);
	
	repeat (repetitions)
	{
		if (checkForImpassable(x + adjustment, y))
		{
			var h_speed_sign = sign(h_speed)
			
			if (h_speed_sign == adjustment)
			{ 
				h_speed = 0;
				horizontal_pixels_queued = 0;
				break;
			}
		}
		
		else
		{ x += adjustment; }
		
		horizontal_pixels_queued -= adjustment;
	}
}

///@func handleVerticalMovement(_pixels);
handleVerticalMovement = function(_pixels)
{
	if (!process_movement) { return; }
	
	var repetitions = abs(_pixels);
	var adjustment = sign(_pixels);
	
	repeat (repetitions)
	{
		if (checkForImpassable(x, y + adjustment))
		{
			var v_speed_sign = sign(v_speed)
			
			if (v_speed_sign == adjustment)
			{ 
				v_speed = 0;
				vertical_pixels_queued = 0;
				break;
			}
		}
		
		else
		{ y += adjustment; }
		
		vertical_pixels_queued -= adjustment;
	}
}

///@func updateObjectPositionIncrementally()
updateObjectPositionIncrementally = function()
{
	if (!process_movement) { return; }
	
	var h_sign = sign(h_speed);
	var v_sign = sign(v_speed);
	
	var h_adjustment = sign(horizontal_pixels_queued);
	var v_adjustment = sign(vertical_pixels_queued);
	
	var h_pixels = abs(horizontal_pixels_queued);
	var v_pixels = abs(vertical_pixels_queued);
	
	var repetitions = max(abs(h_pixels), abs(v_pixels));
	
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
			//If it's not possible to move in the direction queued
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
				horizontal_pixels_queued -= h_adjustment;
			}
		}
		
		//============
		// VERTICAL
		//============
		if (vertical_pixels_queued != 0)
		{
			//If it's not possible to move in the direction queued
			//AND that is the direction the player is intending to move
			//Zero out speed and queued pixels.
			if (checkForImpassable(x, y + v_adjustment))
			&& (v_sign == v_adjustment)
			{ 
				v_speed = 0;
				vertical_pixels_queued = 0;
			}
		
			else
			{ 
				y += v_adjustment;
				vertical_pixels_queued -= v_adjustment;
			}
		}
	}
}

///@func checkForImpassable()
checkForImpassable = function(_x, _y)
{
	if (!process_collision_detection) { return false; }
	
	ds_list_clear(impassable_list);
        
	var _num = instance_place_list(_x, _y, obj_parent_collision, impassable_list, true);
	
	var h_sign = sign(_x - x);
	var v_sign = sign(_y - y);
	
	for (var i = 0;  i < _num; i++)
	{
		var this_object = impassable_list[|i];
		
		//This is to make sure we can't get stuck inside of objects.
		if (instance_place(x,y,this_object))
		{ continue; }
		
		
		if (this_object.object_index = obj_collision_1way)
		{
			
			show_debug_message("BLIP");
			
			var pass_through_direction = this_object.image_angle;
			
			if (pass_through_direction == 0)   && (h_sign != -1)  { continue; }
			if (pass_through_direction == 90)  && (v_sign != 1)   { continue; }
			if (pass_through_direction == 180) && (h_sign != 1)	  { continue; }
			if (pass_through_direction == 270) && (v_sign != -1)  { continue; }
		}
			
		if (this_object.impassable == true)
		{ return true; }
	}
    
	return false;
}

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

//========================================================================================

///@func setSpriteDirectionPerLRInput()
setSpriteDirectionPerLRInput = function()
{
	if (input_lr != 0)
	{ sprite_direction = input_lr; }
}

///@func setImageSpeedPerHSpeed()
setImageSpeedPerHSpeed = function()
{
	image_speed = (h_speed / global.player_1.walk_speed);
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
	show_debug_message($"New state: {_new_state}, Change sprite: {_change_sprite}");
	
	state = _new_state;
	
	if (_change_sprite)
	{ sprite_index = sprites[state]; }
	
	can_reach_max_speed = array_contains(states_that_can_accelerate_to_max_speed, state);
	can_reach_run_speed = array_contains(states_that_can_accelerate_to_run_speed, state);
	cap_to_top_speed = array_contains(states_that_cap_to_top_speed, state);
}

//========================================================================================

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