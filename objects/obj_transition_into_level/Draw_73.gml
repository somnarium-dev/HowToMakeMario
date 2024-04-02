// If the surface evaporated, recreate it.
if (!surface_exists(transition_surface))
{ transition_surface = surface_create(global.focal_width, global.focal_height); }

// Black out the transition surface, then subtract a circle from it.

var this_draw_x = draw_x_out;
var this_draw_y = draw_y_out;

if (state = transition_in)
{
	this_draw_x = draw_x_in;
	this_draw_y = draw_y_in;
}

surface_set_target(transition_surface);
draw_clear(c_black);
gpu_set_blendmode(bm_subtract);
draw_circle(this_draw_x, this_draw_y, draw_r, false)
gpu_set_blendmode(bm_normal);

// Draw the transition surface to the main application surface.
surface_reset_target();

var this_camera_x = camera_get_view_x(global.game_view_camera) + global.view_margin_width;
var this_camera_y = camera_get_view_y(global.game_view_camera);

draw_surface(transition_surface, this_camera_x, this_camera_y);

// Draw the "Character Start" message.
if (show_start_message)
{
	// Display.
	draw_set_font(global.font_stage_start);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	var character_index = global.player_data[global.current_player].character_index;
	var character_name = string_upper(global.character_data[character_index].real_name);

	draw_text(draw_x_in, draw_y_in, character_name + " START!")

	// Tidy.
	draw_set_font(global.font_default);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}