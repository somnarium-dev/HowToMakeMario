///@desc Custom Functions

// Inherit the parent event
event_inherited();

//=================================================================================================
// INPUT
//=================================================================================================

///@func inputToAdjustmentPixels()
inputToAdjustmentPixels = function()
{	
	//We treat "up" as extending from a pipe in any direction.
	//Similarly, "down" is retreating into the pipe.
	var adjustment_amount = extension_increment * ai_input_ud;
	
	//Extend "up" per the adjustment amount, relative to current direction.
	var adjustment_x = lengthdir_x(adjustment_amount, direction);
	var adjustment_y = lengthdir_y(adjustment_amount, direction);
	
	adjustment_h_pixels += adjustment_x;
	adjustment_v_pixels += adjustment_y;
	
	//This ensures we don't over extend or retreat too far.
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
	
	//Piranha plants only need to process inflicted acceleration.
	handleInflictedAcceleration(decel_rate);
	
	handlePixelAccumulation();
	updateObjectPosition();
}

///@func updateHeadSprite()
updateHeadSprite = function()
{
	//Spitters
	if (is_spitter)
	{
		image_speed = 0;
		
		//No point in continuing if there's nothing to spit at.
		if (current_target == noone) { exit; }
		
		//Get the angle to the nearest player target.
		var angle_to_target = point_direction(x, y, current_target.x, current_target.y);
	
		//Get the current image index- reducing by four if increased from being open mouthed.
		//This closes the mouth automatically if the relevant variable resets to false.
		var new_image_index = image_index mod 4;
	
		//If the mouth is not currently open, rotate to aim per the calculated angle.
		//There are four frames of rotation in the sprite's animation, so we div by 90.
		//This leaves us with possible values of 0, 1, 2, or 3, which match nicely.
		if (!mouth_is_open)
		{ new_image_index = (angle_to_target div 90); }
	
		//If the mouth is open, then increase proposed new image index by four.
		//The last four frames of the sprite are open mouthed (4, 5, 6, 7).
		else
		{ new_image_index += 4; }
	
		//Update image index with final calculated result.
		image_index = new_image_index;
	}
	
	//Biters
	else
	{ image_angle = direction; }
}

//=================================================================================================
// BEHAVIORAL
//=================================================================================================

///@func targetNearestPlayer()
targetNearestPlayer = function()
{
	current_target = instance_nearest(x, y, obj_parent_player);
}

///@func isThreatened()
isThreatened = function()
{
	return threat_detector.threat_detected;
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

//=================================================================================================
// SPAWNERS
//=================================================================================================

///@func createPiranhaPlantThreatDetector()
createPiranhaPlantThreatDetector = function()
{
	//Relative box coordinates pre-rotation.
	var detector_cos_offset_amount_1 = 8 - (16 * pipe_length_in_tiles);
	var detector_sin_offset_amount_1 = -16;
	var detector_cos_offset_amount_2 = 7;
	var detector_sin_offset_amount_2 = 15;

	var cos_direction = direction;
	var sin_direction = direction - 90;

	//Cos and sin offsets for x1 and y1.
	var detector_cos_offset_x_1 = lengthdir_x(detector_cos_offset_amount_1, cos_direction);
	var detector_cos_offset_y_1 = lengthdir_y(detector_cos_offset_amount_1, cos_direction);

	var detector_sin_offset_x_1 = lengthdir_x(detector_sin_offset_amount_1, sin_direction);
	var detector_sin_offset_y_1 = lengthdir_y(detector_sin_offset_amount_1, sin_direction);

	//Cos and sin offsets for x2 and y2.
	var detector_cos_offset_x_2 = lengthdir_x(detector_cos_offset_amount_2, cos_direction);
	var detector_cos_offset_y_2 = lengthdir_y(detector_cos_offset_amount_2, cos_direction);

	var detector_sin_offset_x_2 = lengthdir_x(detector_sin_offset_amount_2, sin_direction);
	var detector_sin_offset_y_2 = lengthdir_y(detector_sin_offset_amount_2, sin_direction);

	//Final coordinate offsets.
	var detector_x_1_offset = detector_cos_offset_x_1 + detector_sin_offset_x_1;
	var detector_y_1_offset = detector_cos_offset_y_1 + detector_sin_offset_y_1;

	var detector_x_2_offset = detector_cos_offset_x_2 + detector_sin_offset_x_2;
	var detector_y_2_offset = detector_cos_offset_y_2 + detector_sin_offset_y_2;

	//Final coordinates.
	//If the first part of a pair is lower than the second, reverse the pair.
	//Each coordinate is expanded outward so as to detect *near* the pipe.
	var detector_x1 = min(detector_x_1_offset, detector_x_2_offset) - 1;
	var detector_x2 = max(detector_x_1_offset, detector_x_2_offset) + 1;
	var detector_y1 = min(detector_y_1_offset, detector_y_2_offset) - 1;
	var detector_y2 = max(detector_y_1_offset, detector_y_2_offset) + 1;
	
	//Perform final adjustments.
	detector_x2++; //I think this is weirdness from the position of the origin pixel.
	
	var quadrant = direction div 90; //This is trig magic, relates to rotational matrixes.
	
	switch (quadrant)
	{
		case 0:
			break;
			
		case 1:
			detector_y1--;
			detector_y2--;
			break;
			
		case 2:
			detector_x1--;
			detector_x2--;
			detector_y1--;
			detector_y2--;
			break;
			
		case 3:
			detector_x1--;
			detector_x2--;
			break;
	}

	//Create the threat detector.
	var this_threat_detector =	instance_create_layer
								(
									x,
									y,
									"System",
									obj_player_detector,
									{
										source: id,
										direction: direction,
										follow_source: false,
										range_x1: detector_x1,
										range_y1: detector_y1,
										range_x2: detector_x2,
										range_y2: detector_y2,
									}
								);
						
	return this_threat_detector;
}

///@func createFireball()
createFireball = function()
{
	//No point in continuing if there's nothing to spit at.
	if (current_target == noone) { exit; }
	
	//Determine the simulated angle of the head.
	var spitting_angle = ((image_index mod 4) * 90) + 45;
	
	//Use the spitting angle to determine the fireball's starting coordinates.
	var x_offset = lengthdir_x(6, spitting_angle);
	var y_offset = lengthdir_y(6, spitting_angle);
	
	//Now determine the angle from the offset position to the target. 
	var shooting_angle = point_direction(x + x_offset, y + y_offset, current_target.x, current_target.y);
	
	//Create the fireball.
	var new_fireball = instance_create_layer(x + x_offset, y + y_offset, "Projectiles", obj_piranha_spitter_fireball);
	
	//Point the new fireball so that it travels along the shooting angle.
	new_fireball.direction = shooting_angle;
}