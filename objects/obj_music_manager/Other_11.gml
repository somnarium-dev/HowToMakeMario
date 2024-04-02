///@desc State

///@func awaiting_command()
awaiting_command = function()
{
	if (current_music != -1)
	&& (!audio_is_playing(current_music))
	{
		current_music = -1;
	}
	
	else
	{
		//Regulate volume.
		var new_vol = global.preferences.master_volume * global.preferences.music_volume;
		audio_sound_gain(current_music, new_vol, 0);
	}
}

///@func fading_out()
fading_out = function()
{
	if (max_fade_time == 0)
	{
		show_debug_message("[Warning] fade_out() - Attempted to fade out music over 0 frames.");
		stop_music();
		state = awaiting_command;
	}
	
	fade_time--;
	
	show_debug_message($"Fade Time: {fade_time}");
	
	//current_volume_modifier = (fade_time / max_fade_time);
	
	//var new_vol = global.preferences.master_volume * global.preferences.music_volume * current_volume_modifier;
	
	//audio_sound_gain(current_music, new_vol, 0);
	
	if (fade_time == 0)
	{
		max_fade_time = 0;
		stop_music();
		state = awaiting_command;
	}
}