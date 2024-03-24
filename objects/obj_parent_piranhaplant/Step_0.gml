handleExecutionPauses(id);
if (paused) { exit; }

var this_behavior = global.enemy_behavior_string[behavior]; 
var this_state = global.enemy_state_string[state];

show_debug_message($"[{id}] B: {this_behavior}, S: {this_state}");

behavior_machine[behavior]();
state_machine[state]();