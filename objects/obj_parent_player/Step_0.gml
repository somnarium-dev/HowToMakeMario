if (y > room_height + 32)
{ marked_for_death = true; }

if (marked_for_death)
{
	if (state != player_state.die)
	{ transitionToDeathState(); }
}

if (paused) { exit; }
if (global.pause_during_transition) { exit; }

state_machine[state]();