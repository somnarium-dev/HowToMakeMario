// Inherit the parent event
event_inherited();

//Load custom functions.
event_user(0);
event_user(1);

//Internal functionality.
process_hit = false;
hit_from = 270;
animate_toward = hit_from - 180;

animation_timing = 3;

display_offset_x = 0;
display_offset_y = 0;

state = block_state.idle;