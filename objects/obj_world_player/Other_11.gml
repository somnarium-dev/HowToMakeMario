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

state_machine[player_map_state.post_level_death] = function()
{
	state_timer++;
	
	if (state_timer == post_level_timing)
	{
		playSFX(sfx_levelkickback);
		sprite_index = map_sprite;
		updateMapState(player_map_state.kickback);
	}
}

state_machine[player_map_state.kickback] = function()
{
	var arrived_at_last_clear = handleKickback()
	
	if (arrived_at_last_clear)
	{
		sprite_index = pin_sprite;
		
		var number_of_enemies = instance_number(obj_parent_world_enemy);
		var number_of_shuffle_steps = irandom_range(2, 3);
		
		for (var i = 0; i < number_of_enemies; i++;)
		{
		    array_of_reshuffling_enemies[i] = instance_find(obj_parent_world_enemy, i);
			array_of_reshuffling_enemies[i].shuffle_moves_remaining = number_of_shuffle_steps;
			array_of_reshuffling_enemies[i].state = enemy_map_state.shuffle;
		}
		
		updateMapState(player_map_state.reshuffle);
	}
}

state_machine[player_map_state.reshuffle] = function()
{
	var done_with_reshuffle = true;
	
	var number_of_enemies = array_length(array_of_reshuffling_enemies);
	
	show_debug_message($"Checking {number_of_enemies}.");
	
	for (var i = 0; i < number_of_enemies; i++;)
	{
		if (array_of_reshuffling_enemies[i].state != enemy_map_state.idle)
		{ 
			show_debug_message($"{array_of_reshuffling_enemies[i]} isn't done!");
			done_with_reshuffle = false; 
			break;
		}
	}
	
	if (done_with_reshuffle)
	{
		show_debug_message("Finito.");
		playBGM(global.world_data[1].music, true);
		sprite_index = map_sprite;
		updateMapState(player_map_state.select_level);
	}
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
		transitionIrisToLevel(target_level, target_level_bgm);
	}
}