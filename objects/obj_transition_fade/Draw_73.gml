// Black out the screen at the current opacity.
var this_x = camera_get_view_x(global.game_view_camera) + global.view_margin_width;
var this_y = camera_get_view_y(global.game_view_camera);
var this_w = global.focal_width;
var this_h = global.focal_height;

draw_set_alpha(image_alpha);
draw_sprite_stretched(spr_black, 0, this_x, this_y, this_w, this_h);

// Tidy.
draw_set_alpha(1);