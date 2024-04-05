event_inherited();

//Controls.
generatePlayerInputs();

//Stats
stat_block = global.player_data[player_slot];

updateStats();

plevel_charge = 0;
plevel_charge_rate = 3;
plevel_pip_value = 24;
plevel_charge_max = plevel_pip_value * global.plevel_max;

//Internal functionality.
timer = 0;
kick_timer = 0;
kick_timer_max = 12;

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

kicking = false;

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
hud = instance_create_layer(0, 0, "HUD", obj_hud_level, {source: id});

//Initialization.
current_power = player_power.small;

updateSprites();
updatePlayerState(player_state.stand);