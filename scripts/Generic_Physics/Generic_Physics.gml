function handleMovementAndCollision()
{
}

function handleGravity()
{
	if (!process_gravity) { return; }
	
	var g_direction = global.gravity_direction;
	var g_strength = global.gravity_data[gravity_context].strength;
	
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

function handleHorizontalAcceleration(_input, _acceleration, _deceleration)
{
	if (!process_acceleration) { return; }
	
	//Handle acceleration;
	var absolute_speed = abs(h_speed);
	var h_sign = sign(h_speed);
	
	if (absolute_speed < current_top_speed)
	{ 
		var adjustment = (_input * _acceleration);
		
		var new_speed = h_speed + adjustment;
		
		if (abs(new_speed) > current_top_speed)
		{ new_speed = _input * current_top_speed; }
	
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
			if (absolute_speed > _deceleration)
			{
				adjustment = h_sign * _deceleration;
				
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
		if (_input != 0)
		&& (_input != h_sign)
		{
			if (absolute_speed > _deceleration)
			{ h_speed -= h_sign * _deceleration; }
		
			else
			{ h_speed = 0; }
		}
	}
}

function handleVerticalAcceleration(_short_jump_triggered, _deceleration)
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
			if (absolute_speed > _deceleration)
			{ v_speed -= (v_sign * _deceleration); }
		
			else
			{ v_speed = 0; }
		}
	}
}

function handleInflictedAcceleration()
{
	if (!process_inflicted_acceleration) { return; }
	
	//Prepare.
	var new_h_speed = inflicted_h_speed;
	var new_v_speed = inflicted_v_speed;
	
	var absolute_h_speed = abs(new_h_speed);
	var absolute_v_speed = abs(new_v_speed);
	
	var h_sign = sign(new_h_speed);
	var v_sign = sign(new_v_speed);
	
	//Handle horizontal deceleration.
	if (absolute_h_speed > global.player_1.decel_rate)
	{ new_h_speed -= h_sign * global.player_1.decel_rate; }
		
	else
	{ new_h_speed = 0; }
	
	//Handle vertical deceleration.
	if (absolute_v_speed > global.player_1.decel_rate)
	{ new_v_speed -= v_sign * global.player_1.decel_rate; }
		
	else
	{ new_v_speed = 0; }
	
	//Set new speeds.
	inflicted_h_speed = new_h_speed;
	inflicted_v_speed = new_v_speed;
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
	
	//If it's not possible to move in the queued direction,
	//clear the related variables to prevent issues.
	var h_sign = sign(horizontal_pixels_queued);
	var v_sign = sign(vertical_pixels_queued);
	
	if (checkForImpassable(x + h_sign, y))
	{
		h_speed = 0;
		inflicted_h_speed = 0;
		
		horizontal_pixels_accumulated = 0;
		horizontal_pixels_queued = 0;
	}
	
	if (checkForImpassable(x, y + v_sign))
	{
		v_speed = 0;
		inflicted_v_speed = 0;
		
		vertical_pixels_accumulated = 0;
		vertical_pixels_queued = 0;
	}
}

function updateObjectPosition()
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
			
		if (this_object.impassable == true)
		{ return true; }
	}
    
	return false;
}