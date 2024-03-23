///@desc Custom Functions

///@func handleEnemyMovementAndCollision()
handleEnemyMovementAndCollision = function()
{
	determineTopHSpeed();
	
	handleHorizontalAcceleration();
	handleVerticalAcceleration();
	
	handleHorizontalMovement();
	handleVerticalMovement();
}

///@func determineTopHSpeed();
determineTopHSpeed = function()
{
}

///@func handleHorizontalAcceleration()
handleHorizontalAcceleration = function()
{
	//Handle Acceleration
	var absolute_speed = abs(h_speed);
	var h_sign = sign(h_speed);
 
	if (absolute_speed < current_top_speed)
	{
		var adjustment = (ai_input_lr * accel_rate);
		var new_speed = h_speed + adjustment;
 
		if (abs(new_speed) > current_top_speed)
		{ new_speed = ai_input_lr * current_top_speed; }
 
		h_speed = new_speed;
	}
 
	//update tracking
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
 
	//Handle deceleration
	if (absolute_speed != 0)
	{ 
		//if player makes no directional input
		//or player speed exceeds maximum
		if (ai_input_lr == 0)
		|| (absolute_speed > current_top_speed)
		{
			//if player can decelerate without passing 0
			if (absolute_speed > decel_rate)
			{
				adjustment = (h_sign) * decel_rate; // amount to decrease by
				new_speed = h_speed - adjustment;
			}
 
			else
			{ new_speed = 0; }
 
			h_speed = new_speed;
		}
	}
	
	//Update tracking
	h_sign = sign(h_speed);
	absolute_speed = abs(h_speed);
 
	//Braking.
	if (absolute_speed != 0)
	{
		if (ai_input_lr != 0)
		&& (ai_input_lr != h_sign)
		{
			if (absolute_speed > decel_rate)
			{ 
				new_speed = h_speed;
				adjustment = h_sign * decel_rate;
				new_speed -= adjustment;
			}
			else
			{ new_speed = 0; }
			h_speed = new_speed;
		}
	}
}

///@func handleVerticalAcceleration()
handleVerticalAcceleration = function()
{
}

///@func handleHorizontalMovement()
handleHorizontalMovement = function()
{
	var repetitions = abs(h_speed);
	var adjustment = sign(h_speed);
 
	repeat(repetitions)
	{
		var next_position_blocked = place_meeting(x+adjustment, y, obj_parent_collision);
 
		if (next_position_blocked)
		{
			h_speed = 0;
			break;
		}
 
		x += adjustment;
	}
}
 
///@func handleVerticalMovement()
handleVerticalMovement = function()
{
	var repetitions = abs(v_speed);
	var adjustment = sign(v_speed);
 
	repeat(repetitions)
	{
		var next_position_blocked = place_meeting(x, y+adjustment, obj_parent_collision);
 
		if (next_position_blocked)
		{
			v_speed = 0;
			break;
		}
 
		y += adjustment;
	}
}