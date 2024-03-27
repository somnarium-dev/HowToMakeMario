if (global.pause_during_transition) { exit; }

if (global.show_debug_data)
{ 
	if (mask_index != undefined)
	{draw_sprite(mask_index, 0, x, y); }
}

var h_scale = image_xscale;
var v_scale = image_yscale;

if (object_is_ancestor(id.object_index, obj_parent_player))
|| (object_is_ancestor(id.object_index, obj_parent_enemy))
|| (object_is_ancestor(id.object_index, obj_parent_item_box_contents))
{
	h_scale = sprite_horizontal_direction;
	v_scale = sprite_vertical_direction;
}
draw_sprite_ext
(
	sprite_index,
	image_index,
	x,
	y,
	h_scale,
	v_scale,
	image_angle,
	image_blend,
	image_alpha
);