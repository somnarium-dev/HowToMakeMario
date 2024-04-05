///@desc Update camera position.
camera_set_view_size(global.game_view_camera, global.view_width, global.view_height);

if (global.camera_target_0 == noone) { return; }

var camera_target = global.player_data[global.current_player].current_id;

if (instance_exists(camera_target))
{
	// Collect preliminary information.
	var _x = camera_get_view_x(global.game_view_camera);
	var _y = camera_get_view_y(global.game_view_camera);

	var _previous_x = _x;
	var _previous_y = _y;

	// Propose the camera's next position, following its target.
	var _x_target = camera_target.x - (global.view_width / 2);
	var _y_target = camera_target.y - (global.view_height / 2);
	
	// Adjust the proposed position to keep it within travel boundaries.
	_x = clamp(_x_target, global.view_travel_boundary_left, global.view_travel_boundary_right);
	_y = clamp(_y_target, global.view_travel_boundary_up, global.view_travel_boundary_down);
	
	// Update Camera Position
	if (global.view_track_on_x)
	{
		var unadjusted_y = camera_get_view_y(global.game_view_camera);
		camera_set_view_pos(global.game_view_camera, _x, unadjusted_y);
	}
	
	if (global.view_track_on_y)
	{ 
		var unadjusted_x = camera_get_view_x(global.game_view_camera);
		camera_set_view_pos(global.game_view_camera, unadjusted_x, _y);
	}
	
	// Slide Background with camera.
	var background_slide_x = _x - _previous_x;
	var background_slide_y = _y - _previous_y;
	
	var this_layer = layer_get_id("Background");
	
	layer_x("Background", layer_get_x(this_layer) + background_slide_x);
	layer_y("Background", layer_get_y(this_layer) + background_slide_y);
}