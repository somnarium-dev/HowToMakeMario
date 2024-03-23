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