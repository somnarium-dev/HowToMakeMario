handleExecutionPauses(id);
if (paused) { exit; }

show_debug_message($"Fireball is paused: {paused}");

//Animation speed is based on movement speed.
image_speed = d_speed / 2;

//This is used to flip the sprite to roll "into" its horizontal direction.
var x_adjust = lengthdir_x(d_speed, direction);
var x_sign = sign(x_adjust);

if (x_sign != 0)
{ sprite_direction = x_sign; }

//Finally, this is used to move steadily in the object's direction.
x += x_adjust;
y += lengthdir_y(d_speed, direction);