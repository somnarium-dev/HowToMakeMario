///@Desc State

///@func transition_out()
transition_out = function()
{
	if (!do_transition_out) { timer = transition_out_timing; }
	else { timer++; }
	
	percent_displayed = 1 - (timer / transition_in_timing);
	draw_r = round(max_radius * percent_displayed);
	
	if (timer == transition_out_timing)
	{
		timer = 0;
		state = transition_pause;
	}
}

///@func transition_pause()
transition_pause = function()
{
	if (!do_transition_pause) { timer = transition_pause_timing; }
	else { timer++; }
	
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
	if (!do_transition_in) { timer = transition_in_timing; }
	else { timer++; }
	
	percent_displayed = (timer / transition_in_timing);
	draw_r = round(max_radius * percent_displayed);
	
	if (timer == transition_in_timing)
	{ instance_destroy(); }
}