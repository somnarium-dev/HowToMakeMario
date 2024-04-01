/// @function		initializeWorlds()
/// @description	Set up the data for every world in the game.
function initializeWorlds()
{
	//====================================
	// WORLD 1
	//====================================
	global.world_data = []
	
	global.world_data[1] =
	{
		map: World_1,
		music: bgm_grassland,
		levels: [],
		obstacles: []
	}
	
	global.world_data[1].levels[1] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[2] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[3] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[4] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[5] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[6] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[7] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[8] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[9] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[11] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[12] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[13] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[14] =	{ cleared: false,	help_indicator: false,	level_contained: Level_1_1 };
	global.world_data[1].levels[15] =	{ cleared: false,	help_indicator: true,	level_contained: Level_1_1 };
	
	global.world_data[1].obstacles[1] = { cleared: false,	obstacle_type: obstacle_types.lock,	associated_level: 13 };
	global.world_data[1].obstacles[2] = { cleared: false,	obstacle_type: obstacle_types.rock,	associated_level: false };
}