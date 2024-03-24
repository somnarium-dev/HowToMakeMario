if (source == noone)
|| (!instance_exists(source))
{
	instance_destroy(); 
	exit;
}

if (follow_source)
{
	x = source.x;
	y = source.y;
}

if (threat != noone)
{ threat_detected = instance_place(x, y, threat); }