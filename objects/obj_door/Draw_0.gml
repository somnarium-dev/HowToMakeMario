/// @description Draw the door.

//Set the properties of the window.
var margin = 16;

var this_x = margin;
var this_y = margin;

var width = room_width - (margin * 2);
var height = room_height - (margin * 2);

//var window_sprite = spr_hud_textbox_blue;
var window_sprite = spr_hud_textbox_blue;

var this_subimage = 0;

//Display the window.
draw_sprite_stretched(window_sprite, this_subimage, this_x, this_y, width, height);

//Set the properties of the text.
var text_contents = "Let's make Mario!";

var text_x = this_x + margin;
var text_y = this_y + margin;

//Display the text.
draw_text(text_x, text_y, text_contents);