///@desc Custom Methods

///@func play_music()
play_music = function(_new_song, _looping)
{
	// Stop any music that's currently playing.
	stop_music();
	
	// If the new song requested is empty, bug out.
	if (_new_song == -1)
	{ show_debug_message("[Warning] play_music() - Attempted to play undefined music."); }
	
	// Determine starting gain.
	var new_vol = 1;//global.preferences.master_volume * global.preferences.music_volume;
	
	// Play and store in variable for later reference/control.
	current_music = audio_play_sound(_new_song, 1, _looping, new_vol);
	
	// Debug.
	show_debug_message($"New Music: {_new_song} - ID: {current_music}");
}

///@func stop_music()
stop_music = function()
{
	if (current_music != -1) { audio_stop_sound(current_music); }
}

///@func fade_out(_frames)
fade_out = function(_frames)
{
	if (state != awaiting_command)
	{ show_debug_message("[Warning] MusicManager is busy. Cannot execute fade_out()."); }
	
	var fade_milliseconds = convertFramesToMilliseconds(_frames);
	
	max_fade_time = _frames;
	fade_time = max_fade_time;
	state = fading_out;
}