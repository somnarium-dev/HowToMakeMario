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
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToWalk();
	checkTransitionToStand();
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
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToFall();
}

state_machine[player_state.kick] = function()
{
	
}

state_machine[player_state.run] = function()
{
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed(global.player_1.walk_speed);
	
	checkTransitionToFall();
	checkTransitionToStand();
	checkTransitionToWalk();
	checkTransitionToSkid();
	checkTransitionToJump();	
}

state_machine[player_state.run_fall] = function()
{	
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToWalk();
	checkTransitionToStand();
}

state_machine[player_state.run_jump] = function()
{
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	checkTransitionToWalk();
	checkTransitionToStand();
	checkTransitionToFall();
}

state_machine[player_state.skid] = function()
{
	setSpriteDirectionPerLRInput(input_lr);
	
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
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed(global.player_1.walk_speed);
	
	checkTransitionToFall();
	checkTransitionToJump();
	checkTransitionToWalk();
}

state_machine[player_state.swim] = function()
{
	
}

state_machine[player_state.walk] = function()
{	
	setSpriteDirectionPerLRInput(input_lr);
	
	handlePlayerMovementAndCollision();
	
	setImageSpeedPerHSpeed(global.player_1.walk_speed);
	
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
	var on_the_ground = checkForImpassable(x, y+1);
	
	if (on_the_ground)
	&& (h_speed == 0)
	{ 
		updateState(player_state.stand);
		image_speed = 0;
	}
}

///@func checkTransitionToWalk()
checkTransitionToWalk = function()
{
	var on_the_ground = checkForImpassable(x, y+1);
	
	if (on_the_ground)
	&& (h_speed != 0)
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
	//If we are not trying to jump
	//Or it is not possible to jump
	//Then do not jump.
	if (!input_jump_pressed) 
	|| (!checkForImpassable(x, y+1))
	{ return;}
	
	//Play sound.
	playSFX(sfx_jump);
	
	//Set jump strength.
	var jump_strength = global.player_1.jump_strength;
	
	//Increase jump strength if moving.
	var current_speed = abs(h_speed);
	
	if (current_speed > global.player_1.walk_speed)
	{ jump_strength = global.player_1.moving_jump_strength; }
	
	//Convert jump strength to negative vertical speed.
	v_speed = -jump_strength;
		
	//Determine the next appropriate state.
	var new_state = player_state.jump;
		
	if (atMaxPLevel())
	{ new_state = player_state.run_jump; }
		
	//Update state.
	updateState(new_state);
}

///@func checkTransitionToFall()
checkTransitionToFall = function()
{
	//If we are on the ground
	//Then we are not falling.
	if (checkForImpassable(x, y+1))
	{ return; }
	
	//If we are jumping
	//And we are ascending
	//Then we are not falling.
	if (state == player_state.jump)
	&& (v_speed < 0)
	{ return; }
	
	//Determine the next appropraite state.
	var new_state = player_state.fall;
	
	if (atMaxPLevel())
	{ new_state = player_state.run_fall; }
	
	//Update state.
	updateState(new_state);
	image_speed = 0;
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