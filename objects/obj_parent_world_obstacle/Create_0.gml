// Load obstacle data.
cleared =			global.world_data[global.world].obstacles[obstacle_number].cleared;
associated_level =	global.world_data[global.world].obstacles[obstacle_number].associated_level;
obstacle_type =		global.world_data[global.world].obstacles[obstacle_number].obstacle_type;

// If the obstacle has already been cleared, destroy this object.
if (cleared != false)
{ instance_destroy(); }