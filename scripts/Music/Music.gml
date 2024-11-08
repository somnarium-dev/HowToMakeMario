/// @function		initializeMusic()
/// @description	Used by initialize(). Applies loop points to all of the game's music as necessary.
function initializeMusic()
{
	//Define songs and loop points.
	var _intro_length;
	var _song_length;
	
	//Title Screen
	global.music_title = bgm_title;
	_intro_length = convertSamplesToSeconds(301696);
	_song_length = convertSamplesToSeconds(1465406);
	audio_sound_loop_start(global.music_title, _intro_length);
	audio_sound_loop_end(global.music_title, _song_length);
	
	//Map - Grass Land
	global.music_map_grassland = bgm_grassland;
	
	//Stage - "Overworld"
	global.music_overworld = bgm_overworld;
	_intro_length = convertSamplesToSeconds(156441);
	_song_length = convertSamplesToSeconds(1312597);
	audio_sound_loop_start(global.music_overworld, _intro_length);
	audio_sound_loop_end(global.music_overworld, _song_length);
	
	//Stage - "Overworld - Hurry Up!"
	global.music_overworld_hurry = bgm_overworld_hurry;
	_intro_length = convertSamplesToSeconds(117212);
	_song_length = convertSamplesToSeconds(984331);
	audio_sound_loop_start(global.music_overworld_hurry, _intro_length);
	audio_sound_loop_end(global.music_overworld_hurry, _song_length);
	
	//Player Down
	global.music_playerdown = bgm_playerdown;
	
	//Game Over
	global.music_gameover = bgm_gameover;
	
	//Level Clear
	global.music_levelclear = bgm_levelclear;
}

/// @function		convertSamplesToSeconds(_samples, _sample_rate)
/// @description	Convert a number of samples by a given rate into a number of seconds.
/// @param			_samples x Number to convert in samples.
/// @param {real}   _sample_rate Sample rate to use for conversion.
function convertSamplesToSeconds(_samples, _sample_rate = 44100)
{
	if (is_undefined(_samples))
	{
		show_debug_message("[Warning] convertSamplesToSeconds() - Attempted to convert undefined number of samples.");
		return 0;
	}
	
	return _samples / _sample_rate
}

/// @function		convertSamplesToFrames(_samples, _sample_rate, _frame_rate)
/// @description	Convert samples by rate to seconds, then to frames by rate. Rounded.
/// @param {real}	_samples x Number to convert in samples.
/// @param {real}	_sample_rate Sample rate to use for conversion.
/// @param {real}	_frame_rate Frame rate to use for conversion.
function convertSamplesToFrames(_samples, _sample_rate = 44100, _frame_rate = 60)
{
	if (is_undefined(_samples))
	{
		show_debug_message("[Warning] convertSamplesToFrames() - Attempted to convert undefined number of samples.");
		return 0;
	}
	
	return round((_samples / _sample_rate) * _frame_rate)
}

//===============================================

/// @function				playBGM(_new_song, _looping)
/// @description			Instructs the Music Manager to begin playing a song, and whether or not that song should loop. Defaults to not looping.
/// @param {Asset.GMSound}	_new_song The new song to play. This should be the name of a sound asset.
/// @param {Bool}			_looping Whether or not the new song should loop. Defaults to false.
function playBGM(_new_song, _looping = false)
{ global.music_manager.play_music(_new_song, _looping); }

/// @function		stopBGM()
/// @description	Instructs the Music Manager to stop playing the current song immediately.
function stopBGM()
{ global.music_manager.stop_music(); }

/// @function		fadeoutBGM(_frames = 180)
/// @description	Instructs the Music Manager to fade out the currently playing song over _frames.
/// @param {Real}	_frames The length of the fadeout in frames. Defaults to 180, or roughly three seconds.
function fadeoutBGM(_frames = 180)
{ global.music_manager.fade_out(_frames); }