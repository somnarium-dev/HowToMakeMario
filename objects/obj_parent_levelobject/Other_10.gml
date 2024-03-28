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

///@func checkIfAboutToMoveOffCliff()
checkIfAboutToMoveOffCliff = function(_movement_indicator_value)
{
	//Reset.
	cliff_detected = false;
	
	//Check ahead.
	var h_sign = sign(_movement_indicator_value);
	
	if (checkForImpassable(x, y+1))
	&& (!checkForImpassable(x + h_sign, y + 8))
	{ cliff_detected = true; }
}