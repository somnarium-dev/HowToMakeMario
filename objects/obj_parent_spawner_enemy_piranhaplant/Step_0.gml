if (global.pause_during_transition) { exit; }
if (contents == undefined) { exit; }

var offset_direction_x = image_angle;
var offset_direction_y = image_angle - 90;

var offset_x = lengthdir_x(x_offset, offset_direction_x) + lengthdir_x(y_offset, offset_direction_y);
var offset_y = lengthdir_y(x_offset, offset_direction_x) + lengthdir_y(y_offset, offset_direction_y);

if (most_recent_spawn != noone) {exit;}

most_recent_spawn = instance_create_layer
					(
						x + offset_x,
						y + offset_y,
						"Enemies",
						contents
					);

most_recent_spawn.direction = image_angle;

show_debug_message($"image_angle : {image_angle}");
show_debug_message($"Direction : {most_recent_spawn.direction}");

if (most_recent_spawn != noone)
{ most_recent_spawn.depth = 250; }