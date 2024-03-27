event_inherited();

//Custom Methods and State Machine.
event_user(0);
event_user(1);

//Attach to stats.
stat_block = global.player_1;

//Controls.
generate_standard_inputs();

input_run_pressed = false;
input_run_held = false;
input_run_released = false;
	
input_jump_pressed = false;
input_jump_held = false;
input_jump_released = false;
	
input_lr = 0;
input_ud = 0;

input_direction = 0;
previous_input_direction = input_direction;

//Stats
h_startup_boost = stat_block.h_startup_boost;

accel_rate = stat_block.accel_rate;
decel_rate = stat_block.decel_rate;

walk_speed = stat_block.walk_speed;
run_speed = stat_block.run_speed;
max_speed = stat_block.max_speed;

current_top_speed = walk_speed;

plevel_charge = 0;
plevel_charge_rate = 3;
plevel_pip_value = 24;
plevel_charge_max = plevel_pip_value * global.plevel_max;

//Internal functionality.
timer = 0;

marked_for_death = false;
death_sequence_phase = 0;

can_reach_max_speed = false;
can_reach_run_speed = false;

cap_to_top_speed = true;

states_that_can_accelerate_to_max_speed =
[
	player_state.grab_run,
	player_state.run
];

states_that_can_accelerate_to_run_speed =
[
	player_state.float,
	player_state.grab_stand,
	player_state.grab_walk,
	player_state.kick,
	player_state.stand,
	player_state.walk
];

states_that_cap_to_top_speed =
[
	player_state.crouch,
	player_state.float,
	player_state.grab_run,
	player_state.grab_stand,
	player_state.grab_walk,
	player_state.kick,
	player_state.run,
	player_state.skid,
	player_state.slide,
	player_state.stand,
	player_state.swim,
	player_state.walk
];

//Other configuration
can_strike_objects = {above: true, below: false, left: false, right: false};
can_break_objects = {above: false, below: false, left: false, right: false};

//Debug
all_nearby_collisions = [];
all_nearby_collisions[0] = false;
all_nearby_collisions[45] = false;
all_nearby_collisions[90] = false;
all_nearby_collisions[135] = false;
all_nearby_collisions[180] = false;
all_nearby_collisions[225] = false;
all_nearby_collisions[270] = false;
all_nearby_collisions[315] = false;

//Associated objects.
hud = instance_create_layer(0, 0, "HUD", obj_hud_level);

//Initialization.
current_power = player_power.small;

updateSprites();
updateState(player_state.stand);