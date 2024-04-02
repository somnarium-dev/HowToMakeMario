// Inherit the parent event
event_inherited();

// Load custom functionality.
event_user(0);
event_user(1);

//Controls.
generatePlayerInputs();

// Load data.
updateMapSprites();

// Internal functionality.
load_in_timing = 15;
post_level_timing = 30;

move_speed = 2;

move_direction = 0;
move_distance = 0;
move_x = 0;
move_y = 0;

obstacle_check_distance = 16;
movement_check_distance = 32;

bump_sound_timer = 0;
bump_sound_buffer_timing = 15;

target_level = undefined;

// Initialize.
x = global.player_data[global.current_player].map_coordinates._x;
y = global.player_data[global.current_player].map_coordinates._y;

kickback_x = global.player_data[global.current_player].map_coordinates_last_clear._x;
kickback_y = global.player_data[global.current_player].map_coordinates_last_clear._y;

sprite_index = pin_sprite;
