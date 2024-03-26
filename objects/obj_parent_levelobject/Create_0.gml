impassable = false;

//Configuration.
process_gravity = true;
process_acceleration = true;
process_inflicted_acceleration = true;
process_pixel_accumulation = true;
process_movement = true;
process_collision_detection = true;

//Pausing.
stored_image_speed = 0;

paused = false;

pauses_inflicted = [];
pauses_inflicted[pause_types.transition] = false;
pauses_inflicted[pause_types.all_execution] = false;
pauses_inflicted[pause_types.player_pause] = false;
pauses_inflicted[pause_types.time_stop] = false;
pauses_inflicted[pause_types.special] = false;

//Movement and collision detection.
impassable = false;

gravity_context = gravity_type.air;

inflicted_h_gravity = 0;
inflicted_v_gravity = 0;

h_speed = 0;
v_speed = 0;

h_startup_boost = 0;

inflicted_h_speed = 0;
inflicted_v_speed = 0;

horizontal_pixels_accumulated = 0;
vertical_pixels_accumulated = 0;

adjustment_h_pixels = 0;
adjustment_v_pixels = 0;

horizontal_pixels_queued = 0;
vertical_pixels_queued = 0;

impassable_list = ds_list_create();

//Display
sprite_direction = 1;

//Internal functionality
timer = 0;
state_timer = 0;
behavior_timer = 0;