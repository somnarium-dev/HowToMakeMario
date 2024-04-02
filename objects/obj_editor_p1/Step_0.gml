// Create the player object and store its instance id.
global.player_data[global.current_player].current_id = instance_create_layer(x + x_offset, y + y_offset, "Players", obj_player1);

instance_destroy();