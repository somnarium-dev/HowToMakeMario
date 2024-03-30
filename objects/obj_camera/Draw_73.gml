///@desc Pillarboxing.

// Get the camera's room position.
var this_x = camera_get_view_x(global.game_view_camera);
var this_y = camera_get_view_y(global.game_view_camera);

// Draw the left pillarbox.
draw_sprite_stretched(spr_black, 0, this_x, this_y, global.view_margin_width, global.view_height);

// Draw the right pillarbox.
this_x = this_x + global.view_width - global.view_margin_width;

draw_sprite_stretched(spr_black, 0, this_x, this_y, global.view_margin_width, global.view_height);