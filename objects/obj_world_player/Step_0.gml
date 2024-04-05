// Inherit the parent event
event_inherited();

// Handle pausing.
if (paused) { exit; }
if (global.pause_during_transition) { exit; }

var state = global.player_data[global.current_player].map_state;

state_machine[state]();