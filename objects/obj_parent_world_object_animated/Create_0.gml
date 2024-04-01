// Pausing variables.
stored_image_speed = 0;

pauses_inflicted = [];
pauses_inflicted[pause_types.transition] = false;
pauses_inflicted[pause_types.all_execution] = false;
pauses_inflicted[pause_types.player_pause] = false;
pauses_inflicted[pause_types.time_stop] = false;
pauses_inflicted[pause_types.special] = false;

paused = false;