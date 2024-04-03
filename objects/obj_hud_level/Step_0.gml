// Handle pausing.
handleExecutionPauses(id);
if (paused) { exit; }
if (global.pause_during_transition) { exit; }

show_debug_message($"PAUSED? : {paused}");

// Animation.
timer++;

if (timer == indicator_flash_timing)
{
	timer = 0;
	indicator_flash = !indicator_flash;
}

handleLevelTimer();