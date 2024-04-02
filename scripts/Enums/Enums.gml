// Player Power - the current powerup held by a given player.
enum player_power
{
    small,
	mid,
    big,
    fire,
    raccoon
	// Surely more to come.
}

// Player State - used for state machines, sprite settings, and some other checks.
enum player_state
{
	mask,		// This is used to set the collision mask.
	map,		// This is only used for the world map.
	pin,		// This is only used for the world map.
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
	kick,		// The player object never actually enters this state. It's just for sprite data.
	run,
	run_fall,
	run_jump,
	skid,
	slide,
	stand,
	swim,
	walk
}

// Player Map State - Used to control player state on world maps.
enum player_map_state
{
	load_in,
	new_world_map,
	select_level,
	in_motion,
	enter_level,
	post_level_death,
	post_level_clear,
	kickback
}

// Damage Type - used when processing potentially damaging attacks between objects.
enum damage_type
{
	none,	// Used for reseting damage data structs, and indicates no hit is registered.
	touch,	// Contact damage, touching spikes etc.
	jump,	// Specifically for when a player jumps onto/into something to attack it.
	shell,	// As you'd expect.
	fire,	// Fireballs, firebars, etc.
	tail,	// Raccoon / Tanuki suit tail flips.
	star	// Invincibility effects in general.
}

// Enemy State - Used for state machines inside of enemy objects.
enum enemy_state
{
	stand,
	walk,
	shell,
	stomped,	// Smashed by getting jumped on, likely has unique sprite or effect.
	die			// Killed by HP reduction, flipping over and jumping offscreen. 
}

// Enemy Behavior - Used for behavior machines (AI) inside of enemy objects.
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

// Block State - Used for state machines inside of item blocks and bricks.
enum block_state
{
	idle,
	empty,
	animate_out,
	animate_in,
	destroyed
}

// Item From Block State - Used for state machines inside of the contents of item blocks.
enum item_state
{
	appear,
	idle,
	roam,
	jump,
	fall,
	destroyed
}

// Gravity Type - Used to select a set of gravitational properties, including things like strength and terminal velocity.
enum gravity_type
{
	air,
	water,
	low,
	coin
}

// Pause Types - Used to pause for various reasons, while not overwriting existing pauses or destroying information in the process.
enum pause_types
{
	transition,
	all_execution,
	player_pause,
	player_death_pause,
	time_stop,
	special
}

// Obstacle Types - World map objects the block passage unless unlocked or destroyed.
enum obstacle_types
{
	lock,
	rock
}