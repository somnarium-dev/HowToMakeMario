///@desc State Machine

state_machine = []

state_machine[player_map_state.load_in] = function()
{
	state_timer++;
	
	if (state_timer == load_in_timing)
	{
		playBGM(global.world_data[1].music, true);
		sprite_index = map_sprite;
		updateMapState(player_map_state.select_level);
	}
}

state_machine[player_map_state.select_level] = function()
{
	if (bump_sound_timer > 0)
	{ bump_sound_timer--; }
	
	checkIfEnteringLevel();
	checkIfTryingToMove();
}

state_machine[player_map_state.in_motion] = function()
{
	checkIfDoneMoving();
}

state_machine[player_map_state.enter_level] = function()
{
	// Empty.
}

//=======================================================================================
// STATE TRANSITIONS
//=======================================================================================

///@func checkIfTryingToMove()
checkIfTryingToMove = function()
{
	var move_confirmed = tryToMove();
	
	if (move_confirmed)
	{ 
		bump_sound_timer = 0;
		updateMapState(player_map_state.in_motion);
	}
}

///@func checkIfDoneMoving()
checkIfDoneMoving = function()
{
	var move_completed = processMapMovement();
	
	if (move_completed)
	{ 
		updatePlayerMapCoordinates();
		updateMapState(player_map_state.select_level);
	}
}

///@func checkIfEnteringLevel()
checkIfEnteringLevel = function()
{
	getSelectedLevel();
	
	if (input_jump_pressed)
	&& (target_level != undefined)
	{
		updateMapState(player_map_state.enter_level);
		global.post_death_room = room;
		transitionIrisToLevel(target_level);
	}
}