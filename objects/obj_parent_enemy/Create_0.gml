// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

//Simulated Inputs
ai_input_run_pressed = false;
ai_input_run_held = false;
ai_input_run_released = false;

ai_input_jump_pressed = false;
ai_input_jump_held = false;
ai_input_jump_released = false;

ai_input_lr = 0;
ai_input_ud = 0;

//Movement and collision detection.
gravity_context = gravity_type.air;

inflicted_h_gravity = 0;
inflicted_v_gravity = 0;

h_speed = 0;
v_speed = 0;

inflicted_h_speed = 0;
inflicted_v_speed = 0;

horizontal_pixels_accumulated = 0;
vertical_pixels_accumulated = 0;

adjustment_h_pixels = 0;
adjustment_v_pixels = 0;

horizontal_pixels_queued = 0;
vertical_pixels_queued = 0;

impassable_list = ds_list_create();

//Stats
accel_rate = 1;
decel_rate = 1;

current_top_speed = 1;

//Display
sprite_direction = 1;

//Internal functionality
timer = 0;

marked_for_death = false;
death_sequence_phase = 0;

can_reach_max_speed = false;
can_reach_run_speed = false;

cap_to_top_speed = true;

process_gravity = true;
process_acceleration = true;
process_inflicted_acceleration = true;
process_pixel_accumulation = true;
process_movement = true;
process_collision_detection = true;

//Initialization.
behavior = enemy_behavior.idle;
state = enemy_state.stand;

