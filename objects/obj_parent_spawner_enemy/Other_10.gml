///@desc Custom Methods

///@func spawnContents()
spawnContents = function()
{
	var new_enemy = instance_create_layer(x + x_offset, y + y_offset, "Enemies", contents);
	
	return new_enemy;
}