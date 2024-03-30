// Animation.
timer++;

if (timer == indicator_flash_timing)
{
	timer = 0;
	indicator_flash = !indicator_flash;
}