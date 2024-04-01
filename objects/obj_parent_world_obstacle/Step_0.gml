// If the level associated with this obstacle is cleared, then clear the obstacle.
if (associated_level != false)
{
	var associated_level_is_cleared = global.world_data[global.world].levels[associated_level].cleared;

	if (associated_level_is_cleared != false)
	{
		cleared = true;
		global.world_data[global.world].obstacles[obstacle_number].cleared = true;
		
		// Trigger the clear animation here.
		// Then destroy the object.
		instance_destroy();
	}
}