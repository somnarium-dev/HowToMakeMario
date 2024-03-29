//Update data.
x = camera_get_view_x(view_camera[0]) + global.view_margin_width;
y = camera_get_view_y(view_camera[0]) + global.view_height - sprite_height;

coins_string = string_repeat("0", coins_num_places - string_length(global.player_1.coins)) + string(global.player_1.coins);
lives_string = string_repeat("0", lives_num_places - string_length(global.player_1.lives_remaining)) + string(global.player_1.lives_remaining);
point_total_string = string_repeat("0", point_total_num_places - string_length(global.player_1.point_total)) + string(global.player_1.point_total);
level_timer_string = string_repeat("0", timer_num_places - string_length(global.level_timer)) + string(global.level_timer);

//Blackout.
draw_sprite_stretched(spr_black, 0, x, y, sprite_width, sprite_height);

//Hud frame
draw_self();

//Hud character emblem.
draw_sprite
(
	spr_hud_characteremblem,
	global.player_1.character_index,
	x + offsets.emblem._x,
	y + offsets.emblem._y
);

//Hud P level.
for (var i = 0; i < (global.plevel_max - 1); i++;)
{
	//The p level starts at 1.
	//Image indexes start at 0.
	//This is why we check if i is *less* than the p level.
	
	//Furthermore, the *symbol* indicates maximum. So we stop 1 before.
	
	var filled = i < global.player_1.plevel;
	
	draw_sprite
	(
		spr_hud_plevel,
		filled,
		x + offsets.plevel._x + (i * plevel_pip_spacing),
		y + offsets.plevel._y
	);
}

//Hud P symbol.
var do_flash = (global.player_1.plevel >= global.plevel_max) && indicator_flash;

draw_sprite
(
	spr_hud_pindicator,
	do_flash,
	x + offsets.pindicator._x,
	y + offsets.pindicator._y
);

//Set font.
draw_set_font(global.font_hudnumbers);

//World
draw_text
(
	x + offsets.world._x,
	y + offsets.world._y,
	global.world
);

//Coin count.
draw_text
(
	x + offsets.coins._x,
	y + offsets.coins._y,
	coins_string
);

//Lives.
draw_text
(
	x + offsets.lives_remaining._x,
	y + offsets.lives_remaining._y,
	lives_string
);

//Points.
draw_text
(
	x + offsets.point_total._x,
	y + offsets.point_total._y,
	point_total_string
);

//Timer.
draw_text
(
	x + offsets.level_timer._x,
	y + offsets.level_timer._y,
	level_timer_string
);

//Cards.
for (var i = 0; i < number_end_of_level_cards; i++)
{
	draw_sprite
	(
		spr_endoflevelcard,
		global.player_1.cards[i],
		x + offsets.end_of_level_cards._x + (i * end_of_level_card_spacing),
		y + offsets.end_of_level_cards._y
	);
}

//Tidy.
draw_set_font(global.font_default);