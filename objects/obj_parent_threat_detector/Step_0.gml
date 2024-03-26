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
{
	threat_detected =	collision_rectangle
						(
						x + range_x1,
						y + range_y1,
						x + range_x2,
						y + range_y2,
						threat,
						range_precise,
						true
						);
}