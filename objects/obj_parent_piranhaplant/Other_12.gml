///@desc Behavior Machine

// Inherit the parent event
event_inherited();

//=================================================================================================
// BEHAVIORS
//=================================================================================================

//----------
// In Pipe
//----------
behavior_machine[enemy_behavior.hide] = function()
{
	targetNearestPlayer();
	
	behavior_timer++;
	
	//Don't pop out if the player is against the side of the pipe,
	//or if the player is touching the mouth of the pipe.
	if (isThreatened())
	{ behavior_timer = 0; }
	
	if (behavior_timer >= hide_timing)
	{ updateBehavior(enemy_behavior.search); }
}

//----------
// Pop Out
//----------
behavior_machine[enemy_behavior.search] = function()
{
	targetNearestPlayer();
	
	ai_input_ud = -1;
	
	if (extension == max_extension)
	{
		ai_input_ud = 0;
		
		if (is_spitter) //Spitter Next Behavior
		{ updateBehavior(enemy_behavior.pre_attack); }
		
		else //Biter Next Behavior
		{ updateBehavior(enemy_behavior.attack); }
	}
}

//----------
// Aim (Spitter Only)
//----------
behavior_machine[enemy_behavior.pre_attack] = function()
{
	targetNearestPlayer();
	
	behavior_timer++;
	
	if (behavior_timer >= pre_attack_timing)
	{
		ai_input_run_pressed = true;
		updateBehavior(enemy_behavior.attack);
	}
}

//----------
// Spit or Bite
//----------
behavior_machine[enemy_behavior.attack] = function()
{
	targetNearestPlayer();
	
	behavior_timer++;
	
	if (behavior_timer >= attack_timing)
	{
		if (is_spitter) //Spitter Next Behavior
		{ updateBehavior(enemy_behavior.post_attack); }
	
		else //Biter Next Behavior
		{ updateBehavior(enemy_behavior.escape); }
	}
}

//----------
// Linger Post Spit
//----------
behavior_machine[enemy_behavior.post_attack] = function()
{
	behavior_timer++;
	
	if (behavior_timer >= post_attack_timing)
	{ updateBehavior(enemy_behavior.escape); }
}

//----------
// Retreat to Pipe
//----------
behavior_machine[enemy_behavior.escape] = function()
{
	targetNearestPlayer();
	
	ai_input_ud = 1;
	
	if (extension == 0)
	{ 
		ai_input_ud = 0;
		updateBehavior(enemy_behavior.hide);
	}
}