// If the surface evaporated, recreate it.
if (!surface_exists(transition_surface))
{ transition_surface = surface_create(global.focal_width, global.focal_height); }

// Black out the transition surface, then subtract a circle from it.
surface_set_target(transition_surface);
draw_clear(c_black);
gpu_set_blendmode(bm_subtract);
draw_circle(draw_x, draw_y, draw_r, false)
gpu_set_blendmode(bm_normal);

// Draw the transition surface to the main application surface.
surface_reset_target();

var this_x = camera_get_view_x(global.game_view_camera) + global.view_margin_width;
var this_y = camera_get_view_y(global.game_view_camera);

draw_surface(transition_surface, this_x, this_y);