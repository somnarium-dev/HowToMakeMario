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