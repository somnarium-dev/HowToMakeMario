if (global.pause_during_transition) { exit; }

draw_sprite_ext
(
	sprite_index,
	image_index,
	x,
	y,
	sprite_direction,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);