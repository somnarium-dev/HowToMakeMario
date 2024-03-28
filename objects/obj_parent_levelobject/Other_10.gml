///@desc Custom Methods

///@func clearDamageData()
clearDamageData = function()
{
	damage_data.inflicted_type = damage_type.none;
	damage_data.inflicted_power = 0;
	damage_data.attacker = noone;
}

///@func checkIfAboutToMoveOffCliff()
checkIfAboutToMoveOffCliff = function(_movement_indicator_value)
{
	//Can't walk off of a cliff while in midair.
	if (!checkForImpassable(x, y+1))
	{ 
		cliff_detected = false;
		return;
	}
	
	//Otherwise, check ahead.
	var h_sign = sign(_movement_indicator_value);
	
	if (!checkForImpassable(x + h_sign, y + 8))
	{ 
		cliff_detected = true;
		return;
	}
	
	cliff_detected =  false;
	return;
}