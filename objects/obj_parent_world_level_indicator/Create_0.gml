// Inherit the parent event.
event_inherited();

// Load level data.
level_contained = global.world_data[global.world].levels[level_number].level_contained;
level_bgm = global.world_data[global.world].levels[level_number].initial_bgm;
cleared = global.world_data[global.world].levels[level_number].cleared;
help_indicator = global.world_data[global.world].levels[level_number].help_indicator;
help_indicator_object = noone;

// If this level has already been cleared,
// change sprite to match the clear graphic for the player that cleared it.
if (cleared != false)
{ sprite_index = asset_get_index("spr_" + cleared + "_clear_indicator"); }

// If this level should display a "Help!" indicator,
// create it now.
else if (help_indicator)
{ instance_create_layer(x + 16, y - 16, "Level_Indicators", obj_world_prop_help_bubble); }