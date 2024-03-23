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