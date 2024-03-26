///@desc Custom Methods

///@func blockProcessHit()
blockProcessHit = function()
{
	//If the block isn't idle, just clear the array.
	//We don't want to "queue" hits.
	if (state != block_state.idle)
	{
		strike_array = [];
		return;
	}
	
	//Otherwise:
	else
	{
		var hits = array_length(strike_array);
	
		//If there were no hits recorded this frame, return.
		if (hits < 1) { return; }
		
		//As it stands, what should be a single impact hits over four frames. Why?
		show_debug_message($"Hits: {hits}");
		
		hit_from = undefined;
		
		for (var i = 0; i < hits; i++)
		{
			var _x = strike_array[i].hit_from_h_sign
			var _y = strike_array[i].hit_from_v_sign;
		
			hit_from = point_direction(x, y, x-_x, y-_y);
			show_debug_message($"Point Direction: ({x}, {y}, {x-_x}, {y-_y})")
			show_debug_message($"Hit from direction: {hit_from}");
		}
	
		//Reset the strike array.
		strike_array = [];
	
		//If none of the hits were valid, bug out.
		if (hit_from == undefined) { return; }
	
		show_debug_message($"BONK");
		
		state = block_state.animate_out;
		animate_toward = hit_from - 180;
	}
}