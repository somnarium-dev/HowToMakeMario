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