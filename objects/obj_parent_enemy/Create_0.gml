// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

//Configuration
pass_through_enemies = false;

//Initialization.
behavior = enemy_behavior.idle;
state = enemy_state.stand;