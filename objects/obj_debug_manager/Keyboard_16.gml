var player_1 = global.player_1.current_id;

if (player_1 == noone)
|| (!instance_exists(player_1))
{ exit; }

if (keyboard_check(vk_delete))
{ player_1.adjustment_h_pixels -= 1; }

if (keyboard_check(vk_pagedown))
{ player_1.adjustment_h_pixels += 1; }

if (keyboard_check(vk_home))
{ player_1.adjustment_v_pixels -= 1; }

if (keyboard_check(vk_end))
{ player_1.adjustment_v_pixels += 1; }

if (keyboard_check(vk_pageup))
{ player_1.inflicted_h_speed = +5; }

if (keyboard_check(vk_insert))
{ player_1.inflicted_h_speed = -5; }

if (keyboard_check(vk_backspace))
{ player_1.marked_for_death = true; }

if (keyboard_check_pressed(ord("C")))
{
	if (!layer_exists("Collision")) { exit; }
	
	var visibility = layer_get_visible("Collision")
	layer_set_visible("Collision", !visibility);
}