/// @description Define properties.
margin = 4;

text_contents = "CONTINUE";

draw_set_font(global.font_default);

this_width = string_width(text_contents) + (margin * 2);
this_height = string_height(text_contents) + (margin * 2);

x -= (this_width / 2) + margin;
y -= (this_height / 2) + margin;

mouse_is_hovering = false;