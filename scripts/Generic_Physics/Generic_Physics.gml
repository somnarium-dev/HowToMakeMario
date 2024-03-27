function handleGravity()
{
	if (!process_gravity) { return; }
	
	//Get gravity direction and strength.
	var g_direction = global.gravity_direction;
	var g_strength = global.gravity_data[gravity_context].strength;
	
	//Apply strength per axis.
	var horizontal_strength = lengthdir_x(g_strength, g_direction);
	var vertical_strength = lengthdir_y(g_strength, g_direction);
	
	var horizontal_sign = sign(horizontal_strength);
	var vertical_sign = sign(vertical_strength);
	
	if (!checkForImpassable(x + horizontal_sign, y))
	&& (horizontal_sign != 0)
	{
		inflicted_h_gravity = horizontal_strength;
	}
	
	if (!checkForImpassable(x, y + vertical_sign))
	&& (vertical_sign != 0)
	{
		inflicted_v_gravity = vertical_strength;
	}
}

function handleHorizontalAcceleration(_input)
{
	if (!process_acceleration) { return; }
	
	//Handle acceleration;
	var absolute_speed = abs(h_speed);
	var h_sign = sign(h_speed);
	
	//If we have not yet reached top speed, accelerate.
	if (absolute_speed < current_top_speed)
	{ 
		var starting_speed = h_speed;
		
		var adjustment = (_input * accel_rate);
		
		var new_speed = starting_speed + adjustment;
	
		//If the proposed new speed would exceed the current top speed,
		//Then cap it to the current top speed.
		if (abs(new_speed) > current_top_speed)
		{ new_speed = _input * current_top_speed; }
	
		//If the starting speed was zero,
		if (starting_speed == 0)
		&& (abs(new_speed) != 0)
		&& (abs(new_speed) < 1)
		{ new_speed += sign(new_speed) * h_startup_boost; }
	
		//Update h_speed.
		h_speed = new_speed;
	}
	
	//Update tracking.
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
	
	//Handle deceleration.
	if (absolute_speed != 0)
	&& (cap_to_top_speed)
	{
		if (_input == 0)
		|| (absolute_speed > current_top_speed)
		{
			//If it's possible to decelerate without crossing zero
			//Then do so.
			if (absolute_speed > decel_rate)
			{
				adjustment = h_sign * decel_rate;
				
				new_speed = h_speed - adjustment;
			}
		
			//Otherwise, snap to zero.
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
		if (_input != 0)
		&& (_input != h_sign)
		{
			//If it's possible to decelerate without crossing zero
			//Then do so.
			if (absolute_speed > decel_rate)
			{ h_speed -= h_sign * decel_rate; }
		
			//Otherwise, snap to zero.
			else
			{ h_speed = 0; }
		}
	}
	
	//Update tracking.
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
}

function handleVerticalAcceleration(_short_jump_triggered)
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
		
		if (new_speed > terminal_velocity)
		{ new_speed = g_sign * terminal_velocity; }
	
		v_speed = new_speed;
	}
	
	//Update tracking.
	v_sign = sign(v_speed);
	absolute_speed = abs(v_speed);
	
	//Handle short jumping.
	if (_short_jump_triggered)
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
			if (absolute_speed > decel_rate)
			{ v_speed -= (v_sign * decel_rate); }
		
			else
			{ v_speed = 0; }
		}
	}
	
	//Update tracking.
	v_sign = sign(v_speed);
	absolute_speed = abs(v_speed);
}

function handleInflictedAcceleration()
{
	if (!process_inflicted_acceleration) { return; }
	
	//Prepare.
	var new_inflicted_h_speed = inflicted_h_speed;
	var new_inflicted_v_speed = inflicted_v_speed;
	
	var absolute_inflicted_h_speed = abs(new_inflicted_h_speed);
	var absolute_inflicted_v_speed = abs(new_inflicted_v_speed);
	
	var h_sign = sign(new_inflicted_h_speed);
	var v_sign = sign(new_inflicted_v_speed);
	
	//Handle horizontal deceleration.
	if (absolute_inflicted_h_speed > decel_rate)
	{ new_inflicted_h_speed -= h_sign * decel_rate; }
		
	else
	{ new_inflicted_h_speed = 0; }
	
	//Handle vertical deceleration.
	if (absolute_inflicted_v_speed > decel_rate)
	{ new_inflicted_v_speed -= v_sign * decel_rate; }
		
	else
	{ new_inflicted_v_speed = 0; }
	
	//Set new speeds.
	inflicted_h_speed = new_inflicted_h_speed;
	inflicted_v_speed = new_inflicted_v_speed;
}

function handlePixelAccumulation()
{
	if (!process_pixel_accumulation) { return; }
	
	var combined_h_speed = h_speed + inflicted_h_speed;
	var combined_v_speed = v_speed + inflicted_v_speed;
	
	//Accumulate pixels.
	horizontal_pixels_accumulated += combined_h_speed;
	vertical_pixels_accumulated += combined_v_speed;
	
	//Count complete pixels.
	var integer_h_pixels = horizontal_pixels_accumulated div 1;
	var integer_v_pixels = vertical_pixels_accumulated div 1;
	
	//Remove complete pixels from accumulated pixels.
	horizontal_pixels_accumulated -= integer_h_pixels;
	vertical_pixels_accumulated -= integer_v_pixels;
	
	//Queue complete pixels.
	horizontal_pixels_queued += integer_h_pixels;
	vertical_pixels_queued += integer_v_pixels;
	
	//Count complete adjustment pixels.
	var integer_adjustment_h_pixels = adjustment_h_pixels div 1;
	var integer_adjustment_v_pixels = adjustment_v_pixels div 1;
	
	//Remove complete adjustment pixels from accumulated adjustment pixels.
	adjustment_h_pixels -= integer_adjustment_h_pixels;
	adjustment_v_pixels -= integer_adjustment_v_pixels;
	
	//Accumulate pixels.
	horizontal_pixels_queued += integer_adjustment_h_pixels;
	vertical_pixels_queued += integer_adjustment_v_pixels;
}

function updateObjectPosition()
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
		
			else
			{ 
				y += v_adjustment;
				actual_movement_this_frame_y += v_adjustment;
				vertical_pixels_queued -= v_adjustment;
			}
		}
	}
}

function checkForImpassable(_x, _y)
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
			
		if (this_object.impassable)
		{
			return true;
		}
	}
    
	return false;
}

function checkForCollisionWithAnotherEnemy(_x, _y)
{
	if (!process_collision_detection) { return false; }
	
	ds_list_clear(impassable_list);
        
	var _num = instance_place_list(_x, _y, obj_parent_enemy, impassable_list, true);
	
	for (var i = 0;  i < _num; i++)
	{
		var this_object = impassable_list[|i];
		
		//This is to make sure we can't get stuck inside of other enemies.
		if (instance_place(x,y,this_object))
		{ continue; }
			
		return true;
	}
    
	return false;
}