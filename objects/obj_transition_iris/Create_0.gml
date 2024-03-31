// Load custom methods.
event_user(1);

// Create the surface used to draw the iris effect.
transition_surface = surface_create(global.focal_width, global.focal_height);

// These are used to control the size of the iris effect.
max_radius = ceil(sqrt(sqr(global.focal_width) + sqr(global.focal_height)) / 2) + 2;
percent_displayed = 1;

draw_x = round(global.focal_width / 2);
draw_y = round(global.focal_height / 2);
draw_r = round(max_radius * percent_displayed);

// Internal functionality.
timer = 0;

// Initialize.
state = transition_out;

// Trigger the transition pause. All objects temporarily halt execution when this = true.
global.pause_during_transition = true;