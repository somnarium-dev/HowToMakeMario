//=====================================================
// PAUSE FUNCTIONS
//=====================================================

/// @function				handleExecutionPauses(_id)
/// @description			Checks which pauses have been applied to this id and, if any are currently applied, performs pause procedures. If none are found, performs unpause procedures.
/// @param {Id.Instance}	_id The specific instance id that should perform this process.
function handleExecutionPauses(_id)
{
	with (_id)
	{
		//This always needs to match global.
		pauses_inflicted[pause_types.all_execution] = global.pause_all_execution;
	
		//Check what pauses are inflicted on this object.
		var should_be_paused = false;
	
		for (var i = 0; i < array_length(pauses_inflicted); i++)
		{
			if (pauses_inflicted[i])
			{
				should_be_paused = true;
				break;
			}
		}
	
		//If any are active, pause.
		var previously_paused = paused;
		paused = should_be_paused;
		
		//Handle pausing and unpausing.
		
		//Pause
		if (paused)
		&& (!previously_paused)
		{ pauseProcedure(); }
		
		//Unpause
		if (!paused)
		&& (previously_paused)
		{ unpauseProcedure(); }
	}
}

/// @function		pauseProcedure()
/// @description	Stores current image_speed in stored_image_speed, and sets image_speed to zero.
function pauseProcedure()
{
	stored_image_speed = image_speed;
	image_speed = 0;
}

/// @function		unpauseProcedure()
/// @description	Sets image_speed to stored_image_speed value taken when last paused, and clears stored_image_speed.
function unpauseProcedure()
{
	image_speed = stored_image_speed;
	stored_image_speed = 0;
}

/// @function					applyPauseTypeTo(_pause_type, _target)
/// @description				Sets pauses_inflicted[_pause_type] to true for all instances of _target.
/// @param {real}				_pause_type The type of pause being unapplied. This should be an enum.
/// @param {Asset.GMObject}		_target The object_index to which this function will apply.
function applyPauseTypeTo(_pause_type, _target)
{
	if (instance_number(_target) < 1) { return; }
	_target.pauses_inflicted[_pause_type] = true;
}

/// @function					unapplyPauseTypeTo(_pause_type, _target)
/// @description				Sets pauses_inflicted[_pause_type] to false for all instances of _target.
/// @param {real}				_pause_type The type of pause being unapplied. This should be an enum.
/// @param {Asset.GMObject}		_target The object_index to which this function will apply.
function unapplyPauseTypeTo(_pause_type, _target)
{ 
	if (instance_number(_target) < 1) { return; }
	_target.pauses_inflicted[_pause_type] = false;	
}

//=================================================================================================
// INPUT
//=================================================================================================

/// @function		clearAIFrameInputs()
/// @description	Sets all "pressed", "held", and "released" ai_input values to false.
function clearAIFrameInputs()
{
	ai_input_run_pressed = false;
	ai_input_run_held = false;
	ai_input_run_released = false;

	ai_input_jump_pressed = false;
	ai_input_jump_held = false;
	ai_input_jump_released = false;
}

//=====================================================
// DISPLAY FUNCTIONS
//=====================================================

/// @function		setSpriteDirectionPerLRInput(_input_horizontal)
/// @description	Updates sprite_direction to the sign of _input_horizontal.
/// @param {real}	_input_horizontal The value from which the sign is derived.
function setSpriteDirectionPerLRInput(_input_horizontal)
{
	if (_input_horizontal != 0)
	{ sprite_horizontal_direction = sign(_input_horizontal); }
}

/// @function		setImageSpeedPerHSpeed(_reference_point)
/// @description	Updates the image_speed to the value of h_speed / reference_point.
/// @param {real}	_reference_point The divisor of h_speed in this calculation.
function setImageSpeedPerHSpeed(_reference_point)
{ image_speed = (h_speed / _reference_point); }

//=================================================================================================
// STATE AND BEHAVIOR CONTROL
//=================================================================================================

/// @function		updateObjectState(_new_state)
/// @description	Updates the current state of an object and resets its state_timer. Note: obj_parent_player has its own version of this to use instead: updatePlayerState().
/// @param {real}	_new_state The new state value. Should be an enum.
function updateObjectState(_new_state)
{
	state = _new_state;
	
	state_timer = 0;
}

/// @function		updateObjectBehavior(_new_behavior)
/// @description	Updates the current behavior of an object and resets its behavior_timer.
/// @param {real}	_new_behavior The new behavior value. Should be an enum.
function updateObjectBehavior(_new_behavior)
{
	behavior = _new_behavior;
	
	behavior_timer = 0;
}

//=====================================================
// COLLECTIBLE FUNCTIONS
//=====================================================

/// @function		collectCoin
/// @description	Increase the number of coins recorded in _collector's statblock by _amount. If the statblock indicates more than global.max_coins have been collected, grants a 1up.
/// @param			_collector The instance that collected the coin(s).
/// @param			_amount The number of coins collected.
function collectCoin(_collector, _amount)
{
	_collector.stat_block.coins += _amount;
	
	if (_collector.stat_block.coins >= global.max_coins)
	{
		_collector.stat_block.coins -= global.max_coins;
		
		playSFX(sfx_1up);
		
		collect1UP(_collector, 1);
	}
}

/// @function		collect1UP
/// @description	Increase the number of lives recorded in _collector's statblock by _amount. Will not exceed global.max_lives.
/// @param			_collector The instance that collected the 1up(s).
/// @param			_amount The number of 1ups collected.
function collect1UP(_collector, _amount)
{	
	_collector.stat_block.lives += _amount;
	
	if (_collector.stat_block.lives > global.max_lives)
	{ _collector.stat_block.lives_remaining = global.max_lives; }
}