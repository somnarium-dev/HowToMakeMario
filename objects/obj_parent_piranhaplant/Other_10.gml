///@desc Custom Functions

// Inherit the parent event
event_inherited();

//=================================================================================================
// INPUT
//=================================================================================================

///@func inputToAdjustmentPixels()
inputToAdjustmentPixels = function()
{	
	var adjustment_amount = extension_increment * ai_input_ud;
	
	var adjustment_x = lengthdir_x(adjustment_amount, direction);
	var adjustment_y = lengthdir_y(adjustment_amount, direction);
	
	adjustment_h_pixels += adjustment_x;
	adjustment_v_pixels += adjustment_y;
	
	extension += adjustment_amount;
	extension = clamp(extension, 0, max_extension)
}

//=================================================================================================
// MOVEMENT AND COLLISION
//=================================================================================================

///@func handleEnemyMovementAndCollision()
handleEnemyMovementAndCollision = function()
{
	//Piranha plants do not have a top speed.
	
	//Piranha plants are not affected by gravity.
	
	handleHorizontalAcceleration(ai_input_lr, accel_rate, decel_rate);
	handleVerticalAcceleration(ai_input_jump_released, decel_rate);
	handleInflictedAcceleration(decel_rate);
	
	handlePixelAccumulation();
	updateObjectPosition();
}

///@func updateSpitterHeadSprite()
updateSpitterHeadSprite = function()
{
	var current_target = instance_nearest(x, y, obj_parent_player);
	var angle_to_target = point_direction(x, y, current_target.x, current_target.y);
	
	var new_image_index = image_index mod 4;
	
	if (!mouth_is_open)
	{ new_image_index = (angle_to_target div 90); }
	
	if (mouth_is_open)
	{ new_image_index += 4; }
	
	image_index = new_image_index;
}

//=================================================================================================
// FIRE CONTROLLER
//=================================================================================================

///@func handleFireControl()
handleFireControl = function()
{
	//Don't run this function for biters.
	if (!is_spitter)
	{ exit; }
	
	//Increment the timer if we're post fireball.
	if (mouth_is_open)
	{ state_timer++; }
	
	//If the mouth shut timer elapses, close the mouth.
	if (state_timer == mouth_shut_timing)
	{
		mouth_is_open = false;
		state_timer = 0;
	}
	
	//If the ai wants to fire, open the mouth and spawn a fireball.
	if (ai_input_run_pressed) 
	&& (state_timer == 0)
	{
		mouth_is_open = true;
		createFireball();
	}
}

///@func createFireball()
createFireball = function()
{
	//Create instance
	//Set speed at angle
	
	var shooting_angle = ((image_index mod 4) * 90) + 45;
	
	var x_offset = lengthdir_x(6, shooting_angle);
	var y_offset = lengthdir_y(6, shooting_angle);
	
	var new_fireball = instance_create_layer(x + x_offset, y + y_offset, "Players", obj_piranha_spitter_fireball);
	new_fireball.direction = shooting_angle;
}