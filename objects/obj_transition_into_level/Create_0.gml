// Load custom methods.
event_user(1);

// Create the surface used to draw the iris effect.
transition_surface = surface_create(global.focal_width, global.focal_height);

// These are used to control the size of the iris effect.
max_radius = ceil(sqrt(sqr(global.focal_width) + sqr(global.focal_height)) / 2) + 2;
percent_displayed = 1;

draw_x_out = obj_world_player.x + 8;
draw_y_out = obj_world_player.y + 8;
draw_x_in = round(global.focal_width / 2);
draw_y_in = round(global.focal_height / 2);
draw_r = round(max_radius * percent_displayed);

// Internal functionality.
timer = 0;

show_start_message = false;

// When irising out to a level, the iris moves slowly, then quickly.
// These values control what percentage of the iris progresses at each speed.
slow_iris_percentage = 0.4;
normal_iris_percentage = 1 - slow_iris_percentage;

// Initialize.
state = transition_out_slow;

// Trigger the transition pause. All objects temporarily halt execution when this = true.
global.pause_during_transition = true;

// Play the sound.
fadeoutBGM(90);
playSFX(sfx_enterlevel);