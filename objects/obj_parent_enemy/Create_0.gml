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

//Stats
accel_rate = 1;
decel_rate = 1;

directional_distance_to_nearest_player = -1;
x_distance_to_nearest_player = -1;
y_distance_to_nearest_player = -1;

current_top_speed = 1;

//Internal functionality
timer = 0;
state_timer = 0;
behavior_timer = 0;

marked_for_death = false;
death_sequence_phase = 0;

can_reach_max_speed = false;
can_reach_run_speed = false;

cap_to_top_speed = true;

//Initialization.
behavior = enemy_behavior.idle;
state = enemy_state.stand;