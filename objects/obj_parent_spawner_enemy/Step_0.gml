if (global.pause_during_transition) { exit; }
if (contents == undefined) { exit; }

most_recent_spawn = instance_create_layer(x + x_offset, y + y_offset, "Enemies", contents);