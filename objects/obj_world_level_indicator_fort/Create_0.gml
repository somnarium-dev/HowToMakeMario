///@desc 

// Inherit the parent event
event_inherited();

// Do not animate this indicator.
image_speed = 0;
image_index = 0;

// If the level has been cleared, incrementt image index.
if (cleared != false)
{ image_index = 1; }