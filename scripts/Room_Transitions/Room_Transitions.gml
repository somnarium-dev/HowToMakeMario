/// @function		transitionFadeToNextRoom(_do_fade_out, _do_fade_pause, _do_fade_in)
/// @description	Executes a fade transition from the current room to the room stored in global.next_room.
/// @param {Bool}	_do_fade_out Whether or not to perform the fade out.
/// @param {Bool}	_do_fade_pause Whether or not to pause before fading in.
/// @param {Bool}	_do_fade_in Whether or not to fade in.
function transitionFadeToNextRoom(_do_fade_out = true, _do_fade_pause = true, _do_fade_in = true)
{
	instance_create_layer
	(
		0,
		0,
		"Screen_Effects",
		obj_transition_fade,
		{
			target_room: global.next_room,
			do_transition_out: _do_fade_out,
			do_transition_pause: _do_fade_pause,
			do_transition_in: _do_fade_in
		}
	);
}

/// @function		transitionFadeToRoom(_room, _do_fade_out, _do_fade_pause, _do_fade_in)
/// @description	Executes a fade transition from the current room to _room.
/// @param {Asset.GMRoom}	_room A room asset to transition to.
/// @param {Bool}			_do_fade_out Whether or not to perform the fade out.
/// @param {Bool}			_do_fade_pause Whether or not to pause before fading in.
/// @param {Bool}			_do_fade_in Whether or not to fade in.
function transitionFadeToRoom(_room, _do_fade_out = true, _do_fade_pause = true, _do_fade_in = true)
{
	if (is_undefined(_room))
	{
		show_debug_message("[Warning] transitionFadeToNextRoom() - Target room not defined. Running transitionFadeToNextRoom() instead.");
		transitionFadeToNextRoom();
	}
	
	else
	{
		instance_create_layer
		(
			0,
			0,
			"Screen_Effects",
			obj_transition_fade,
			{
				target_room: _room,
				do_transition_out: _do_fade_out,
				do_transition_pause: _do_fade_pause,
				do_transition_in: _do_fade_in
			}
		);
	}
}

/// @function		transitionIrisToNextRoom(_do_fade_out, _do_fade_pause, _do_fade_in)
/// @description	Executes an iris transition from the current room to the room stored in global.next_room.
/// @param {Bool}	_do_iris_out Whether or not to perform the iris out.
/// @param {Bool}	_do_iris_pause Whether or not to pause before irising in.
/// @param {Bool}	_do_iris_in Whether or not to iris in.
function transitionIrisToNextRoom(_do_iris_out = true, _do_iris_pause = true, _do_iris_in = true)
{
	instance_create_layer
	(
		0,
		0,
		"Screen_Effects",
		obj_transition_iris,
		{
			target_room: global.next_room,
			do_transition_out: _do_iris_out,
			do_transition_pause: _do_iris_pause,
			do_transition_in: _do_iris_in
		}
	);
}

/// @function				transitionIrisToRoom(_room, _do_iris_out, _do_iris_pause, _do_iris_in)
/// @description			Executes an iris transition from the current room to _room.
/// @param {Asset.GMRoom}	_room A room asset to transition to.
/// @param {Bool}			_do_iris_out Whether or not to perform the iris out.
/// @param {Bool}			_do_iris_pause Whether or not to pause before irising in.
/// @param {Bool}			_do_iris_in Whether or not to iris in.
function transitionIrisToRoom(_room, _do_iris_out = true, _do_iris_pause = true, _do_iris_in = true)
{
	if (is_undefined(_room))
	{
		show_debug_message("[Warning] transitionIrisToRoom() - Target room not defined. Running transitionIrisToNextRoom() instead.");
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
				do_transition_out: _do_iris_out,
				do_transition_pause: _do_iris_pause,
				do_transition_in: _do_iris_in
			}
		);
	}
}

/// @function				transitionIrisToLevel(_room, _initialBGM)
/// @description			Executes an iris transition from the current room to _room.
/// @param {Asset.GMRoom}	_room A room asset to transition to.
/// @param {Asset.GMAudio}	_initialBGM The music to play after the transition into the level.
function transitionIrisToLevel(_room, _initialBGM)
{
	if (is_undefined(_room))
	{
		show_debug_message("[Warning] transition_to_level() - Target room not defined. Running transitionToNextRoom() instead.");
		transitionIrisToNextRoom();
	}
	
	else
	{
		instance_create_layer
		(
			0,
			0,
			"Screen_Effects",
			obj_transition_into_level,
			{
				target_room: _room,
				initial_bgm: _initialBGM,
				do_transition_out: true,
				do_transition_pause: true,
				do_transition_in: true
			}
		);
	}
}