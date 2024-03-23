enum player_power
{
    small,
	mid,
    big,
    fire,
    raccoon,
}

enum player_state
{
	mask, //This is used to set the collision mask.
	climb,
	crouch,
	die,
	enter_door,
	enter_pipe,
	exit_door,
	exit_pipe,
	fall,
	float,
	grab_jump,
	grab_run,
	grab_stand,
	grab_walk,
	jump,
	kick,
	run,
	run_fall,
	run_jump,
	skid,
	slide,
	stand,
	swim,
	walk
}

enum enemy_state
{
	stand,
	walk,
	die
}

enum enemy_behavior
{
	idle,
	patrol
}

enum gravity_type
{
	air,
	water,
	low
}

enum pause_types
{
	transition,
	all_execution,
	player_pause,
	player_death_pause,
	time_stop,
	special
}