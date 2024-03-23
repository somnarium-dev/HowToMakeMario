/// @description Enable view.
view_enabled = true;
view_visible[0] = true;

//Determine the camera's margins.
var dynamic_margin_h = floor((global.view_width - room_width) / 2);
var dynamic_margin_v = floor((global.view_height - room_height) / 2);

global.view_current_left_margin = max(dynamic_margin_h, global.view_margin_width);
global.view_current_top_margin = max(dynamic_margin_v, global.view_margin_height);

//Determine the distance the camera is allowed to scroll.
var cam_travel_span_h = max(room_width - global.focal_width, 0);
var cam_travel_span_v = max(room_height - global.focal_height + 32, 0);

//Set camera travel boundaries.
global.view_travel_boundary_left = -global.view_current_left_margin;
global.view_travel_boundary_up = -global.view_current_top_margin;
global.view_travel_boundary_right = global.view_travel_boundary_left + cam_travel_span_h;
global.view_travel_boundary_down = global.view_travel_boundary_up + cam_travel_span_v;

//Reset the camera's position
camera_set_view_pos(view, global.view_travel_boundary_left, global.view_travel_boundary_up);