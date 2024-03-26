// Inherit the parent event
event_inherited();

//Load custom functions.
event_user(0);
event_user(1);

//Internal functionality.
idle_sprite = sprite_index;
hit_sprite = spr_block_empty;

animate_toward = 90;

animation_timing = 3;

display_offset_x = 0;
display_offset_y = 0;

//Initialize.
state = block_state.idle;