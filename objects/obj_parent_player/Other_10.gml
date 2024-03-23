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
	
	handleGravity(); //Genericized
	
	handleHorizontalAcceleration();
	handleVerticalAcceleration();
	
	handleInflictedAcceleration();
	
	handlePixelAccumulation();
	updateObjectPosition(); //Genericized
	
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
	//show_debug_message($"Old state: {state},\n New state: {_new_state},\n Change sprite: {_change_sprite}");
	
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