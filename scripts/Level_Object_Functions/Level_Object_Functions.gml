//=====================================================
// PAUSE FUNCTIONS
//=====================================================
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

function pauseProcedure()
{
	stored_image_speed = image_speed;
	image_speed = 0;
}

function unpauseProcedure()
{
	image_speed = stored_image_speed;
	stored_image_speed = 0;
}

function applyPauseTypeTo(_pause_type, _target)
{
	if (instance_number(_target) < 1) { return; }
	_target.pauses_inflicted[_pause_type] = true;
}

function unapplyPauseTypeTo(_pause_type, _target)
{ 
	if (instance_number(_target) < 1) { return; }
	_target.pauses_inflicted[_pause_type] = false;	
}

//=====================================================
// DISPLAY FUNCTIONS
//=====================================================
function setSpriteDirectionPerLRInput(_input_horizontal)
{
	if (_input_horizontal != 0)
	{ sprite_direction = _input_horizontal; }
}

function setImageSpeedPerHSpeed(_reference_point)
{
	image_speed = (h_speed / _reference_point);
}

//=====================================================
// INTERACTIVITY FUNCTIONS
//=====================================================

function jumpAttackDetection(_minimum_height_difference = 0)
{	
	//Look for a player above this object.
	//This might need to use a ds_list in the event of like, two players
	//trying to attack at once from different heights.
	//But let's not pre-emptively solve a problem that may not exist.
	var this_object = instance_place(x, y-1, obj_parent_player);
	
	//If there is none, return.
	if (this_object == noone) { return false; }
	
	//If there is a minimum height difference, account for it.
	if (_minimum_height_difference > 0)
	&& ((y - this_object.y) < _minimum_height_difference)
	{ return false; }
		
	//Otherwise, see if that player is attempting to move downward into this object.
	return sign(this_object.attempted_movement_this_frame_y) > 0;
}

//=====================================================
// COLLECTIBLE FUNCTIONS
//=====================================================

function collectCoin(_collector, _amount)
{
	_collector.coins += _amount;
	
	if (_collector.coins > 99)
	{
		_collector.coins -= 100;
		collect1UP(_collector, 1);
	}
}

function collect1UP(_collector, _amount)
{
	playSFX(sfx_1up);
	
	if (_collector.coins < 99)
	{
		_collector.lives_remaining += _amount;
	}
}