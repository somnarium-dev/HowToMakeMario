/// @function		audioPlaySoundNoOverlap
/// @description	Stop a sound if it is already playing, then start playing that sound. If an array of sounds is sent, it will silence all of the contents of that array, then play a random entry from it.
/// @param			_soundid The ID of the sound to stop, then play.
/// @param			_priority The priority of the sound upon being replayed.
/// @param			_loops Whether the sound should loop upon being replayed.
function audioPlaySoundNoOverlap(_soundid, _priority = 1, _loops = false)
{
	var this_sound;
	
	if (is_undefined(_soundid))
	{
		show_debug_message("[Warning] audioPlaySoundNoOverlap() - Attempted to play undefined sound.");
		return;
	}
	
	if (is_array(_soundid))
	{
		if (array_length(_soundid) < 1)
		{
			show_debug_message("[Warning] audioPlaySoundNoOverlap() - Attempted to play empty array of sounds.");
			return;
		}
		
		audioStopAllOfThese(_soundid);
		var final_sound = choose_random_entry(_soundid);
		this_sound = audio_play_sound(final_sound, _priority, _loops);
	}
	
	else
	{
		audio_stop_sound(_soundid);
		this_sound = audio_play_sound(_soundid, _priority, _loops);
	}
	
	var new_vol = global.preferences.master_volume * global.preferences.sfx_volume;
	audio_sound_gain(this_sound, new_vol, 0)
}

function audioStopAllOfThese(_array)
{
	for (var i = 0; i < array_length(_array); i++;)
	{ audio_stop_sound(_array[i]); }
}

function choose_random_entry(_array)
{
	var index = irandom_range(1, array_length(_array)) - 1;
	return _array[index];
}

function playSFX(_soundid, _loops = false, _priority = 1)
{
	audioPlaySoundNoOverlap(_soundid, _priority, _loops);
}

/// @function		alignedWithGrid(_x, _y)
/// @description	Determine if a position is aligned with a grid of standard tiles.
/// @param			_x x position to check.
/// @param			_y y position to check.
/// @return {Bool}
function alignedWithGrid(_x = undefined, _y = undefined)
{
	if (_x == undefined) { _x = x; }
	if (_y == undefined) { _y = y; }
	
	return (_x mod global.tile_size == 0) && (_y mod global.tile_size == 0);
}

/// @function		pacmanClamp(_value, _lower_boundary, _upper_boundary)
/// @description	Takes a value and, if it exceeds either boundary, sets it to the other.
/// @param			_value Value to adjust.
/// @param			_lower_boundary Lower boundary to clamp to.
/// @param			_upper_boundary Upper boundary to clamp to.
/// @return {Int}
function pacmanClamp(_value, _lower_boundary, _upper_boundary)
{
	var clamped_value = _value;
	
	if (clamped_value < _lower_boundary) { clamped_value = _upper_boundary; }
	else if (clamped_value > _upper_boundary) {clamped_value = _lower_boundary; }
	
	return clamped_value;
}

/// @function		room_x_to_gui_x(_x)
/// @description	Takes x relevant to the current room and converts it to x relative to the GUI.
/// @param			_x Value to convert.
/// @return {real}
function room_x_to_gui_x(_x) {
    _x -= camera_get_view_x(view);
    _x /= camera_get_view_width(view);

    return _x * display_get_gui_width();
}

/// @function		room_y_to_gui_y(_y)
/// @description	Takes y relevant to the current room and converts it to y relative to the GUI.
/// @param			_y Value to convert.
/// @return {real}
function room_y_to_gui_y(_y) {
    _y -= camera_get_view_y(view);
    _y /= camera_get_view_height(view);

    return _y * display_get_gui_height();
}