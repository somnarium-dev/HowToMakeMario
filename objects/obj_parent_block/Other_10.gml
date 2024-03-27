///@desc Custom Methods

///@func blockDetectStrikes()
blockDetectStrikes = function()
{	
	strike_data = blockStrikeDetection(x, y + 1);
	if (strike_data.striker == noone) { strike_data = blockStrikeDetection(x - 1, y); }
	if (strike_data.striker == noone) { strike_data = blockStrikeDetection(x + 1, y); }
	if (strike_data.striker == noone) { strike_data = blockStrikeDetection(x, y - 1); }
}

///@func blockStrikeDetection(_x, _y)
blockStrikeDetection = function(_x, _y)
{	
	ds_list_clear(strike_detection_list);
	
	var h_sign = sign(_x - x);
	var v_sign = sign(_y - y);
	
	var strike_direction = point_direction(_x, _y, x, y);
	
	//This is used to ensure that, if we're checking on a diagonal,
	//we get horizontal *and* vertical confirmation.
	var confirmations = 0;
	var required_confirmations = abs(h_sign) + abs(v_sign);
		
	var _num = instance_place_list(_x, _y, obj_parent_levelobject, strike_detection_list, true);
	
	for (var i = 0;  i < _num; i++)
	{
		var this_object = strike_detection_list[|i];
		
		//We now have an external object that could theoretically strike this object.
		//To check if it did, let's determine its attempted movement this frame.
		
		//A striking object may be in the correct position, but it may not be able to
		//inflict a strike from that specific angle.
		
		//Example: Mario cannot hit a coin block just by walking into it from the side.
		
		var valid_striker_direction_h = false;
		var valid_striker_direction_v = false;
		
		if (h_sign == 1 && this_object.can_strike_objects.left)
		|| (h_sign == -1 && this_object.can_strike_objects.right)
		{ valid_striker_direction_h = true; }
		
		if (v_sign == 1 && this_object.can_strike_objects.above)
		|| (v_sign == -1 && this_object.can_strike_objects.below)
		{ 
			//We should also make sure the striker's literal x position is within
			//the left and right boundaries of this object.
			
			if (this_object.x > bbox_left) //Makes it so there's not a "gap" between blocks that does nothing.
			&& (this_object.x <= bbox_right)
			{valid_striker_direction_v = true;}
		}
		
		//If it attempted to move toward this object, from a position directly next to it,
		//Then we register a strike.
		
		//We check to see if the sign of the striker's attempted movement is opposite the check.
		//This would indicate movement toward the object.
		
		var this_object_h_sign = sign(this_object.attempted_movement_this_frame_x);
		var this_object_v_sign = sign(this_object.attempted_movement_this_frame_y);
		
		//Now, let's assess our conditions.
		confirmations = 0;
		
		if (h_sign != 0)
		&& (valid_striker_direction_h)
		&& (this_object_h_sign == h_sign * -1)
		{ confirmations++; }
		
		if (v_sign != 0)
		&& (valid_striker_direction_v)
		&& (this_object_v_sign == v_sign * -1)
		{ confirmations++; }
		
		//If we have as many confirmations as required, we have a strike!
		if (confirmations == required_confirmations)
		{ return {striker: this_object.id, animation_direction: strike_direction}; }
	}
	
	return {striker: noone, animation_direction: -1};
}

///@func generateContents()
generateContents = function()
{
	//This will vary depending on the object,
	//but the below function should cover most cases.
	
	if (contents == noone) { return; }
	
	playSFX(contents_sfx);
	
	var these_contents = instance_create_layer(x, y, "Players", contents);
	these_contents.depth = depth + 1;
	these_contents.collector = strike_data.striker;
	
	contents = noone;
	idle_sprite = hit_sprite;
}