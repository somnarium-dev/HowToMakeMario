// Configuration:

// Display offsets for various HUD components.
offsets =
{
	emblem:				{ _x: 16,  _y: 16 },
	plevel:				{ _x: 64,  _y: 8  },
	pindicator:			{ _x: 112, _y: 8  },
	coins:				{ _x: 144, _y: 8  },
	lives_remaining:	{ _x: 40,  _y: 16 },
	point_total:		{ _x: 64,  _y: 16 },
	level_timer:		{ _x: 136, _y: 16 },
	end_of_level_cards:	{ _x: 176, _y: 8  },
	world:				{ _x: 48, _y: 8  }
	
};

plevel_pip_spacing = 8;

number_end_of_level_cards = 3;
end_of_level_card_spacing = 24;

// Text display settings.
coins_num_places  = 2;
lives_num_places  = 2;
point_total_num_places = 7;
timer_num_places  = 3;

coins_string = string_repeat("0", coins_num_places);
lives_string = string_repeat("0", lives_num_places);
point_total_string = string_repeat("0", point_total_num_places);
level_timer_string = string_repeat("0", timer_num_places);

// Internal functionality.
timer = 0;
indicator_flash_timing = 6;
indicator_flash = false;