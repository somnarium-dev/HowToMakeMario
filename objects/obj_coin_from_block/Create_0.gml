// Inherit the parent event
event_inherited();

//Load custom methods.
event_user(0);
event_user(1);

//Configuration.
process_collision_detection = false;
gravity_context = gravity_type.coin;

//Internal functionality.
popup_strength = 8; //The "jump" strength of the coin.
ending_y_position = y - 16; //The y position where the coin vanishes after falling.

//Initialize.
y -= 16; // Causes the coin to "appear" above the block when produced.
v_speed = -popup_strength; //Causes the coin to "jump".