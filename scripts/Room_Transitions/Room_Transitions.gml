function transitionIrisToNextRoom(_do_fade_out = true, _do_fade_pause = true, _do_fade_in = true)
{
	instance_create_layer
	(
		0,
		0,
		"Screen_Effects",
		obj_transition_iris,
		{
			target_room: global.next_room,
			do_transition_out: _do_fade_out,
			do_transition_pause: _do_fade_pause,
			do_transition_in: _do_fade_in
		}
	);
}

function transitionIrisToRoom(_room, _do_fade_out = true, _do_fade_pause = true, _do_fade_in = true)
{
	if (is_undefined(_room))
	{
		show_debug_message("[Warning] transition_to_room() - Target room not defined. Running transitionToNextRoom() instead.");
		transitionIrisToNextRoom();
	}
	
	else
	{
		instance_create_layer
		(
			0,
			0,
			"Screen_Effects",
			obj_transition_iris,
			{
				target_room: _room,
				do_transition_out: _do_fade_out,
				do_transition_pause: _do_fade_pause,
				do_transition_in: _do_fade_in
			}
		);
	}
}