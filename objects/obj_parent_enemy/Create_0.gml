// Inherit the parent event
event_inherited();

//Define Custom Methods and State Machines
event_user(0);
event_user(1);
event_user(2);

//Configuration
bounce_when_jump_attacked = true;

//Internal functionality.
safe_stomp_height = 8;
lose_hp_when_jumped_on = true;
hp = 1;

death_sequence_timing = 60;

//Initialization.
behavior = enemy_behavior.idle;
state = enemy_state.stand;