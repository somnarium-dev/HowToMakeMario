//Player Power - the current powerup held by a given player.
enum player_power
{
    small,
	mid,
    big,
    fire,
    raccoon,
}

//Player State - used for state machines, sprite settings, and some other checks.
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

//Damage Type - used when processing potentially damaging attacks between objects.
enum damage_type
{
	none,
	touch,
	jump,
	shell,
	fire,
	tail,
	star
}

//Enemy State - Used for state machines inside of enemy objects.
enum enemy_state
{
	stand,
	walk,
	shell,
	stomped,
	die
}

//Enemy Behavior - Used for behavior machines (AI) inside of enemy objects.
enum enemy_behavior
{
	idle,
	patrol,
	hide,
	search,
	escape,
	pre_attack,
	attack,
	post_attack
}

//Block State - Used for state machines inside of item blocks and bricks.
enum block_state
{
	idle,
	empty,
	animate_out,
	animate_in,
	destroyed
}

//Item From Block State - Used for state machines inside of the contents of item blocks.
enum item_from_block_state
{
	appear,
	idle,
	roam,
	jump,
	fall,
	destroyed
}

//Gravity Type - Used to select a set of gravitational properties, including things like strength and terminal velocity.
enum gravity_type
{
	air,
	water,
	low,
	coin
}

//Pause Types - Used to pause for various reasons, while not overwriting existing pauses or destroying information in the process.
enum pause_types
{
	transition,
	all_execution,
	player_pause,
	player_death_pause,
	time_stop,
	special
}