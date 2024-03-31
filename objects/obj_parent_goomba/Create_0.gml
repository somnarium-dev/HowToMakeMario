// Inherit the parent event
event_inherited();

// Stats
hp = 1;

accel_rate = 0.5;
decel_rate = 0.1;

walk_speed = 0.5;

current_top_speed = walk_speed;

sprites =
{
	walk: sprite_index,
	stomped: spr_goomba_brown_stomped
}

// Initialize
behavior = enemy_behavior.patrol;
state = enemy_state.walk;