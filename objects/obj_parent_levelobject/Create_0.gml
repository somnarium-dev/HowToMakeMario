impassable = false;

//Simulated Inputs
ai_input_run_pressed = false;
ai_input_run_held = false;
ai_input_run_released = false;

ai_input_jump_pressed = false;
ai_input_jump_held = false;
ai_input_jump_released = false;

ai_input_lr = 0;
ai_input_ud = 0;

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

starting_x = x;
starting_y = y;

attempted_movement_this_frame_x = 0;
attempted_movement_this_frame_y = 0;

actual_movement_this_frame_x = 0;
actual_movement_this_frame_y = 0;

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

can_strike_objects = {above: false, below: false, left: false, right: false};
can_break_objects = {above: false, below: false, left: false, right: false};

strike_data = {striker: noone, animation_direction: -1};

impassable_list = ds_list_create();
strike_detection_list = ds_list_create();

jump_attack = { registered: false, attacker: noone };

bounce_when_jump_attacked = false;

//Stats
accel_rate = 0.05;
decel_rate = 0.01;

directional_distance_to_nearest_player = -1;
x_distance_to_nearest_player = -1;
y_distance_to_nearest_player = -1;

current_top_speed = 1;

marked_for_death = false;
death_sequence_phase = 0;
death_sequence_timing = 0;

can_reach_max_speed = false;
can_reach_run_speed = false;

cap_to_top_speed = true;

//Display
sprite_horizontal_direction = 1;
sprite_vertical_direction = 1;

//Internal functionality
timer = 0;
state_timer = 0;
behavior_timer = 0;