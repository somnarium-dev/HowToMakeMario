// Inherit the parent event
event_inherited();

//Configuration
pass_through_enemies = false;

//Initialization.
behavior = enemy_behavior.idle;
state = enemy_state.stand;

ai_input_lr = initial_lr_input;