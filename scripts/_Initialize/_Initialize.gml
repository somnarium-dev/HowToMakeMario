function Initialize()
{

	//Define global values.
	global.tile_size = 16;
	global.single_room_width = 256;
	global.single_room_height = 224;
	
	global.preferences =
	{
		master_volume: 100,
		music_volume: 100,
		sfx_volume: 100
	};
	
	global.show_debug_data = false;
	
	global.accept_player_input = true;
	
	global.pause_during_transition = false;
	global.pause_all_execution = false;
	
	global.plevel_max = 7;
	
	global.death_pause_timing =
	{
		pause_length: convertSamplesToFrames(15334, 44100),
		play_off_length: convertSamplesToFrames(122419, 44100)
	}
	
	global.next_room = Level_1_1;
	
	global.world = 1;
	
	global.gravity_direction = 270;
	
	global.gravity_data = [];
	global.gravity_data[gravity_type.air] = { strength: .2, terminal_velocity: 3 }; //was .2
	global.gravity_data[gravity_type.water] = { strength: 0.05, terminal_velocity: 3 };
	global.gravity_data[gravity_type.low] = { strength: 0.1, terminal_velocity: 2 };
	
	global.level_timer = 300;
	
	global.player_state_string = 
	[
		"mask",
		"climb",
		"crouch",
		"die",
		"enter_door",
		"enter_pipe",
		"exit_door",
		"exit_pipe",
		"fall",
		"float",
		"grab_jump",
		"grab_run",
		"grab_stand",
		"grab_walk",
		"jump",
		"kick",
		"run",
		"run_fall",
		"run_jump",
		"skid",
		"slide",
		"stand",
		"swim",
		"walk"
	]
	
	global.enemy_state_string =
	[
		"stand"
	]

	//Define assets.
	initializeCharacters();
	initializeMusic();
	
	//Define fonts.
	global.font_system = fnt_lanapixel;
	global.font_default = font_add_sprite_ext(spr_font_default, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?'., ", false, 0);
	global.font_hudnumbers = font_add_sprite_ext(spr_font_hudnumbers, "0123456789", false, 0);

	draw_set_font(global.font_default);

	//Define the camera and its attributes.
	global.camera_target_0 = "p1";
	
	global.game_camera = instance_create_layer(0,0,"System",obj_camera);
	global.game_camera.setGameResolutionAndCenter(display_get_width(), display_get_height());
	
	//These are used to ensure the camera stops traveling
	//within certain distances of the edges of a room.
	global.view_travel_boundary_left = 0;
	global.view_travel_boundary_up = -32;
	global.view_travel_boundary_right = global.view_travel_boundary_left;
	global.view_travel_boundary_down = global.view_travel_boundary_up;
	
	//This is used to position the camera correctly when rooms are small.
	global.view_current_left_margin = 0;
	global.view_current_top_margin = 0;
	
	//Create other essential objects.
	global.debug_manager = instance_create_layer(0,0, "System", obj_debug_manager);
	global.music_manager = instance_create_layer(0,0, "System", obj_music_manager);
	
	//Define player 1 defaults.
	global.player_1 = 
	{	
		current_id: noone,
		character_index: 0,
		sprites: variable_clone(loadAllCharacterSprites("mario")),
		sounds: variable_clone(global.character_data[0].sounds),
		accel_rate: 0.05,
		decel_rate: 0.1,
		walk_speed: 1.25,
		run_speed: 3,
		max_speed: 3.5,
		jump_strength: 4.5,
		moving_jump_strength: 4.8,
		lives_remaining: 0,
		point_total: 0,
		coins: 0,
		plevel: 0,
		cards: [0, 0, 0]
	}
	
	//playBGM(global.music_overworld, true);
	
	//Continue.
	transitionIrisToRoom(global.next_room, false, false, true);
}