///@desc Custom Methods

///@func spawnContents()
spawnContents = function()
{
	var new_enemy = instance_create_layer(x + x_offset, y + y_offset, "Enemies", contents, {initial_lr_input: initial_horizontal_sign});
	
	return new_enemy;
}