if (global.pause_during_transition) { exit; }

draw_sprite_ext
(
	sprite_index,
	image_index,
	x + display_offset_x,
	y + display_offset_y,
	sprite_horizontal_direction,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);