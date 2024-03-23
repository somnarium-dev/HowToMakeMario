global.pause_during_transition = true;

transition_surface = surface_create(global.focal_width, global.focal_height);

max_radius = ceil(sqrt(sqr(global.focal_width) + sqr(global.focal_height)) / 2) + 2;
percent_displayed = 1;

draw_x = round(global.focal_width / 2);
draw_y = round(global.focal_height / 2);
draw_r = round(max_radius * percent_displayed);

timer = 0;

//Load state code.
event_user(1);

state = transition_out;