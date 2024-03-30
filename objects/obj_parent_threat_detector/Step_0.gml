// If this detector's associated sourced object does not exist, then it has no purpose.
// Destroy it in this circumstance.
if (source == noone)
|| (!instance_exists(source))
{
	instance_destroy(); 
	exit;
}

// If the object is meant to follow its source, then do so.
if (follow_source)
{
	x = source.x;
	y = source.y;
}

// If there is a defined threat this object is meant to detect, then check for a
// collision with any instance of that object.
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