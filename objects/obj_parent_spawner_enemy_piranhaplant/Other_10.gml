///@desc Custom Functions

// Inherit the parent event
event_inherited();

spawnContents = function()
{
	//Calculate rotation (direction) of the spawn based on the spawner's image_angle.
	var offset_direction_x = image_angle;
	var offset_direction_y = image_angle - 90;

	var offset_x = lengthdir_x(x_offset, offset_direction_x) + lengthdir_x(y_offset, offset_direction_y);
	var offset_y = lengthdir_y(x_offset, offset_direction_x) + lengthdir_y(y_offset, offset_direction_y);
	
	//Set the max extension amount and coordinates of the spawn based on the spawner's image_angle.
	var max_extension_from_base = 32;

	var this_max_extension = max_extension_from_base;
	var this_max_extension_x = lengthdir_x(max_extension_from_base, offset_direction_x);
	var this_max_extension_y = lengthdir_y(max_extension_from_base, offset_direction_x);
	
	//Create the spawn.
	new_enemy = instance_create_layer
						(
							x + offset_x,
							y + offset_y,
							"Enemies",
							contents,
							{
								//Set the enemy's direction (rotation).
								
								//We use direction instead of image angle within the spawn
								//because the head can rotate independently.
								
								//We *must* use image_angle within the spawner because
								//that is the connecting thread to the level editor.
								create_direction: image_angle,
								max_extension: this_max_extension,
								max_extension_x: this_max_extension_x,
								max_extension_y: this_max_extension_y,
								pipe_length_tiles: pipe_length_tiles,
								depth: 250
							}
						);
	
	return new_enemy;
}