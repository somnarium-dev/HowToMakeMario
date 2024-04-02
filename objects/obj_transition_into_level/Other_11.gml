///@desc State Machine

///@func transition_out_slow()
transition_out_slow = function()
{
	// If the transition out effect is not requested, max the timer.
	if (!do_transition_out) { timer = transition_out_slow_timing; }
	else { timer += 1; }
	
	// Use the timer vs the transition timing to generate a percentage of
	// the screen to leave revealed.
	section_progress = 0.33 * (timer / transition_out_slow_timing);
	
	percent_displayed = 1 - section_progress;
	draw_r = round(max_radius * percent_displayed);
	
	// When the timer is maxed out, move to the transition pause state.
	if (timer == transition_out_slow_timing)
	{
		timer = 0;
		state = transition_out_normal;
	}
}

///@func transition_out_normal()
transition_out_normal = function()
{
	// If the transition out effect is not requested, max the timer.
	if (!do_transition_out) { timer = transition_out_normal_timing; }
	else { timer += 1; }
	
	// Use the timer vs the transition timing to generate a percentage of
	// the screen to leave revealed.
	section_progress = 0.67 * (timer / transition_out_slow_timing);
	
	percent_displayed = 0.67 - section_progress;
	draw_r = round(max_radius * percent_displayed);
	
	// When the timer is maxed out, move to the transition pause state.
	if (timer == transition_out_normal_timing)
	{
		timer = 0;
		state = transition_pause;
	}
}

///@func transition_pause()
transition_pause = function()
{
	// If the transition pause wasn't requested, max the timer.
	if (!do_transition_pause) { timer = transition_pause_timing; }
	else { timer++; }
	
	// Display start text with the appropriate timing.
	if (timer >= text_display_timing)
	{ show_start_message = true; }
	
	// If the timer is at maximum, move to the target room, and
	// change state to the transition in.
	if (timer == transition_pause_timing)
	{
		timer = 0;
		
		if (target_room != undefined)
		{ room_goto(target_room); }
		
		show_start_message = false;
		
		state = transition_in;
	}
}

///@func transition_in()
transition_in = function()
{
	// If the transition in was not requested, max out the timer.
	if (!do_transition_in) { timer = transition_in_timing; }
	else { timer++; }
	
	// Use the timer vs the transition timing to generate a percentage of
	// the screen to leave revealed.
	percent_displayed = (timer / transition_in_timing);
	draw_r = round(max_radius * percent_displayed);
	
	// If the timer is at maximum, destroy this object.
	if (timer == transition_in_timing)
	{ instance_destroy(); }
}