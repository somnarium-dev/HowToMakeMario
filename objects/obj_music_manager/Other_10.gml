///@desc Custom Methods

///@func play_music()
play_music = function(_new_song, _looping)
{
	stop_music()
	
	if (_new_song == -1)
	{ show_debug_message("[Warning] play_music() - Attempted to play undefined music."); }
	
	current_music = audio_play_sound(_new_song, 1, _looping);
	
	//Regulate volume.
	var new_vol = global.preferences.master_volume * global.preferences.music_volume;
	audio_sound_gain(current_music, new_vol, 0);
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
	
	audio_sound_gain(current_music, 0, fade_milliseconds);
	
	max_fade_time = _frames;
	fade_time = max_fade_time;
	state = fading_out;
}