if (global.pause_during_transition) { exit; }

//if (global.show_debug_data)
//{ draw_sprite(mask_index, 0, x, y); }

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

//Draw the stem.
var stem_offset_amount = 16;
var stem_offset_direction = (direction + 180) mod 360;

var stem_offset_x = lengthdir_x(stem_offset_amount, stem_offset_direction);
var stem_offset_y = lengthdir_y(stem_offset_amount, stem_offset_direction);

draw_sprite_ext
(
	spr_piranhaplant_stem,
	0,
	x + stem_offset_x,
	y + stem_offset_y,
	sprite_direction,
	image_yscale,
	direction,
	image_blend,
	image_alpha
);
