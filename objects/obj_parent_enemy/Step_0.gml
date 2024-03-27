handleExecutionPauses(id);
if (global.pause_during_transition) { exit; }
if (paused) { exit; }

behavior_machine[behavior]();
state_machine[state]();