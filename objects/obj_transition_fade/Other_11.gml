///@desc State Machine

///@func transition_out()
transition_out = function()
{
	// If the transition out effect is not requested, max the timer.
	if (!do_transition_out) { timer = transition_out_timing; }
	else { timer++; }
	
	// Use the timer vs the transition timing to handle fading.
	image_alpha += (1 / transition_in_timing);
	
	// When the timer is maxed out, move to the transition pause state.
	if (timer == transition_out_timing)
	{
		timer = 0;
		image_alpha = 1;
		
		state = transition_pause;
	}
}

///@func transition_pause()
transition_pause = function()
{
	// Trigger the transition pause. All objects temporarily halt execution when this = true.
	global.pause_during_transition = true;
	
	// If the transition pause wasn't requested, max the timer.
	if (!do_transition_pause) { timer = transition_pause_timing; }
	else { timer++; }
	
	// If the timer is at maximum, move to the target room, and
	// change state to the transition in.
	if (timer == transition_pause_timing)
	{
		timer = 0;
		
		if (target_room != undefined)
		{ room_goto(target_room); }
		
		state = transition_in;
	}
}

///@func transition_in()
transition_in = function()
{
	// If the transition in was not requested, max out the timer.
	if (!do_transition_in) { timer = transition_in_timing; }
	else { timer++; }
	
	// Use the timer vs the transition timing to handle fading.
	image_alpha -= (1 / transition_in_timing);
	
	// If the timer is at maximum, destroy this object.
	if (timer == transition_in_timing)
	{ 
		image_alpha = 0;
		instance_destroy();
	}
}