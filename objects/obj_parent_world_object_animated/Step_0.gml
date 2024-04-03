// Inherit the parent event
event_inherited();

// Handle animation locking.
if (animation_lock)
{
	original_animation_speed = image_speed;
	image_speed = 0;
}

else
{ image_speed = original_animation_speed; }