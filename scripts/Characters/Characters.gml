/// @function		initializeCharacters()
/// @description	Set up the data for every playable character in the game.
function initializeCharacters()
{
	global.character_data = [];
	
	//Mario
	global.character_data[0] =
	{
		code_name: "mario",
		real_name: "Mario",	
		sounds:
		{
			jump:	undefined,
			skid:	undefined,
			grow:	undefined,
			shrink: undefined,
			die:	undefined
		}
	}
}
/// @function		loadAllCharacterSprites(_character_code_name)
/// @description	Load all character sprites for all states for a given character code_name.
/// @param {real}	_character_code_name The code_name of the character data being loaded. This should match the name as written in sprite assets.
function loadAllCharacterSprites(_character_code_name)
{
	var return_data = [];
	
	return_data[player_power.small] = variable_clone(loadCharacterSprites(_character_code_name, "small"));
	
	return return_data;
}

/// @function		loadCharacterSprites(_character_code_name, _player_power_name)
/// @description	Used by loadAllCharacterSprites(). Load all character sprites for all states for a given character code_name and player_power.
/// @param {real}	_character_code_name The code_name of the character data being loaded. This should match the name as written in sprite assets.
/// @param {real}	_player_power_name The name of a player power as a string. This should match the name as written in sprite assets.
function loadCharacterSprites(_character_code_name, _player_power_name)
{
	var return_data = [];
	return_data[player_state.mask] = 		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_mask");
	return_data[player_state.climb] = 		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_climb");
	return_data[player_state.crouch] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_crouch");
	return_data[player_state.die] = 		asset_get_index("spr_" + _character_code_name + "_die");
	return_data[player_state.enter_door] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_enter_door");
	return_data[player_state.enter_pipe] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_pipe");
	return_data[player_state.exit_door] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_exit_door");
	return_data[player_state.exit_pipe] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_pipe");
	return_data[player_state.fall] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_fall");
	return_data[player_state.float] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_float");
	return_data[player_state.grab_jump] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_grab_jump");
	return_data[player_state.grab_run] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_grab_run");
	return_data[player_state.grab_stand] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_grab_stand");
	return_data[player_state.grab_walk] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_grab_walk");
	return_data[player_state.jump] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_jump");
	return_data[player_state.kick] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_kick");
	return_data[player_state.run] =			asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_run");
	return_data[player_state.run_jump] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_run_jump");
	return_data[player_state.run_fall] =	asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_run_fall");
	return_data[player_state.skid] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_skid");
	return_data[player_state.slide] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_slide");
	return_data[player_state.stand] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_stand");
	return_data[player_state.swim] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_swim");
	return_data[player_state.walk] =		asset_get_index("spr_" + _character_code_name + "_" +  _player_power_name + "_walk");
	
	return return_data;
}