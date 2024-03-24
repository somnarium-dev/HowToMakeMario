///@desc Behavior Machine

// Inherit the parent event
event_inherited();

//=================================================================================================
// BEHAVIORS
//=================================================================================================

behavior_machine[enemy_behavior.hide] = function()
{
	ai_input_ud = 0;
	
	behavior_timer++;
	
	if (behavior_timer >= hide_timing)
	{ updateBehavior(enemy_behavior.search); }
}

behavior_machine[enemy_behavior.search] = function()
{
	ai_input_ud = -1;
	extension -= ai_input_ud;
	
	if (extension == max_extension)
	{
		ai_input_ud = 0;
		updateBehavior(enemy_behavior.pre_attack);
	}
}

behavior_machine[enemy_behavior.pre_attack] = function()
{
	behavior_timer++;
	
	if (behavior_timer >= pre_attack_timing)
	{
		ai_input_run_pressed = true;
		updateBehavior(enemy_behavior.attack);
	}
}

behavior_machine[enemy_behavior.attack] = function()
{
	behavior_timer++;
	
	if (behavior_timer >= attack_timing)
	{
		mouth_is_open = false;
		updateBehavior(enemy_behavior.post_attack);
	}
}

behavior_machine[enemy_behavior.post_attack] = function()
{
	behavior_timer++;
	
	if (behavior_timer >= post_attack_timing)
	{ updateBehavior(enemy_behavior.escape); }
}

behavior_machine[enemy_behavior.escape] = function()
{
	ai_input_ud = 1;
	extension -= ai_input_ud;
	
	if (extension == 0)
	{ updateBehavior(enemy_behavior.hide); }
}

//=================================================================================================
// BEHAVIOR TRANSITIONS
//=================================================================================================

