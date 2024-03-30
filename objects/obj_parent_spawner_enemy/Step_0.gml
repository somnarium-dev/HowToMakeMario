if (global.pause_during_transition) { exit; }
if (contents == undefined) { exit; }
if (most_recent_spawn != noone) { exit; }

most_recent_spawn = instance_create_layer(x + x_offset, y + y_offset, "Enemies", contents, {initial_lr_input: initial_horizontal_sign});

// If this spawner does not respawn, destroy it.
if (!respawn_contents)
{ instance_destroy(); }