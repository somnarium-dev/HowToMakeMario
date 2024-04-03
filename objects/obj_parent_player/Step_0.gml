handleExecutionPauses(id);
if (paused) { exit; }
if (global.pause_during_transition) { exit; }

state_machine[state]();