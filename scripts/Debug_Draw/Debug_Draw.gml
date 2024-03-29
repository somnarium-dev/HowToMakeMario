function debugDrawState()
{	
	//If we're not displaying this right now, then quit.
	if (!global.show_debug_data) { exit; }

	//Otherwise, check if we're a player or an enemy.
	//Reference the appropriate array of strings.
	var read_array;
	
	var is_player = object_is_ancestor(id.object_index, obj_parent_player);
	var is_enemy = object_is_ancestor(id.object_index, obj_parent_enemy);
	var is_block = object_is_ancestor(id.object_index, obj_parent_block);
	
	if (is_player)
	{ read_array = global.player_state_string; }

	else if (is_enemy)
	{ read_array = global.enemy_state_string; }

	else if (is_block)
	{ read_array = global.block_state_string; }
	
	else
	{ 
		show_debug_message("[ERROR] debugDraw() - Attempted to display string array for undefined object type.");
		show_debug_message("Game will now crash.");
	}

	//Display the current state of this object as text.
	draw_set_font(global.font_system);

	var text_x = x + ceil(sprite_width / 2);
	var text_y = y - sprite_height;
	var text_contents = string_upper(read_array[state]);
	var text_contents_length = string_width(text_contents);

	text_x = clamp(text_x, 0, room_width - text_contents_length);
	text_y = clamp(text_y, 0, room_height - 2);
	
	var box_position_x = roomXToGUIX(text_x);
	var box_position_y = roomYToGUIY(text_y);
	var text_position_x = roomXToGUIX(text_x);
	var text_position_y = roomYToGUIY(text_y);

	draw_sprite_stretched(spr_hud_textbox_black, 0, box_position_x, box_position_y, text_contents_length + 6, 14);
	draw_text(text_position_x + 3, text_position_y + 2, text_contents);

	//Tidy.
	draw_set_font(global.font_default);
}