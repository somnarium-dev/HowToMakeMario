///@desc State Management

state_machine = [];

state_machine[player_state.climb] = function()
{
	
}

state_machine[player_state.crouch] = function()
{
	
}

state_machine[player_state.die] = function()
{
	processDeathSequencing();
}

state_machine[player_state.enter_door] = function()
{
	
}

state_machine[player_state.enter_pipe] = function()
{
	
}

state_machine[player_state.exit_door] = function()
{
	
}

state_machine[player_state.exit_pipe] = function()
{
	
}

state_machine[player_state.fall] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToLand();
}

state_machine[player_state.float] = function()
{
	
}

state_machine[player_state.grab_jump] = function()
{
	
}

state_machine[player_state.grab_run] = function()
{
	
}

state_machine[player_state.grab_stand] = function()
{
	
}

state_machine[player_state.grab_walk] = function()
{
	
}

state_machine[player_state.jump] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToLand();
	checkTransitionToFall();
}

state_machine[player_state.kick] = function()
{
	
}

state_machine[player_state.run] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed();
	
	checkTransitionToFall();
	checkTransitionToStand();
	checkTransitionToWalk();
	checkTransitionToSkid();
	checkTransitionToJump();	
}

state_machine[player_state.run_fall] = function()
{	
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToLand();
}

state_machine[player_state.run_jump] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToLand();
	checkTransitionToFall();
}

state_machine[player_state.skid] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToFall();
	checkTransitionSkidToWalk();
	checkTransitionToJump();
}

state_machine[player_state.slide] = function()
{
	
}

state_machine[player_state.stand] = function()
{
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed();
	
	checkTransitionToFall();
	checkTransitionToWalk();
	checkTransitionToJump();	
}

state_machine[player_state.swim] = function()
{
	
}

state_machine[player_state.walk] = function()
{	
	setSpriteDirectionPerLRInput();
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed();
	
	checkTransitionToFall();
	checkTransitionToStand();
	checkTransitionToRun();
	checkTransitionToSkid();
	checkTransitionToJump();
}

//===================================================================================
// State Transitions
//===================================================================================

///@func checkTransitionToStand()
checkTransitionToStand = function()
{
	if (h_speed != 0)
	{ return; }
	
	updateState(player_state.stand);
	image_speed = 0
}

///@func checkTransitionToWalk()
checkTransitionToWalk = function()
{
	if (h_speed != 0)
	&& (!atMaxPLevel())
	{ updateState(player_state.walk); }
}

///@func checkTransitionToRun()
checkTransitionToRun = function()
{
	if (atMaxPLevel())
	{ updateState(player_state.run); }
}

///@func checkTransitionToSkid();
checkTransitionToSkid = function()
{
	if (input_lr != 0)
	&& (input_lr != sign(h_speed))
	&& (abs(h_speed) > global.player_1.walk_speed)
	{ updateState(player_state.skid); }
}

///@func checkTransitionSkidToWalk();
checkTransitionSkidToWalk = function()
{
	if (input_lr == sign(h_speed))
	|| (abs(h_speed) <= global.player_1.walk_speed)
	{ updateState(player_state.walk); }
}

///@func checkTransitionToJump()
checkTransitionToJump = function()
{
	if (!input_jump_pressed) 
	|| (!checkForImpassable(x, y+1))
	{ return;}
	
	var current_speed = abs(h_speed);
	
	var jump_strength = global.player_1.jump_strength;
	
	if (current_speed > global.player_1.walk_speed)
	{ jump_strength = global.player_1.moving_jump_strength; }
	
	v_speed = -jump_strength;
		
	var new_state = player_state.jump;
		
	if (atMaxPLevel())
	{ new_state = player_state.run_jump; }
		
	playSFX(sfx_jump);
		
	updateState(new_state);
}

///@func checkTransitionToFall()
checkTransitionToFall = function()
{
	if (checkForImpassable(x, y+1))
	{ return; }
	
	if (state == player_state.jump)
	&& (v_speed < 0)
	{ return; }
	
	var new_state = player_state.fall;
	
	if (atMaxPLevel())
	{ new_state = player_state.run_fall; }
	
	updateState(new_state);
	image_speed = 0;
}

///@func checkTransitionToLand()
checkTransitionToLand = function()
{
	if (v_speed < 0)
	|| (!checkForImpassable(x, y+1))
	{ exit; }
	
	if (h_speed == 0)
	{
		updateState(player_state.stand);
		image_speed = 0;
	}
		
	else
	{
		var new_state = player_state.walk;
			
		if (atMaxPLevel())
		{ new_state = player_state.run; }
			
		updateState(new_state);
	}
}

///@func transitionToDeathState()
transitionToDeathState = function()
{
	applyPauseForDeathSequence();
	
	global.accept_player_input = false;
	global.view_track_on_y = false;
	
	ceaseAllMovement();
	clearAllInputVariables();
	
	process_collision_detection = false;
	timer = global.death_pause_timing.pause_length;
	death_sequence_phase = 1;
	
	updateState(player_state.die);
	
	playBGM(global.music_playerdown);
}