// Inherit the parent event
event_inherited();

handleExecutionPauses(id);
if (global.pause_during_transition) { exit; }
if (paused) { exit; }

state_machine[state]();