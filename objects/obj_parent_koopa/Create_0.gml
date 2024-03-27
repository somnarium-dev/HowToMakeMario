// Inherit the parent event
event_inherited();

//Configuration
sprites = 
{
	walk: spr_koopa_green_walk,
	shell: spr_koopa_green_shell
}

//Stats
hp = 1;

accel_rate = 1;
decel_rate = 1;

walk_speed = 0.5;
shell_speed = 3;

shell_direction = 0;

current_top_speed = walk_speed;

//Initialize
ai_input_lr = initial_lr_input;

state = enemy_state.walk;
behavior = enemy_behavior.patrol;