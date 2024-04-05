///@desc Custom Methods

///@func handleLevelTimer()
handleLevelTimer = function()
{	
	// Level timer.
	if (global.level_timer == 0)
	{ return; }
	
	level_timer_timer++;
	
	if (level_timer_timer == global.level_timer_timing)
	{
		level_timer_timer = 0;
		global.level_timer--;
		
		// Hurry up at 100 seconds remaining.
		if (global.level_timer == 100)
		{ 
			playSFX(sfx_hurryup);
			playBGM(global.level_music.hurry, true);
		}
		
		// Death at no time remaining.
		if (global.level_timer == 0)
		{ source.marked_for_death = true; }
	}
}