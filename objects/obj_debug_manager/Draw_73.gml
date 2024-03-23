if (!global.show_debug_data) { exit; }

var player_1 = global.player_1.current_id;

if (player_1 == noone)
|| (!instance_exists(player_1))
{ exit; }

draw_set_font(global.font_system);
draw_set_color(c_white);

var draw_x = camera_get_view_x(view) + 16;
var draw_y = camera_get_view_y(view) + 16;

draw_text(draw_x, draw_y, $"H_SPEED: {player_1.h_speed}")

draw_x += 16;
draw_y += 32;

var pixel_adjust = 9;

var draw_offsets =	[];
draw_offsets[0] =	[pixel_adjust,0];
draw_offsets[45] =	[pixel_adjust,-pixel_adjust];
draw_offsets[90] =	[0,-pixel_adjust];
draw_offsets[135] = [-pixel_adjust,-pixel_adjust];
draw_offsets[180] = [-pixel_adjust,0];
draw_offsets[225] = [-pixel_adjust, pixel_adjust];
draw_offsets[270] = [0, pixel_adjust];
draw_offsets[315] = [pixel_adjust, pixel_adjust];

for (var i = 0; i < 360; i += 45;)
{
	var new_color = c_green;
	
	if (player_1.all_nearby_collisions[i])
	{ new_color = c_red; }
	
	draw_set_color(new_color);
	
	var x_offset = draw_offsets[i][0];
	var y_offset = draw_offsets[i][1];
	
	var this_x = draw_x + x_offset;
	var this_y = draw_y + y_offset;
	
	draw_rectangle(this_x, this_y, this_x + 8, this_y + 8, false);
}

draw_set_color(c_white);

draw_x -= 16;
draw_y += 32;

draw_text(draw_x, draw_y, "GRAVITY:");

var data_point_1 = global.gravity_direction;
var data_point_2 = global.gravity_data[player_1.gravity_context].strength;
var data_point_3 = global.gravity_data[player_1.gravity_context].terminal_velocity;

draw_text(draw_x + 64, draw_y, $"{data_point_1}, {data_point_2}, {data_point_3}");

draw_y += 12;

draw_text(draw_x, draw_y, "I.V_SPEED");
draw_text(draw_x + 64, draw_y, $"{player_1.inflicted_v_speed}");

draw_y += 12;

draw_text(draw_x, draw_y, "V_SPEED");
draw_text(draw_x + 64, draw_y, $"{player_1.v_speed}");