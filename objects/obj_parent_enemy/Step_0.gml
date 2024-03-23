handleExecutionPauses(id);
if (paused) { exit; }

behavior_machine[behavior]();
state_machine[state]();