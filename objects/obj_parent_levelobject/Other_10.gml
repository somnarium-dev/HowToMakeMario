///@desc Custom Methods

///@func clearDamageData()
clearDamageData = function()
{
	damage_data = 
	{
		inflicted_type: damage_type.none,
		inflicted_power: 0,
		attacker:  noone
	}
}

///@func failedToMoveHorizontally()
failedToMoveHorizontally = function()
{	
	if (attempted_movement_this_frame_x != 0)
	&& (actual_movement_this_frame_x == 0)
	{ return true; }
	
	return false;
}

///@func failedToMoveVertically()
failedToMoveVertically = function()
{
	if (attempted_movement_this_frame_y != 0)
	&& (actual_movement_this_frame_y == 0)
	{ return true; }
	
	return false;
}

///@func checkIfAboutToMoveOffCliff()
checkIfAboutToMoveOffCliff = function(_movement_indicator_value)
{
	// Reset.
	cliff_detected = false;
	
	// Check ahead.
	var h_sign = sign(_movement_indicator_value);
	
	if (checkForImpassable(x, y+1))
	&& (!checkForImpassable(x + h_sign, y + 8))
	{ cliff_detected = true; }
}