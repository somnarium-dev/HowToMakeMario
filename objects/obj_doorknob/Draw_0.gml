/// @description Draw Button.
draw_set_font(global.font_default);

var this_sprite = spr_hud_textbox_black;
var this_subimg = 0;

draw_sprite_stretched
(
	this_sprite,
	this_subimg,
	x,
	y,
	this_width,
	this_height
);

var text_x = x + margin;
var text_y = y + margin;

var new_color = #bbbbbb;

if (mouse_is_hovering)
{ new_color = #ffffff; }

draw_set_color(new_color);

draw_text
(
	text_x,
	text_y,
	text_contents
);

//Tidy
draw_set_color(c_white);