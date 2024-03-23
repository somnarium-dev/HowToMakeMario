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

//Movement and Collision
h_speed = 0;
v_speed = 0;

//Stats
accel_rate = 1;
decel_rate = 1;

current_top_speed = 1;

//Display
sprite_direction = 1;

behavior = enemy_behavior.idle;
state = enemy_state.stand;

