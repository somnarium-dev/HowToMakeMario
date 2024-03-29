///@desc Pillarboxing.
var this_x = camera_get_view_x(view_camera[0]);
var this_y = camera_get_view_y(view_camera[0]);

draw_sprite_stretched(spr_black, 0, this_x, this_y, global.view_margin_width, global.view_height);

this_x = this_x + global.view_width - global.view_margin_width;

draw_sprite_stretched(spr_black, 0, this_x, this_y, global.view_margin_width, global.view_height);