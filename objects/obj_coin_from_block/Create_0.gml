// Inherit the parent event
event_inherited();

//Load custom methods.
event_user(0);
event_user(1);

//Internal functionality.
y -= 16;
ending_y_position = y - 16;
popup_strength = 8;

//Configuration.
process_collision_detection = false;

gravity_context = gravity_type.coin;