if (global.pause_during_transition) { exit; }

draw_sprite_ext
(
	sprite_index,
	image_index,
	x + display_offset_x,
	y + display_offset_y,
	sprite_direction,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

var strikes = array_length(strike_array);

if (strikes > 0)
{
	for (var i = 0; i < strikes; i++)
	{
		draw_set_color(c_black);
		draw_text(x + 16 + 1, y - (8 * i) + 1, $"ID: {strike_array[i].hit_by}");
		draw_set_color(c_white);
		draw_text(x + 16, y - (8 * i), $"ID: {strike_array[i].hit_by}");
		
	}
}