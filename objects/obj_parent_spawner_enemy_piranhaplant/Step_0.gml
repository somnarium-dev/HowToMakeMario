if (global.pause_during_transition) { exit; }
if (contents == undefined) { exit; }
if (most_recent_spawn != noone) { exit; }

// Calculate rotation (direction) of the spawn based on the spawner's image_angle.
var offset_direction_x = image_angle;
var offset_direction_y = image_angle - 90;

var offset_x = lengthdir_x(x_offset, offset_direction_x) + lengthdir_x(y_offset, offset_direction_y);
var offset_y = lengthdir_y(x_offset, offset_direction_x) + lengthdir_y(y_offset, offset_direction_y);
	
// Create the spawn.
most_recent_spawn = instance_create_layer
					(
						x + offset_x,
						y + offset_y,
						"Enemies",
						contents,
						{
							// Set the enemy's direction (rotation).
								
							// We use direction instead of image angle within the spawn
							// because the head can rotate independently.
								
							// We *must* use image_angle within the spawner because
							// that is the connecting thread to the level editor.
							create_direction: image_angle,
							max_extension: max_extension_pixels,
							pipe_length_in_tiles: pipe_length_in_tiles,
							depth: 250,
							initial_lr_input: initial_horizontal_sign
						}
					);
		
// If this spawner does not respawn, destroy it.
if (!respawn_contents)
{ instance_destroy(); }