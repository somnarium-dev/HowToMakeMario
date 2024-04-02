// Update data.
x = camera_get_view_x(global.game_view_camera) + global.view_margin_width;
y = camera_get_view_y(global.game_view_camera) + global.view_height - sprite_height;

coins_string = string_repeat("0", coins_num_places - string_length(source.stat_block.coins)) + string(source.stat_block.coins);
lives_string = string_repeat("0", lives_num_places - string_length(source.stat_block.lives_remaining)) + string(source.stat_block.lives_remaining);
point_total_string = string_repeat("0", point_total_num_places - string_length(source.stat_block.point_total)) + string(source.stat_block.point_total);

// Blackout.
draw_sprite_stretched(spr_black, 0, x, y, sprite_width, sprite_height);

// Frame.
draw_self();

// Character emblem.
draw_sprite
(
	spr_hud_characteremblem,
	source.stat_block.character_index,
	x + offsets.emblem._x,
	y + offsets.emblem._y
);

// P level arrows.
for (var i = 0; i < (global.plevel_max - 1); i++;)
{
	// The P level display starts at 1, but image_indexes start at 0.
	// This is why we check if "i" is *less* than the p level.
	// Furthermore, the *symbol* indicates maximum. So we stop 1 before.
	
	var filled = i < source.stat_block.plevel;
	
	draw_sprite
	(
		spr_hud_plevel,
		filled,
		x + offsets.plevel._x + (i * plevel_pip_spacing),
		y + offsets.plevel._y
	);
}

// P symbol.
var do_flash = (source.stat_block.plevel >= global.plevel_max) && indicator_flash;

draw_sprite
(
	spr_hud_pindicator,
	do_flash,
	x + offsets.pindicator._x,
	y + offsets.pindicator._y
);

// Set font.
draw_set_font(global.font_hud_numbers);

// World number.
draw_text
(
	x + offsets.world._x,
	y + offsets.world._y,
	global.world
);

// Coin count.
draw_text
(
	x + offsets.coins._x,
	y + offsets.coins._y,
	coins_string
);

// Lives.
draw_text
(
	x + offsets.lives_remaining._x,
	y + offsets.lives_remaining._y,
	lives_string
);

// Points.
draw_text
(
	x + offsets.point_total._x,
	y + offsets.point_total._y,
	point_total_string
);

// Timer.
draw_text
(
	x + offsets.level_timer._x,
	y + offsets.level_timer._y,
	level_timer_string
);

// Cards.
for (var i = 0; i < number_end_of_level_cards; i++)
{
	draw_sprite
	(
		spr_endoflevelcard,
		source.stat_block.cards[i],
		x + offsets.end_of_level_cards._x + (i * end_of_level_card_spacing),
		y + offsets.end_of_level_cards._y
	);
}

// Tidy.
draw_set_font(global.font_default);