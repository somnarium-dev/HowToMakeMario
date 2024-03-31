// Inherit the parent event
event_inherited();

// Configuration.
process_collision_detection = false;

// Calculate animation speed.
image_speed = d_speed / 2;

// Convert d_speed to h_speed and v_speed.
h_speed = lengthdir_x(d_speed, direction);
v_speed = lengthdir_y(d_speed, direction);

// Flip the sprite so that it rolls "into" its horizontal direction.
var h_sign = sign(h_speed);

if (h_sign != 0)
{ sprite_horizontal_direction = h_sign; }