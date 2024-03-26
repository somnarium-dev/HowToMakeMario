if (global.pause_during_transition) { exit; }
if (contents == undefined) { exit; }
if (most_recent_spawn != noone) { exit; }

most_recent_spawn = spawnContents();