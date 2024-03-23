if (global.pause_during_transition) { exit; }

if (global.show_debug_data)
{ draw_sprite(mask_index, 0, x, y); }

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

//debugDrawState();