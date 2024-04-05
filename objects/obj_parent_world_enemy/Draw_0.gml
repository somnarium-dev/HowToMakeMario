// Draw.
var modifier = 0;

if (sprite_horizontal_direction == -1)
{ modifier = 16; }

draw_sprite_ext
(
	sprite_index,
	image_index,
	x + h_display_offset + modifier,
	y + v_display_offset,
	sprite_horizontal_direction,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);