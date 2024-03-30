// Don't draw this object during screen transitions.
if (global.pause_during_transition) { exit; }

// If the object mask is set to something other than its sprite, display it.
if (global.show_debug_data)
{ 
	if (mask_index != -1)
	{draw_sprite(mask_index, 0, x, y); }
}

// Handle sprite flipping and offsetting.
var h_scale = image_xscale;
var v_scale = image_yscale;
var h_display_offset = 0;
var v_display_offset = 0;

if (object_is_ancestor(id.object_index, obj_parent_player))
|| (object_is_ancestor(id.object_index, obj_parent_enemy))
|| (object_is_ancestor(id.object_index, obj_parent_item))
{
	h_scale = sprite_horizontal_direction;
	v_scale = sprite_vertical_direction;
	
	if (v_scale == -1)
	{ v_display_offset = -sprite_vertical_flip_adjust; }
}

// Draw.
draw_sprite_ext
(
	sprite_index,
	image_index,
	x + h_display_offset,
	y + v_display_offset,
	h_scale,
	v_scale,
	image_angle,
	image_blend,
	image_alpha
);