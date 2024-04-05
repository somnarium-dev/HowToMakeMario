// Inherit the parent event
event_inherited();

// Load custom methods.
event_user(0);
event_user(1);

// Load data.
x = global.world_data[global.world].enemies[enemy_index].coordinates._x;
y = global.world_data[global.world].enemies[enemy_index].coordinates._y;
state = global.world_data[global.world].enemies[enemy_index].state;

// Movement.
shuffle_moves_remaining = 0;

move_direction = 0;
move_distance = 0;
move_speed = 2;

move_x = 0;
move_y = 0;

obstacle_check_distance = 16;
movement_check_distance = 32;

// Display.
sprite_horizontal_direction = 1;

h_display_offset = 0;
v_display_offset = 0;

h_display_offset_step = 0.2;
h_display_offset_accumulated = 0;
max_h_display_offset = 3;