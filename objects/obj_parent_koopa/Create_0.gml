// Inherit the parent event
event_inherited();

// Configuration
sprites = 
{
	walk: spr_koopa_green_walk,
	shell: spr_koopa_green_shell
}

// Stats
hp = 1;

accel_rate = 1;
decel_rate = 1;

walk_speed = 0.5;
shell_speed = 3;

current_top_speed = walk_speed;

shell_direction = 0;

// Initialize
behavior = enemy_behavior.patrol;
state = enemy_state.walk;