//Draw detection range.
var this_color = threat_detected ? c_red : c_lime;

draw_set_color(this_color);
draw_set_alpha(0.5);

draw_rectangle
(
	x + range_x1,
	y + range_y1,
	x + range_x2 - 1, //Why do we have to do this?? Inaccurate display otherwise.
	y + range_y2,
	false
)

//Reset.
draw_set_color(c_white);
draw_set_alpha(1);