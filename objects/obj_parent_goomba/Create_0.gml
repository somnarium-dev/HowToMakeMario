// Inherit the parent event
event_inherited();

//Stats
hp = 1;

accel_rate = 0.5;
decel_rate = 0.1;

current_top_speed = 0.5;

sprites =
{
	walk: sprite_index,
	stomped: spr_goomba_brown_stomped
}

//Initialize
ai_input_lr = initial_lr_input;

state = enemy_state.walk;
behavior = enemy_behavior.patrol;