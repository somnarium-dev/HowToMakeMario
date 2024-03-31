///@desc Unique Methods

///@func setGameResolutionAndCenter(_display_width, display_height)
setGameResolutionAndCenter = function(_display_width, _display_height)
{
	// Calculate aspect ratio.
	global.aspect_ratio = _display_width / _display_height;

	// Default the camera's tracking to on.
	global.view_track_on_x = true;
	global.view_track_on_y = true;

	// Determine the size of the game view.
	global.focal_width = global.single_room_width;
	global.focal_height = global.single_room_height;

	// Determine the size of the application view.
	global.view_height = global.focal_height;
	global.view_width = round(global.view_height * global.aspect_ratio);

	// This bitwise check ensures that if the view's dimensions are odd, they become even.
	if(global.view_width & 1) global.view_width++;
	if(global.view_height & 1) global.view_height++;

	// Determine window integer scale.
	var max_window_scale = min(
							floor(_display_width/global.view_width),
							floor(_display_height/global.view_height)
							);

	if(global.view_height * max_window_scale == display_get_height()) { max_window_scale--; }
	
	global.window_scale = max_window_scale;

	// Set the window size.
	window_set_size(
		global.view_width * global.window_scale,
		global.view_height * global.window_scale);

	// Resize the surface.
	surface_resize(
		application_surface,
		global.view_width * global.window_scale,
		global.view_height * global.window_scale
		);

	// Determine the view margins.
	global.view_margin_width = (global.view_width - global.focal_width) / 2;
	global.view_margin_height = 0;//32;

	// This is used to center the window on screen.
	global.game_camera.alarm[0] = 1;
}